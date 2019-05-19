

/************************************************************************************/
/*         Autor: Pablo Sao                                                         */
/*         Fecha: 09 de mayo de 2019                                                */
/*   Descripcion: Control de dirección y vueltas de un motor steeper, por medio     */
/*				  de software (terminal) y hardware (Circuito electronico).         */
/************************************************************************************/

.text
.align 2
.global main
.type main, %function

main:
	STMFD SP!, {LR}

	@**   Configurando pines de salida
	BL   GetGpioAddress			@ Llamamos dirección

	/******************************
	 *  Configurando salida LEDs  *
	 ******************************/
	MOV  R0, #14				@ Seteamos pin 14
	MOV  R1, #1					@ Configuramos salida

	BL   SetGpioFunction		@ Configuramos puerto

	MOV  R0, #15				@ Seteamos pin 15
	MOV  R1, #1					@ Configuramos salida

	BL   SetGpioFunction

	@ Apagando LED
	MOV R0, #14
	MOV   R1, #0

	BL   SetGpio

	MOV R0, #15
	MOV   R1, #0

	BL   SetGpio

	B    _running


_running:
	@ limpiando terminal
	LDR   R0, =CLEAR
	BL    puts

	@**   Despliegue de menú
	LDR   R0, =menu
	BL puts

	@**   Mensaje de ingreso de opción:
	LDR   R0, =msjOpcion
	BL puts

	@**   Comando para Ingreso de teclado
	LDR   R0, =fIngreso
	LDR   R1, =opcionIn
	BL    scanf

	@**   verificamos que se haya ingresado un número
	CMP   R0, #0
	BEQ _error

	@**   Identificación de operaciones
	LDR   R0, =opcionIn
	LDR   R0, [R0]

	@**   LED 1
	CMP   R0, #1
	LDREQ R1, =numLed
	STREQ R0, [R1]
	BLEQ  _subMenu

	@**   LED 2
	CMP   R0, #2
	LDREQ R1, =numLed
	STREQ R0, [R1]
	BLEQ  _subMenu

	CMP   R0, #3
	BLEQ   _exit
	BLGT _error

_subMenu:
	@ limpiando terminal
	LDR   R0, =CLEAR
	BL    puts

	@**   Despliegue de menú
	LDR   R0, =menu2
	BL puts

	@**   Mensaje de ingreso de opción:
	LDR   R0, =msjOpcion
	BL puts

	@**   Comando para Ingreso de teclado
	LDR   R0, =fIngreso
	LDR   R1, =opcionIn
	BL    scanf

	@**   verificamos que se haya ingresado un número
	CMP   R0, #0
	BEQ _error2

	@**   Identificación de operaciones
	LDR   R0, =opcionIn
	LDR   R0, [R0]

	@**   Encendido de LED
	CMP   R0, #1
	BLEQ  onLED

	@**   Apagado de LED
	CMP   R0, #2
	BLEQ  offLED

	@**   Alternación de LED
	CMP   R0, #3
	BLEQ  ingresoRepeticion

	CMP   R0, #4
	BLEQ   _running
	BLGT _error2


ingresoRepeticion:
	@**   Despliegue de menú
	LDR   R0, =msjIngreso
	BL puts

	@**   Comando para Ingreso de teclado
	LDR   R0, =fIngreso
	LDR   R1, =opcionIn
	BL    scanf

	@**   verificamos que se haya ingresado un número
	CMP   R0, #0
	BEQ _error2

	@**   Identificación de operaciones
	LDR   R0, =opcionIn
	LDR   R5, [R0]

	loop:
		BL    alternacion

		SUBS  R5, #1
		CMP   R5, #0
		BNE   loop

	BLEQ   _subMenu

	


onLED:
	PUSH  {LR}
	LDR   R3, =numLed
	LDR   R3, [R3]

	CMP   R3, #1
	MOVEQ R0, #14
	MOVNE R0, #15
	MOV   R1, #1

	BL   SetGpio

	POP   {PC}

offLED:
	PUSH  {LR}
	LDR   R3, =numLed
	LDR   R3, [R3]

	CMP   R3, #1
	MOVEQ R0, #14
	MOVNE R0, #15
	MOV   R1, #0

	BL   SetGpio

	POP   {PC}

alternacion:
	PUSH  {LR}
	BL    onLED

	MOV   R0, #1
	BL    ESPERASEG

	BL    offLED

	MOV   R0, #1
	BL    ESPERASEG

	POP   {PC}


@****    Error de ingreso de primer ciclo
_error:
	LDR   R0, =opcionIn				@ Cargamos dirección de opción
	MOV   R1, #0
	STR   R1,[R0]					@ Restauramos valor inicial en 0
	BL    getchar

	LDR   R0, =msjError				@ Mostramos mensaje de error a usuario
	BL    puts

	@ Esperamos 3 segundos para mostrar mensaje de error.
	MOV   R0, #2
	BL    ESPERASEG

	B     _running					@ Regresamos a rutina de ejecución

@****    Error de ingreso de primer ciclo
_error2:
	LDR   R0, =opcionIn				@ Cargamos dirección de opción
	MOV   R1, #0
	STR   R1,[R0]					@ Restauramos valor inicial en 0
	BL    getchar
	B     _subMenu					@ Regresamos a rutina de ejecución

@****    Error de ingreso de primer ciclo
_error3:
	LDR   R0, =opcionIn				@ Cargamos dirección de opción
	MOV   R1, #0
	STR   R1,[R0]					@ Restauramos valor inicial en 0
	BL    getchar

	B     ingresoRepeticion					@ Regresamos a rutina de ejecución


@****    Recibe en R0 los segundos a esperar
.align 2
ESPERASEG:
	PUSH  {LR}

	BL    sleep		@ Espera tiempo pasado en R0
	NOP

	POP   {PC}

_exit:
	LDMFD SP!,{LR}
	MOV   R7, #1
	SWI   0
	BX LR


.data
.align 2
menu:
	.asciz "\t\tMenu\n\t1) Led 1.\n\t2) Led 2.\n\t3) Salir."

menu2:
	.asciz "\tOpciones\n\t1) Encender.\n\t2) Apagar.\n\t3) Alternar. \n\t4) Regresar."

.align 2
msjOpcion:
	.asciz "\n\nIngrese Opcion: "

.align 2
msjIngreso:
	.asciz "\nIngrese numero de repeticiones: "


.align 2
msjError:
	.asciz "\033[31;42m\n\t\tIngreso una opcion incorrecta.\033[0m\n"

.align 2	
fIngreso:
	.asciz "%d"

.align 2
CLEAR:
	.asciz "\033[H\033[J"


.align 2
.global myloc
myloc:
	.word 0

.align 2
numLed:
	.word 0

.align 2
repeticion:
	.word 0

.align 2
opcionIn:
	.word 0
