.data
	espressione: .word 18, 25, 10, 7, -2, -3, -1, 13, -2
	tabella: .word somma, sottrazione, moltiplicazione, divisione

.text
.globl main
.ent main

main: 
	
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, espressione
	li $a1, 9
	jal calcolaPolaccaInversa
  add $s0,$v0,$0
	lw $ra, ($sp)
	addu $sp, $sp, 4
	jr $ra
	.end main
	
calcolaPolaccaInversa:

	addi $sp, $sp, -4
	sw $ra,($sp)
	
	move $t0, $a0
	move $t1, $a1
	li $t2,0
	
	loop:
		
		lw $t3,($t0)
		
		blt $t3,0,chiamataOperazione
		
		addi $sp,$sp,-4
		sw $t3,($sp)
		j fatto
		
		chiamataOperazione:
			add $a0, $t3, $0
			lw $a1,4($sp)
			lw $a2,0($sp)
			
			addi $sp, $sp, -8
			sw $t0,4($sp)
			sw $t1,0($sp)
			
			jal eseguiOperazione
			
			lw $t1,0($sp)
			lw $t0,4($sp)
			addi $sp,$sp, 8
			
			addi $sp, $sp, 8
			addi $sp, $sp, -4
			sw $v0,($sp)
			
		fatto:
			addi $t0,$t0,4
			addi $t2,$t2,1
			bne $t2,$t1,loop

	addi $sp, $sp, 4
	lw $ra,($sp)
	addi $sp, $sp, 4
	.end calcolaPolaccaInversa

eseguiOperazione:
	
	subu $t0, $zero, $a0
	subu $t0, $t0, 1
	sll $t0, $t0, 2
	lw $t1, tabella($t0)
	jr $t1
	
	somma: 
		addu $v0, $a1, $a2
		b fine
	
	sottrazione: 
		subu $v0, $a1, $a2
		b fine
	
	moltiplicazione: 
		mulou $v0, $a1, $a2
		b fine

	divisione: 
		divu $v0, $a1, $a2
		b fine
	
	fine: 
		jr $ra
