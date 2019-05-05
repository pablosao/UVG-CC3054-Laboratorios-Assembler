
/***************************************************************************/
/*       Autor: Pablo Sao                                                  */
/*       Fecha: 1 de mayo de 2019                                          */
/* Descripción: Promedio de dos valores de punto flotante                  */
/***************************************************************************/

.text
.align 2
.global main
.func main

main:
	MOV   R6, #10			@ Contador 
	BL    ingreso

@****    Ingreso de de datos para almacenar en vector
ingreso:
	LDR   R0, =msjin		@ Cargando dirección de mensaje
	BL    puts
	
	LDR   R0, =formatoin	@ingresa numero
	LDR   R1, =valingreso
	BL    scanf

	@**   verificamos que se haya ingresado un número
	CMP   R0, #0
	BLEQ  _error
	
	SUBS  R6, #1
	CMP   R6, #0
	BLNE  ingreso


_error:
	PUSH  {LR
	
	BL    getchar
	LDR   R0, =msjerror
	BL    puts	
	
	POP   {PC}

_exit:
	
	MOV   R7, #1		@ Código para salida de assembler
	SWI   0


dir_arreglo1:
	.word arreglo1

dir_arreglo2:
	.word arreglo2


@****   Area de datos

.data
.align 2
msjin:
	.ascii "Ingrese número: "

valingreso:
	.word 0
	
formatoin:
	.asciz "%f"

arreglo1:
	.float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

arreglo2:
	.float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0


display:
	.asciz " %f,"

formato:
	.asciz "%f"
	
msjerror:
	.ascii "Debe ingresar un valor númerico.\n"
