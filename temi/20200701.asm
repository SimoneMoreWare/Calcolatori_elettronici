DIM = 11

.data
	veta: .word 2, 14, 8, 54, 0, 42, 9, 24, 0, 91, 23
	vetb: .byte 4*DIM

.text
.globl main
.ent main

main: 

	la $a0, veta
	la $a1, vetb
	li $a2, DIM

	jal media

	la $t0,vetb
	li $t1,0

	printLoop:
		lw $t2,($t0)
		
		li $v0, 1
		add $a0,$t2,$0
		syscall
		li $v0, 11
		li $a0,' '
		syscall	

		addi $t0,$t0,4
		addi $t1,$t1,1
		bne $t1,DIM,printLoop

	li $v0, 10
	syscall
	.end main

.globl media
.ent media

media:
	
	add $t0,$a0,$0
	add $t1,$a1,$0
	add $t2,$a2,$0
	addi $t2,$t2,-1

	li $t3,0

	lw $t4,($t0)
	sw $t4,($t1)
	addi $t3,$t3,1
	addi $t0,$t0,4
	addi $t1,$t1,4

	lw $t5,($t0)
	sw $t5,($t1)
	addi $t3,$t3,1
	addi $t0,$t0,4
	addi $t1,$t1,4

	loop:
		lw $t6,($t0)
		lw $t7,4($t0)
		add $t8,$t4,$t5
		add $t8,$t8,$t6
		add $t8,$t8,$t7
		srl $t8,$t8,2
		sw $t8,($t1)

		addi $t3,$t3,1
		addi $t0,$t0,4
		addi $t1,$t1,4
		add $t4,$t5,$0
		add $t5,$t6,$0
		bne $t3,$t2,loop
	
	lw $t6,($t0)
	sw $t6,($t1)
	
	jr $ra
	.end media
