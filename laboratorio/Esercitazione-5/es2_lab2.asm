.data
	msgPalindromo: .asciiz "palidromo: si"
	msgNonPalindromo: .asciiz "palindromo: no"
	msgNoInput: .asciiz "no input"

.text
.globl main
.ent main

main:	
	
	li $t1,-1 #contatore
	
	inputLoop:
		li $v0, 12
		syscall
		add $t0,$v0,$0
		addi $sp,$sp,-4
		addi $t1,$t1,1
		sw $t0,($sp)
		bne $t0,'\n',inputLoop
	
	beq $t1,0,noInput
	beq $t1,1,siPalindromo	
	li $t2,0
	li $t4,0 #contatore
	addi $sp,$sp,4
	sll $t3,$t1,2
	srl $t1,$t1,1
	addi $t3,$t3,-4 
	add $t5,$t3,$0
	
	ifPalindromo:
		
		lw $t0,($sp)
		li $v0, 11
		add $a0,$t0,$0
		syscall
		sub $sp,$sp,$t2
		add $sp,$sp,$t5
		lw $t6,($sp)
		li $v0, 11
		add $a0,$t6,$0
		syscall
		bne $t0,$t6,noPalindromo
		
		sub $sp,$sp,$t5
		addi $t5,$t5,-4
		addi $t2,$t2,4
		add $sp,$sp,$t2
		
		addi $t4,$t4,1
		
		bne $t4,$t1,ifPalindromo
	
	siPalindromo:
		li $v0, 4
		la $a0,msgPalindromo
		syscall
		j fine
	
	noInput:
		li $v0, 4
		la $a0,msgNoInput
		syscall
		j fine
	
	noPalindromo:
		li $v0, 4
		la $a0,msgNonPalindromo
		syscall
	
	fine:	
		li $v0, 10
		syscall
		.end main
