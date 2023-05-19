.text
.globl main
.ent main

main:

	li $v0, 5
	syscall
	add $s0,$v0,$0
		
	ble $s0,1,fine
	
	loop:
		add $a0,$s0,$0
		jal calcolaSuccessivo
		add $s0,$v0,$0
		li $v0, 1
		add $a0,$s0,$0
		syscall
		li $v0, 11
		li $a0,'\n'
		syscall
		bgt $s0,1,loop

	fine:
		li $v0, 10
		syscall
		.end main
	
.globl calcolaSuccessivo
.ent calcolaSuccessivo
calcolaSuccessivo:
	add $t0,$a0,$0
	
	andi $t1,$t0,1
	beqz $t1,pari
	
	dispari:
		mul $t0,$t0,3
		addi $t0,$t0,1
		j fineprocedura
		
	pari:
		srl $t0,$t0,1
		
	fineprocedura:
		add $v0,$t0,$0
		jr $ra
		.end calcolaSuccessivo
