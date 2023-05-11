.data 
	msgInput: .asciiz "Inserire Stringa\n"
	
.text
.globl main
.ent mait

main:

	li $v0, 4
	la $a0,msgInput
	syscall
	li $v0, 8
	syscall
	
	la $t0,($a0) #prima cella stringa
	la $t2,($a0)
	loop:
		lb $t1,($t0)
		beq $t1,$0,fine
		add $a0,$t1,$0
		jal conversione
		sb $v0,($t0)
		addi $t0,$t0,1
		j loop
		
	fine:
		addi $t0,$t0,-1
		sb $0,($t0)
		li $v0, 4
		la $a0,($t2)
		syscall
			
		li $v0, 10
		syscall
		.end main
	
	
.globl conversione
.ent main

conversione:
	
	add $v0,$a0,-32
	
	jr $ra
