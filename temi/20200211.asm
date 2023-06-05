.data
	vettore: .byte 14, 16, 18, 134, 24, 22, 23, 149, 140, 141, 145, 146
	vettoreCompresso: .space 12
	INTERVALLO_QUANT = 10

.text
.globl main
.ent main
main:
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, vettore #indirizzo vett
	li $a1, 12 #dim vet
	la $a2, vettoreCompresso #res
	jal comprimi #v0 dim res
	
	add $s0,$v0,$0
	la $t0,vettoreCompresso
	li $t1,0
	printLoop:
	
		lbu $t2,($t0)
		
		li $v0, 1
		add $a0,$t2,$0
		syscall
		li $v0, 11
		li $a0,' '
		syscall
		
		addi $t0,$t0,1
		addi $t1,$t1,1
		bne $t1,$s0,printLoop
	
	lw $ra, ($sp)
	addu $sp, $sp, 4
	jr $ra
	.end main
	
.globl comprimi
.ent comprimi
comprimi:
	
	addi $sp,$sp,-4
	sw $ra,($sp)
	
	add $t0,$a0,$0
	add $t1,$a1,$0
	add $t2,$a2,$0
	li $t3,0
	li $t7,0 #lunghezza_res
	li $t8,0 #flag
	
	loop:
		
		lbu $t4,($t0)
		
		addi $sp,$sp,-36
		sw $t0,32($sp)
		sw $t1,28($sp)
		sw $t2,24($sp)
		sw $t3,20($sp)
		sw $t4,16($sp)
		sw $t5,12($sp)
		sw $t6,8($sp)
		sw $t7,4($sp)
		sw $t8,0($sp)
		
		add $a0,$t4,$0
		jal quantizza
		
		lw $t8,0($sp)
		lw $t7,4($sp)
		lw $t6,8($sp)
		lw $t5,12($sp)
		lw $t4,16($sp)
		lw $t3,20($sp)
		lw $t2,24($sp)
		lw $t1,28($sp)
		lw $t0,32($sp)
		addi $sp,$sp,36
		
		beq $t8,$0,setFirstValue
		
		add $t6,$v0,$0
		bne $t5,$t6,storeRes
		
		add $t5,$t6,$0
		j next
		
		storeRes:
			addi $t7,$t7,1
			sb $t5,($t2)
			addi $t2,$t2,1
			add $t5,$t6,$0
	
		j next
		
		setFirstValue:
			li $t8,1
			add $t5,$v0,$0
		
		next:
			addi $t0,$t0,1
			addi $t3,$t3,1
			bne $t3,$t1,loop
	
	lw $ra,($sp)
	addi $sp,$sp,4
	addi $t7,$t7,1
	sb $t5,($t2)
	add $v0,$t7,$0
	jr $ra
	.end comprimi

.globl quantizza
.ent quantizza
quantizza:
	divu $t0, $a0, INTERVALLO_QUANT
	mulou $v0, $t0, INTERVALLO_QUANT
	jr $ra
	.end quantizza
	

	
