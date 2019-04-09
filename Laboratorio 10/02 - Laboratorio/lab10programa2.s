
/********************************************************************/
/* 	  Autor: Pablo Sao					    */
/* 	  Fecha: 8 de abril de 2019				    */
/*  Descripcion: convierte de minuscula a mayuscula el nombre       */
/* 		 ingresado por el usuario	                    */
/********************************************************************/


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

	@LDR   R4, =prueba   	@ cargando prueba estatica

cambiaCH:
	
	@Cargar datos del arreglo caracteres e imprimirlo
	
	LDRB  R1,[R4,R6] 	@ carga byte [char] de la cadena
	
	/*  Cambio a mayusculas   */
	
	CMP   R1, #0x60		@ si R1 > 0x60 (hex ascii) 
	
	/*
		La idea principal era permitir solo minusculas
		pero al hacerlo solo tomaba los caracteres antes
		de un espacio ingresado, por lo que se quito para
		poder ingresar espacio.
	*/

	@ CMPGT R1, #0x7B
	@ SUBLT R1,R1,#0x20	@ Restamos 0x20, minuscula a mayuscula
	
	SUBGT R1, R1, #0x20	@ Restamos 0x20, minuscula a mayuscula

	STRB  R1,[R4,R6]	@ guardamos char en la posición tomada
	
	ADD   R6,#1
	SUBS  R5,#1
	CMP   R5,#0
	BNE   cambiaCH

_exit:
	LDR   R0, =ingreso	@ cargamos formato de impresión
	BL    puts
	
	LDMFD SP!,{LR}
	BX    LR


.data
.align 2

prueba:
	.asciz "hola mundo"

sol_ingreso:
	.asciz "Ingrese su nombre (10 caracteres max.): "

ingreso:
	.asciz "%s"
