/*************************************************************/
/* 	 Autor: Pablo Sao				     */
/* 	 Fecha: 1 de abril de 2019			     */
/* Descripcion: Verifica cantidad de numeros positivos de un */
/*		listado de 5 numeros			     */
/*************************************************************/

.text
.align 2
.global main
.func main


main:
	MOV R0, #0              	@ inicializando contador
	MOV R3, #1


arma_loop:
	CMP   R0, #5               	@ comparamos si es 5
	BEQ   establecio_numeros  	@ si es 5, salimos del loop
	LDR   R1, =vector            	@ obtenemos la direccion del array
	LSL   R2, R0, #2          	@ multiplicamos el indice * 4 para obtener la direccion del array
	ADD   R2, R1, R2          	@ R2 tiene direccion del array

	CMP   R3,#3                   	@ Si R3 == 3
	MOVEQ R3,#-3                	@ R3 <- -3

	STR   R3, [R2]            	@ escribimos contador en a[i], R2[i] <- R3

	ADD   R0, R0, #1          	@ incrementamos contador R0 <- R0 + 1
	ADD   R3, R3, #1
	B     arma_loop           	@ regresamos al loop

establecio_numeros:


	/* imprimiento mensaje */
    	LDR   R0, =mensaje_array       	@ cargando mensaje
	BL    printf			@ imprimiento en consola

	MOV   R0,#0
	MOV   R3,#0

lee_loop:
    	CMP   R0, #5              	@ comparamos si es 5
    	BEQ   termina_id          	@ salimos si es 5, termina el loop
    	LDR   R1, =vector               @ obtenemos la direccion del vector
   	LSL   R2, R0, #2          	@ multiplicamos el indice * 4 para obtener la direccion del array
    	ADD   R2, R1, R2          	@ asignamos a R2 la direccion del array
    	LDR   R1, [R2]            	@ leemos el contenido del array, R1 <- a[i]

	CMP   R1,#0			@ si R1 > 0
	@ADDMI R3,R3,#1			@ si R1 < 0: R3 <- R3 + 1
	ADDGT R3,R3,#1			@ si R1 > 0: R3 <- R3 + 1

	PUSH  {R3}
	PUSH  {R0}               	@ backup register before printf
	PUSH  {R1}               	@ backup register before printf
    	PUSH  {R2}               	@ backup register before printf


	MOV   R2, R1              	@ se mueve valor del array a R2
    	MOV   R1, R0              	@ se mueve el indice del array a R1

	BL    imprime             	@ branch to print procedure with return

	POP   {R2}                	@ restore register
    	POP   {R1}                	@ restore register
    	POP   {R0}                	@ restore register

	POP   {R3}

	ADD   R0, R0, #1          	@ increment index
    	B     lee_loop            	@ branch to next loop iteration

termina_id:
    	B     _exit             @ exit if done

_exit:
    	LDR   R0, =resultado	@ cargamos el string de resultado
	
	MOV   R1, R3		@ R1 <- R3
    	BL    printf		@ mostramos el resutlado

	SWI   0                 @ execute syscall
    	MOV   R7, #1            @ R7 <- 1, syscall para terminar programa
    	SWI   0                 @ execute syscall

imprime:
   	PUSH  {LR}               	@ store the return address

    	LDR   R0, =printf_str     	@ R0 contains formatted string address
    	BL    printf               	@ call printf
    	POP   {PC}                	@ restore the stack pointer and return

.data
.align 2
vector:
	.skip 20

printf_str:
	.asciz "a[%d] = %d\n"

resultado:
	@.asciz "\nNumeros Negativos: %d\n\n"
	.asciz "\nNumeros Positivos: %d\n\n"

mensaje_array:
	.ascii "\nListado a Evaluar:\n"


