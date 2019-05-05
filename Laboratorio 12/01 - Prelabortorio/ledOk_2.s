@
@ GPIO demonstration code NJM
@ Just calls phys_to_virt (a C program that calls mmap())
@ to map a given physical page to virtual memory
@ Must be run as root of course :) Use at your own risk!
@
 .text
 .align 2
 .global main
main:
	@ Map GPIO page (0x3F200000) 
	@ to our virtual address space
 	ldr r0, =0x3F200000
 	bl phys_to_virt
 	mov r7, r0  @ r7 points to that physical page
 	ldr r6, =myloc
 	str r7, [r6] @ save

loop:	@GPIO para escritura
	mov r1,#1
	lsl r1,#18
	str r1,[r0,#4]

	@GPIO 16 low, enciende el led
	mov r1,#1
	lsl r1,#16
	str r1,[r0,#40]
	
	push {r0}
	bl wait
	pop {r0}
	
	@GPIO 16 low, apaga el led
	str r1,[r0,#28]
	
	push {r0}
	bl wait
	pop {r0}
	
	b loop

@ brief pause routine
wait:
	mov r0, #0x4000000 @ big number
sleepLoop:
	subs r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr

 .data
 .align 2
myloc: .word 0

 .end

