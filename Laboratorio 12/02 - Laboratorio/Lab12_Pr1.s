
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

	LDR   R0, =msjIngreso 			@ dirección de mensaje
	BL    puts

	@** Lectura de  teclado, mediante Interrupcion de OS

	MOV   R7, #3				@ codigo de interrupcion para lectura
	MOV   R0, #0				@ indicando que es en monitor
	MOV   R2, #1				@ solo leeremos 1 caracter
	LDR   R1, =dataIn
	SWI   0

	LDR   R1, =dataIn
	LDRB   R1, [R1]

	CMP   R1, #0x30				@ Si R1 >= 0
	CMPGE R1, #0x39				@    & R1 <= 9
	BLLE  _esNumero

	B     _esCaracter
	

_esNumero:
	LDR   R0, =displayNum
	BL    printf

	BL    _exit

_esCaracter:
	LDR   R0, =displayCh
	BL    printf

	BL    _exit

_exit:
	LDMFD SP!,{LR}
	MOV   R7, #1
	SWI   0
	BX    LR

.data

.align 2
msjIngreso:
	.ascii "Ingrese 1 caracter (número o letra): "

.align 2
dataIn:
	.ascii ""

.align 2
displayNum:
	.asciz "Número: %c\n"

.align 2
displayCh:
	.asciz "Caracter: %c\n"
