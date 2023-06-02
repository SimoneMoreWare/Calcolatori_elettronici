.data
	DIM = 3
	mat1: .word 4, -45, 15565
		  .word 6458, 4531, 124
		  .word -548, 2124, 31000
		  
	mat2: .word 6, -5421, -547
		  .word -99, 4531, 1456
		  .word 4592, 118, 31999
		  
	res: .space 12

.text
.globl main
.ent main

main:

	la $a0, mat1
	la $a1, mat2
	la $a2, res
	li $a3, DIM
	addi $sp,$sp,-4
	li $t0, 2
	sw $t0,($sp)
	
	jal Variazione
	
	la $t0,res
	li $t1,0
	printLoop:
		
		li $v0, 1
		lw $a0,($t0)
		syscall
		li $v0, 11
		li $a0,' '
		syscall
		
		addi $t0,$t0,4
		addi $t1,$t1,1
		bne $t1,DIM,printLoop
	
	addi $sp,$sp,4
	li $v0, 10
	syscall
	.end main
	
.globl Variazione
.ent Variazione

Variazione:

	lw $t8,($sp)
	mul $t0,$a3,$t8
	sll $t0,$t0,2
	
	add $t0,$a0,$t0 #acceddo alla riga
	
	mul $t1,$t8,4
	add $t1,$t1,$a1
	
	add $t2,$a3,$0
	sll $t2,$t2,2 #quanto dista la colonna succesiva
	
	li $t3,0
	add $t7,$a2,$0
	
	loop:
		
		lw $t4,($t0)
		lw $t5,($t1)	

		sub $t5,$t5,$t4
		mul $t5,$t5,100
		div $t5,$t4
		mflo $t6
		
		sw $t6,($t7)
		addi $t7,$t7,4
		
		addi $t0,$t0,4
		add $t1,$t1,$t2
		addi $t3,$t3,1
		bne $t3,$a3,loop

	jr $ra
	.end Variazione
