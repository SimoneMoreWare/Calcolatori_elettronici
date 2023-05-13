.text
.globl main
.ent main

main:

	li $v0, 5
	syscall
	add $a0,$v0,$0 #n
	
	li $v0, 5
	syscall
	add $a1,$v0,$0 #k
	
	jal combina
	
	add $s0,$v0,$0
	
	li $v0, 1
	add $a0,$s0,$0
	syscall

	li $v0, 10
	syscall
	.end main
	
.globl combina
.ent combina

combina:

	li $t0, 1 #numeratore
	li $t1, 0
	add $t3,$a1,$0
	
	loopNumeratore:
		mul $t0,$t0,$a0
		addi $a0,$a0,-1
		addi $t1,$t1,1
		bne $t1,$t3,loopNumeratore
		
	li $t2, 1 #denominatore
	li $t1, 0
	
	loopDenominatore:
		mul $t2,$t2,$a1
		addi $a1,$a1,-1
		addi $t1,$t1,1
		bne $t1,$t3,loopDenominatore
	
	div $t0,$t2
	
	mflo $t0
	
	add $v0,$t0,$0
	
	jr $ra
