.data
	cognome: .asciiz "ROSSI"
	nome: .asciiz "GENNARO"
	data: .asciiz "120892"
	CF: .space 12

.text
.globl main
.ent main
main: 
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, cognome
	la $a1, nome
	la $a2, data
	la $a3, CF
	jal CalcoloCF
	li $v0, 4
	la $a0, CF
	syscall
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end main
	
.ent CalcoloCF
CalcoloCF:
	
	addi $sp,$sp,-4
	sw $ra,($sp)
	
	add $t3,$a3,$0
	
	add $t0,$a0,$0
	li $t2, 0 #contatore consonanti
	loopCognome:
		
		lb $t1,($t0)
		
		beq $t1,'A',isVocaleCognome
		beq $t1,'E',isVocaleCognome
		beq $t1,'I',isVocaleCognome
		beq $t1,'O',isVocaleCognome
		beq $t1,'U',isVocaleCognome
		
		sb $t1,($t3)
		addi $t3,$t3,1
		addi $t2,$t2,1
	
		beq $t2,3,exitCognome
		
		isVocaleCognome:
			addi $t0,$t0,1
			bne $t1,0,loopCognome
	
	exitCognome:
		
		add $t0,$a1,$0
		li $t2,0
		
		loopNome:
			
			lb $t1,($t0)
			
			beq $t1,'A',isVocaleNome
			beq $t1,'E',isVocaleNome
			beq $t1,'I',isVocaleNome
			beq $t1,'O',isVocaleNome
			beq $t1,'U',isVocaleNome
			
			sb $t1,($t3)
			addi $t2,$t2,1
			addi $t3,$t3,1
				
			beq $t2,3,exitNome
			
			isVocaleNome:
				addi $t0,$t0,1
				bne $t1,0,loopNome
		
	exitNome:
		add $t0,$a2,$0
		
		lb $t2,($t0)
		sb $t2,($t3)
		addi $t3,$t3,1
		addi $t0,$t0,1
		lb $t2,($t0)
		sb $t2,($t3)
		addi $t3,$t3,1
		addi $t0,$t0,1
		
		lb $t2,($t0)
		addi $t0,$t0,1
		sll $t2,$t2,8
		
		lb $t4,($t0)
		addi $t0,$t0,1
		
		addi $sp,$sp,-4
		sw $a0,($sp)
		or $a0,$t2,$t4
			
		addi $sp,$sp,-16
		sw $t0,12($sp)
		sw $t1,8($sp)
		sw $t2,4($sp)
		sw $t3,0($sp)
		
		jal MonthToChar
		
		add $s0,$v0,$0
		
			
		
		
		lw $t3,0($sp)
		lw $t2,4($sp)
		lw $t1,8($sp)
		lw $t0,12($sp)
		addi $sp,$sp,16
		lw $a0,($sp)
		addi $sp,$sp,4
		sb $s0,($t3)
		addi $t3,$t3,1
		
		lb $t1,($t0)
		sb $t1,($t3)
		addi $t0,$t0,1
		addi $t3,$t3,1
		
		lb $t1,($t0)
		sb $t1,($t3)
		addi $t0,$t0,1
		addi $t3,$t3,1
	
		li $t2,0
		add $t4,$a3,$0
		li $t5, 0
		loopXor:
			lb $t1,($t4)
			xor $t5,$t5,$t1
			addi $t4,$t4,1
			addi $t2,$t2,1
			bne $t2,11,loopXor
		
		sb $t5,($t3)
		
		
		lw $ra,($sp)
		addi $sp,$sp,4
		jr $ra
		.end CalcoloCF

.ent MonthToChar
MonthToChar:
	subu $sp, $sp, 4
	sw $ra, ($sp)
	move $t0, $a0
	srl $t0, $t0, 8
	subu $t0, $t0, '0'
	mul $t0, $t0, 10
	move $t1, $a0
	li $t2, 0xFF
	and $t1, $t1, $t2
	subu $t1, $t1, '0'
	addu $t1, $t1, $t0

	#in $t1 il numero
	subu $t1, $t1, 1 # per partire con A
	addu $v0, $t1, 'A'
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end MonthToChar
