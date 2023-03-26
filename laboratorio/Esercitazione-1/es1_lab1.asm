.data
	n1: .byte 10
	n2: .byte 0x10
	n3: .byte '1'
	res: .space 1
	
.text
.globl main
.ent main

main:
	
	
	lb $t1,n1
	
	lb $t2,n2
	
	lb $t3,n3
	
	sub $t0,$t1,$t2
	
	add $t0,$t0,$t3
	
	sb $t0,res
	
	li $v0,10
	syscall
	.end main
