.data
	wVar: .word 3
	result: .space 4
.text
.globl main
.ent main

main:
	la $t0,wVar
	lw $t1,($t0)
	la $t2,result
	sw $t1,($t2)
	
	li $v0, 10
	syscall
.end main