
/********************************************************************/
/* 	  Autor: Pablo Sao					    */
/* 	  Fecha: 6 de abril de 2019				    */
/*  Descripcion: encriptacion de palabra de 10 caracteres cambiando */
/* 		 el 4 bit (ascii) por 0 de cada caracter	    */
/********************************************************************/


@area de codigo
.text
.align 2
.global main
.type main,%function

main:
	STMFD SP!,{LR}
	
	
	LDR   R0, =sol_ingreso		@ cargando direccion de mensaje
	BL    puts			@ mostrando mensaje en pantalla

	/* Lectura de teclado */
	MOV   R7, #3			@ syscall	
	MOV   R0, #0			@ lectura de pantalla
	MOV   R2, #10			@ lee los primeros 10 caracteres
	LDR   R1, =ingreso              @ variable donde se almacena el contenido
	SWI   0

	LDR   R4, =ingreso	@ Cargamos direccion de mensaje
	MOV   R5, #10		@ iniciamos el contador
	MOV   R6, #0		@ indice de caracter


cambiaCH:
	
	@Cargar datos del arreglo caracteres e imprimirlo
	
	LDRB  R1,[R4,R6] @cargar byte
	
	CMP   R1, #0x21
	ANDGE R1,R1,#0xF7
	
	STRB  R1,[R4,R6]
	@LDR   R0,=resultado
	@BL    printf
	
	ADD   R6,#1
	SUBS  R5,#1
	CMP   R5,#0
	BNE   cambiaCH

_exit:
	LDR   R0, =ingreso
	BL    puts
	
	LDMFD SP!,{LR}
	BX    LR


.data
.align 2

prueba:
	.asciz "hola mundo"

resultado:
	.asciz "%c "

str_resultado:
	.asciz "%s\n"

sol_ingreso:
	.asciz "Ingrese palabra: "

ingreso:
	.asciz "%s"

