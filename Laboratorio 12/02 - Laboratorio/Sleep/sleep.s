
/**********************************************************************/
/*         Autor: Pablo Sao                                           */
/*         Fecha: 05 de mayo de 2019                                  */
/*   Descripcion: uso de funcion sleep de libreria de C               */
/**********************************************************************/

.text
.align 2
.global main
.type main, %function

main:
	STMFD SP!, {LR}
	
	LDR   R0, =msj
	BL    puts
	
	BL    espera
	
	BL    _exit

espera:
	PUSH  {LR}

	mov	r3, #3
	mov	r0, r3
	bl	sleep
	nop
	
	POP   {PC}


_exit:
	LDMFD SP!,{LR}
	MOV   R7, #1
	SWI   0
	BX    LR


.data
.align 2
msj:
	.ascii "Esperando 3 segundos para cerrar"
