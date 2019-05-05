
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

	@** Lectura de  teclado
	LDR   R0, =formatoIngreso
	LDR   R1, =opcionIngreso
	BL    scanf

	@**   verificamos que se haya ingresado un número
	CMP   R0, #0
	BEQ   _error

	LDR   R1, =opcionIngreso
	LDR   R1, [R1]

	B     _exit
	


_error:
	LDR   R0, =opcionIngreso
	MOV   R1, #0
	STR   R1,[R0]
	BL    getchar
	
	LDR   R0, =msjError
	BL    puts
	
	B     main



@****    Metodo de espera utilizando libreria de C
_espera:
	PUSH  {LR}

	MOV   R0, #6				@ Esperamos 5 segundos aproximadamente
	bl    sleep
	NOP
	
	POP   {PC}

_exit:
	LDMFD SP!,{LR}
	MOV   R7, #1
	SWI   0
	BX    LR

.data

.align 2
msjIngreso:
	.ascii "Ingrese 1 numero del 1 al 9 (1 caracter): "

.align 2
msjError:
	.asciz "\n\tIngreso un valor invalido\n"
	
.align 2
formatoIngreso:
	.asciz "%d"

.align 2
opcionIngreso:
	.word 0

.align 2
display:
	.asciz "Número: %c\n"

