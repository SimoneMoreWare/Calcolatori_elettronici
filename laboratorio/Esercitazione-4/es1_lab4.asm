.data
	vett: .space 80
	newLine: .asciiz "\n"
	
.text
.globl main
.ent main

main:
	
	la $t0, vett
	li $t1, 2	
	li $t2, 1
	li $t3, 1
	
	sw $t2, 0($t0)
	sw $t3, 4($t0)	
	addi $t0,$t0,8
	loop:
		add $t4,$t2,$t3				
		sw $t4,0($t0)	
		add $t2,$t3,$0
		add $t3,$t4,$0
		addi $t1,$t1,1
		addi $t0,$t0,4
		bne $t1,20,loop
	
	li $t1, 0
	la $t0,vett
	
	print:
		li $v0, 1
		lw $a0,0($t0)
		syscall
		li $v0, 4
		la $a0, newLine
		syscall
		addi $t0,$t0,4
		addi $t1,$t1,1
		bne $t1,20,print
		
	
	li $v0, 10
	syscall
	.end main
		
	
