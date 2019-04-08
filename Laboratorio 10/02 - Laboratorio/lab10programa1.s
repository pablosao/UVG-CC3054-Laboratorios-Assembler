
/********************************************************************/
/* 	  Autor: Pablo Sao					    */
/* 	  Fecha: 8 de abril de 2019				    */
/*  Descripcion: revierte el orden del vector de digitos  */
/* 		 ingresado por el usuario	    */
/********************************************************************/


.text
.align 2
.global main
.type main,%function

main:
	STMFD SP!,{LR}	
	
	LDR   R0, =sol_ingreso		@ cargando direccion de mensaje
	BL    puts					@ mostrando mensaje en pantalla

	MOV   R4, #10				@ Contador para ingreso de datos
	LDR   R5, =dvector			@ dirección del vector
	LDR   R8, #0				@ indice del vector


cargaVector:
	
	LDR   r0,=in_msj			@ cargamos mensaje para ingreso de datos
	BL    puts					@ mostramos mensaje de ingreso
	
	LDR   R0,=ingreso
	LDR   R1,=valor
	BL    scanf
	
	LDR   R1,[R1]
	STRB  R1,[R5,R8]
	
	
	/* comparación para hacer ciclo */
	SUBS  R8,#1
	CMP   R8,#0
	BNE   cargaVector


	LDR   R4, =dvector
	MOV   R8, #10
	MOV   R6, #0
	
imprimeV:

	@Cargar datos del arreglo caracteres e imprimirlo
	
	LDRB  R1,[R8,R6] @cargar byte

	LDR   R0,=display
	BL    printf
	
	ADD   R6,#1
	SUBS  R8,#1
	CMP   R8,#0
	BNE   imprimeV


_exit:
	
	LDMFD SP!,{LR}
	BX    LR

.data
.align 2

dvector:
	.word 0,0,0,0,0,0,0,0,0,0

ingreso:
	.asciz "%d"

in_msj:
	.asciz "Ingrese Numero: "

entrada:
	.asciz " %d"

valor:
	.word 0
	
display:
	.word "%d "
