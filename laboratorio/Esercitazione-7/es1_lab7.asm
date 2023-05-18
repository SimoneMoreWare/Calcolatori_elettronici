
.text
.globl main
.ent main

main:

	li $t0, 4
	li $t1, 2
	li $t2, -5
	li $t3, 3
	
	li $s0, 8
	li $s1, 4
	li $s2, 27
	li $s3, 9
	li $s4, 64
	li $s5, 16
	
	add $a0,$t0,$t1
	add $a0,$a0,$t2
	add $a0,$a0,$t3
	
	mul $a1,$t0,$s0
	mul $t4,$t1,$s1
	add $a1,$a1,$t4
	sll $t4,$t2,1
	add $a1,$a1,$t4
	add $a1,$a1,$t3
	
	mul $a2,$t0,$s2
	mul $t4,$t1,$s3
	add $a2,$a2,$t4
	mul $t4,$t2,3
	add $a2,$a2,$t4
	add $a2,$a2,$t3
	
	mul $a3,$t0,$s4
	mul $t4,$t1,$s5
	add $a3,$a3,$t4
	sll $t4,$t2,2
	add $a3,$a3,$t4
	add $a3,$a3,$t3
	
	li $t5, 7
	
	addi $sp, $sp, -4
	sw $t5, 0($sp)
	
	jal polinomio
	
	addi $sp, $sp, 4
	
	add $s0,$v0,$0
	li $v0, 1
	add $a0,$s0,$0
	syscall
	
	li $v0, 10
	syscall
	.end main
	
.globl polinomio
.ent polinomio

polinomio:
	
	lw $t6, ($sp) #N

	addi $sp, $sp, -40
	
	sw $t0, 36($sp)
	sw $t1, 32($sp)
	sw $t2, 28($sp)
	sw $t3, 24($sp)
	sw $s0, 20($sp)
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $s3, 8($sp)
	sw $s4, 4($sp)
	sw $s5, 0($sp)
	
	
	sub $t0,$a1,$a0
	sub $t1,$a2,$a1
	sub $t2,$a3,$a2
	sub $s0,$t1,$t0
	sub $s1,$t2,$t1
	sub $s2,$s1,$s0
	add $v0,$a3,$0
	
	addi $t7,$t6,-4
	li $t8,0
	loop:
		add $s1,$s1,$s2
		add $t2,$t2,$s1
		addu $v0,$v0,$t2
		addi $t8,$t8,1
		bne $t8,$t7,loop
	
	lw $s5,0($sp)
	lw $s4,4($sp)
	lw $s3,8($sp)
	lw $s2,12($sp)
	lw $s1,16($sp)
	lw $s0,20($sp)
	lw $t3,24($sp)
	lw $t2,28($sp)
	lw $t1,32($sp)
	lw $t0,36($sp)
	addi $sp, $sp, 40
	jr $ra
	
	.end polinomio
