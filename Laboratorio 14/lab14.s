/************************************************************************************/
/*         Autor: Pablo Sao                                                         */
/*         Fecha: 17 de mayo de 2019                                                */
/*   Descripcion: Encendido de LED con diferentes tiempos.                          */
/************************************************************************************/

.text
.align 2
.global main
.type main, %function

main:
	STMFD SP!, {LR}

	@**   Configurando pines de salida
	BL   GetGpioAddress			@ Llamamos dirección

	/**   Configurando puertos para control de stepper   **/
	MOV  R0, #14				@ Seteamos pin 
	MOV  R1, #1					@ Configuramos salida
	
	BL   SetGpioFunction


	B     _running


_running:

	@** Limpiando terminal
	LDR   R0, =CLEAR
	BL    puts

	@**   Despliegue de menú
	LDR   R0, =menu
	BL    puts

	@** Indicando que ingrese opción del menú
	LDR   R0, =msjOpcion
	BL    puts
	
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

	@**   Configuración por software
	CMP   R0, #1
	BLEQ  _opcion1

	@**   Configuración por hardware
	CMP   R0, #2
	BLEQ  _opcion2 

	@**   Impresión de configuración
	CMP   R0, #3
	BLEQ  _opcion3

	CMP   R0, #4
	BLEQ   _exit
	BLGT _error


@****    Error de ingreso de primer ciclo
_error:
	LDR   R0, =opcionIn				@ Cargamos dirección de opción
	MOV   R1, #0
	STR   R1,[R0]					@ Restauramos valor inicial en 0
	BL    getchar

	LDR   R0, =msjError				@ Mostramos mensaje de error a usuario
	BL    puts

	@ Esperamos 3 segundos para mostrar mensaje de error.
	MOV   R0, #3
	BL    ESPERASEG

	B     _running					@ Regresamos a rutina de ejecución


_opcion1:


	MOV   R6, #5
	blink1:
		PUSH {R6}

		BL   ENCENDIDO		@ Encendiendo pin 24

		MOV  R0, #1
		BL   ESPERASEG		@ Espera de 1 segundos

		BL   APAGADO		@ Apagando pin 24

		MOV  R0, #1
		BL   ESPERASEG		@ Espera de 1 segundo

		POP  {R6}

		SUBS R6, #1
		CMP  R6, #0
		BNE  blink1

	B   _running


_opcion2:


	MOV   R6, #2
	blink2:
		PUSH {R6}

		BL   ENCENDIDO		@ Encendiendo pin 24
		
		MOV  R0, #2
		BL   ESPERASEG		@ Espera de 2 segundos

		BL   APAGADO		@ Apagando pin 24

		MOV  R0, #2
		BL   ESPERASEG		@ Espera de 2 segundos

		POP  {R6}

		SUBS R6, #1
		CMP  R6, #0
		BNE  blink1

	B   _running


_opcion3:
	

	MOV   R6, #2
	blink3:
		PUSH  {R6}
		
		BL   ENCENDIDO			@ Encendiendo pin 24

		MOV  R0, #4				@ Espera de 4 segundos 
		BL   ESPERASEG

		BL   APAGADO			@ Apagado pin 24

		MOV  R0, #4
		BL   ESPERASEG			@ Espera de 4 segundos 

		POP  {R6}
		SUBS R6, #1
		CMP  R6, #0
		BNE  blink1

	B   _running

@****    Apagando Salidas
APAGADO:  
	PUSH  {LR}
	
	@**   apagando pin 24
	MOV   r0,#14
	MOV   r1,#0
	BL    SetGpio
	
	POP   {PC}
	
@****    Apagando Salidas
ENCENDIDO:  
	PUSH  {LR}
	
	@**   apagando pin 24
	MOV   r0,#14
	MOV   r1,#1
	BL    SetGpio
	
	POP   {PC}
	
.align 2
.global ESPERASEG
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
	.ascii "\tOpciones de Control\n\t1) Tiempo 1 Segundo.\n\t2) Tiempo 2 Segundos.\n\t3) Tiempo 4 segundos.\n\t4) Salir."

.align 2
msjOpcion:
	.asciz "Ingrese Opción:"


.align 2
CLEAR:
	.asciz "\033[H\033[J"

.align 2	
fIngreso:
	.asciz "%d"

.align 2
opcionIn:
	.word 0

.align 2
myloc:
	.word 0

.align 2
msjError:
	.ascii "Opcion incorrecta\n"
	
