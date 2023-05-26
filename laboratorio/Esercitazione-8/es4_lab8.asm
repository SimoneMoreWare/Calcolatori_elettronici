DIM = 5
.data
	vet1: .word 56, 12, 98, 129, 58
	vet2: .word 1, 0, 245, 129, 12
	risultato: .space DIM

.text
.globl main
.ent main

main: 
	la $a0, vet1
	la $a1, vet2
	la $a2, risultato
	li $a3, DIM
	jal CalcolaDistanzaH
	
	la $t0,risultato
	li $t1,0
	
	printLoop:
		lb $t2,($t0)
		li $v0, 1
		add $a0,$t2,$0
		syscall
		li $v0, 11
		li $a0,' '
		syscall
		addi $t0,$t0,1
		addi $t1,$t1,1
		bne $t1,DIM,printLoop
	
	li $v0, 10
	syscall
	.end main
	
.globl CalcolaDistanzaH
.ent CalcolaDistanzaH
CalcolaDistanzaH:
	
	li $t0, 0 #contatore
	add $t1,$a0,$0
	add $t2,$a1,$0
	add $t9,$a2,$0

	loop:
	
		lw $t3,($t1)
		lw $t4,($t2)
		li $t5,0
		li $t8,0 #res
		
		checkbit:
			srl $t6,$t3,$t5
			andi $t6,$t6,1
			srl $t7,$t4,$t5
			andi $t7,$t7,1
			beq $t6,$t7,endcheckbit
			addi $t8,$t8,1
			endcheckbit:
				addi $t5,$t5,1
				bne $t5,32,checkbit
		
		sb $t8,($t9)
		addi $t9,$t9,1
		addi $t0,$t0,1
		addi $t1,$t1,4
		addi $t2,$t2,4
		bne $t0,$a3,loop
		
	jr $ra
	.end CalcolaDistanzaH
	
