.data
	w0pd1: .word 10
	w0pd2: .word 24
	wResult: .space 4
	
.text
.globl main
.ent main

main:
	la $t0,w0pd1
	lw $t0,($t0)
	
	la $t1,w0pd2
	lw $t1,($t1)
	
	add $t2,$t1,$t0
	la $t0,wResult
	sw $t2,($t0)
	
	li $v0,10
	syscall
	.end main
