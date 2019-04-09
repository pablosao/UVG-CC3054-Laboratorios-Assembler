
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
		
	
	MOV   R4, #10		@ Contador para ingreso de datos
	LDR   R5, =dvector	@ dirección del vector
	
cargaVector:
	
	LDR   r0,=in_msj	@ cargamos mensaje para ingreso de datos
	BL    puts		@ mostramos mensaje de ingreso
	
	LDR   R0,=ingreso
	LDR   R1,=valor
	BL    scanf

	/*  Cargando valor ingresado   */
	LDR   R1, =valor		@ dirección del valor ingresado
	LDR   R1, [R1]			@ cargamos valor de la direccion
	

	/*  Cargando posición del vector   */
	STR   R1,[R5]			@ almacenamos cambio
	

	ADD   R5, #4			
	SUBS  R4, #1			@ restamos control contador
	CMP   R4, #0			@ si R4 < 0
	BNE   cargaVector		@ salta al ciclo

	MOV   R4, #10			@ reseteamos contador de ciclo
	LDR   R5, =dvector		@ cargamos direccion de vector
	
	
	LDR   R0, =msj_vectorO
	BL    puts

/*   Imprime vector original   */

print_vectorO:
	
	LDR   R1,[R5]
	
	/*   Imprimiento datos ingresados - Prueba  */
	LDR   R0, =display
	BL    printf
	
	
	ADD   R5, #4
	SUBS  R4, #1
	CMP   R4, #0		
	BNE   print_vectorO 
	

	MOV   R4, #10
	LDR   R5, =dvector
	ADD   R5, #36
	
	MOV   R0, #0
	LDR   R0, =msj_vectorI
	BL    puts
	
/*   Imprime vector invertido  */

print_vectorI:
	
	LDR   R1,[R5]			@ dirección de vector
	
	/*   Imprimiento datos ingresados - Prueba  */
	LDR   R0, =display
	BL    printf
	
	
	SUB   R5, #4			@ R5 <- R5 - 4, Dirección vector
	SUBS  R4, #1			@ R4 <- R4 - 1, restando control ciclo
	CMP   R4, #0			@ salto a inicio de ciclo
	BNE   print_vectorI 
	
	
_exit:
	LDR   R0, =espacio		@ se carga dirección para imprimir
	BL    puts			@    salto de linea
	
	LDMFD SP!,{LR}
	BX    LR

.data
.align 2

dvector:
	.word 0,0,0,0,0,0,0,0,0,0

in_msj:
	.asciz "Ingrese Numero: "

ingreso:
	.asciz "%d"

valor:
	.word 0
	
display:
	.asciz "%d "

espacio:
	.asciz "\n"

msj_vectorI:
	.asciz "\n\nVector Invertido:\n"

msj_vectorO:
	.asciz "\n\nVector Original:\n"
