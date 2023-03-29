.data
	var: .word 0x3FFFFFF0
	
.text
.globl main
.ent main

main:
	
	la $t0,var
	lw $t1,($t0)
	sll $t1,$t1,1
	
	#li $v0,1
	#lw $a0,($t0)
	#syscall
	
	#addi $t2,$t1,40
	
	#aritmetic overflow
	#li $v0,1
	#lw $a0,($t2)
	#syscall
	
	#aritmetic overflow anche con add

	
	li $t2,40
	
	addu $a0,$t1,$t2
	
	li $v0,1
	syscall
	
	li $v0,10
	syscall
	.end main
