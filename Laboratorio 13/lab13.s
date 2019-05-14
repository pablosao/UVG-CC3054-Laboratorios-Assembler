
/**********************************************************************/
/*         Autor: Pablo Sao                                           */
/*         Fecha: 05 de mayo de 2019                                  */
/*   Descripcion: Si ingresa un número, enciente led en GPIO 17       */
/*                Si es un caracter, enciente led en GPIO 22          */
/**********************************************************************/

.text
.align 2
.global main
.type main, %function

main:
	STMFD SP!, {LR}

	@**   Configurando pines de salida
	BL    GetGpioAddress			@ Llamamos dirección

	MOV   R0, #14				@ Seteamos pin 14
	MOV   R1, #1					@ Configuramos salida

	BL    SetGpioFunction		@ Configuramos puerto

	MOV   R0, #15				@ Seteamos pin 15
	MOV   R1, #1					@ Configuramos salida

	BL    SetGpioFunction
	
	MOV   R0, #18					@ Seteamos pin 18
	MOV   R1, #1					@ Configuramos salida

	BL    SetGpioFunction
	
	MOV   R0, #23					@ Seteamos pin 17
	MOV   R1, #0					@ Configuramos entrada

	BL    SetGpioFunction
	
	@**   Apagando LED
	BL    _apagando
	
	B     loop

	loop:
		ldr  r0, =msj2				@ Control de bit
		bl   puts

		MOV   R1, #23
		BL    GetGpio
		
		TEQ   R5,#0
		MOVNE R12, #0
		BLNE  _run 
		BEQ     loop

		/*mov   r12, #0
		bl    _run */

	
_run:

	LDR  R0, =msj
	BL   puts

	ADDS  R12, #1
	CMP   R12, #4
	MOVEQ R12, #1

	
	BL    _espera
	BL    _apagando
	
	@BL    _espera

	MOV   R0, #14
	MOV   R1, #1
	BL    SetGpio
	
	BL    _espera
	BL    _apagando
	@BL    _espera

	MOV   R0, #15
	MOV   R1, #1
	BL    SetGpio
	
	BL    _espera
	BL    _apagando
	@BL    _espera

	MOV   R0, #18
	MOV   R1, #1
	BL    SetGpio
	
	BL    _espera
	BL    _apagando
	@BL    _espera


	MOV   R1, #23
	BL    GetGpio	
	TEQ   R5, #0
	BLEQ   _run

	B    _exit


_uno:
	PUSH  {LR}
	MOV   R0, #14
	MOV   R1, #1
	BL    SetGpio
	POP   {PC}
	
_dos:
	PUSH  {LR}
	MOV   R0, #15
	MOV   R1, #1
	BL    SetGpio
	POP   {PC}
	
_tres:
	PUSH  {LR}
	MOV   R0, #18
	MOV   R1, #1
	BL    SetGpio
	POP   {PC}
	
_exit:
	BL    _apagando

	LDMFD SP!,{LR}
	MOV   R7, #1
	SWI   0
	BX LR

@****    Apagando Salidas
_apagando:  
	PUSH  {LR}
	
	@**   apagando pin 14
	MOV   r0,#14
	MOV   r1,#0
	BL    SetGpio
	
	@**   apagando pin 15
	MOV   r0,#15
	MOV   r1,#0
	BL    SetGpio
	
	@**   apagando pin 18
	MOV   r0,#18
	MOV   r1,#0
	BL    SetGpio
	
	POP   {PC}
	
_espera:
	PUSH  {LR}

	MOV   R0, #1
	BL    sleep		@ Espera tiempo pasado en R0
	NOP

	POP   {PC}
	
	
.data
.align 2
.global myloc
myloc:
	.word 0


.align 2
msj:
	.asciz "Entro a corrimiento"


.align 2
msj2:
	.asciz "Loop"

