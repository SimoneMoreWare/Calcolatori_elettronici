.data
	mVett: .word 4, 5, 7, 3, 2, 1, 50, 4, -1
	DIM = 9
	
.text
.globl main
.ent main

main:

	la $a0, mVett
	addi $a1,$0,DIM
	
	jal massimo
	
	add $s0,$v0,$0
	
	li $v0, 1
	add $a0,$s0,$0
	syscall
	
	li $v0, 10
	syscall
	.end 
	
.globl massimo
.ent massimo

massimo:

	add $t0,$t0,$a0
 
	lw $t1,($t0) #max
	
	addi $t0,$t0,4
	
	li $t2,1
	
	loop:
		
		lw $t3,($t0)
		blt $t3,$t1,incrementi
		add $t1, $t1, $t3
		sub $t3, $t1, $t3
		sub $t1, $t1, $t3
		incrementi:
			addi $t0,$t0,4
			addi $t2,$t2,1
			bne $t2,DIM,loop
			
	add $v0,$0,$t1
	
	jr $ra
		
