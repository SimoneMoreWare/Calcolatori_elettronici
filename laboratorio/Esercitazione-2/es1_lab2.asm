.data
	msgPari: .asciiz "\nNumero pari\n"
	msgDispari: .asciiz "Numero dispari\n"

.text
.globl main
.ent main

main:
	li $v0,5
	syscall
	move $t0,$v0
	
	sll $t1,$t0,31
	
	beq $t1,0,stampaPari
	
	stampaDispari:
		li $v0,4
		la $a0,msgDispari
		syscall
		j fine
	
	stampaPari:
		li $v0,4
		la $a0,msgPari
		syscall
		
	fine:
	
	li $v0,10
	syscall
	.end main
	
