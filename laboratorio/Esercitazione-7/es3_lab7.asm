.text
.globl main
.ent main

main:

	li $v0, 5
	syscall
	add $a0,$v0,$0

	jal sequenzaDiCollatz
	
	add $s0,$v0,$0
	
	li $v0, 11
	li $a0, 'n'
	syscall
	li $v0, 1
	add $a0,$s0,$0
	syscall
	
	li $v0, 10
	syscall
	.end main
	
.globl sequenzaDiCollatz
.ent sequenzaDiCollatz

sequenzaDiCollatz:

	addi $sp,$sp,-4
	sw $ra,($sp)
	
	li $t1,1
	add $t2,$a0,$0
	
	loop:
		add $a0,$t2,$0
		jal calcolaSuccessivo
		addi $t1,$t1,1
		add $t2,$v0,$0
		bne $t2,1,loop
	
	lw $ra,($sp)
	add $v0,$t1,$0
	jr $ra
	.end sequenzaDiCollatz

.globl calcolaSuccessivo	
.ent calcolaSuccessivo

calcolaSuccessivo:
	and $t0, $a0, 1
	beqz $t0, pari
	mulou $t0, $a0, 3 # il numero e' dispari
	addi $t0, $t0, 1
	b fine
	
	pari:
		sra $t0, $a0, 1

	fine: # stampa il numero seguito da un new line
		move $a0, $t0
		li $v0, 1
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		move $v0, $t0
		jr $ra
		.end calcolaSuccessivo
