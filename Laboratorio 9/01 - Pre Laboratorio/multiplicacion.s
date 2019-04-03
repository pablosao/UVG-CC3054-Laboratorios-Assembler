/****************************************************************/
/* 	      Autor: Pablo Sao 					*/
/*	      Fecha: 22 de marzo de 2019			*/
/*	Descripción: Mmuestra resultado de multiplicación	*/
/****************************************************************/
/* 	      Autor: Pablo Sao 					*/
/*	      Fecha: 20 de marzo de 2019 			*/
/*	Descripción: Multiplicación de dos números en memoria	*/
/****************************************************************/
	.text	
	.align 2
	.global main 
	
main:
		
	/* Multiplicación de dos números */
		
	MOV R3, #5
	MOV R2, #10
	MUL R1,R3,R2	@ R1 <- R3 * R2	
	
	LDR R0,=string
	BL printf

	MOV R0, #0
	B _exit
 
_exit:
	MOV R7,#1
	SVC 0 		@ Pasando al OS

.data
.align 2
	string: 
		.asciz "Resultado: %d\n"	@ Resultado de la Multiplicación
