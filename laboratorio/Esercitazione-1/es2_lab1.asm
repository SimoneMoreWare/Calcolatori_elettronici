.data
	var1: .byte 'm'
	var2: .byte 'i'
	var3: .byte 'p'
	var4: .byte 's'
	var5: .byte 0
.text
.globl main
.ent main

main:

	lb $t0,var1 #carico nel registro $t0 il valore contenuto nel byte var1
	addi $t0,$t0,-32 #per convertire in maiuscola una lettera minuscola devo sottrare -32
	sb $t0,var1 #carico il nuovo valore con una sb in var1 dal registro $t0
	
	lb $t0,var2
	addi $t0,$t0,-32
	sb $t0,var2
	
	lb $t0,var3
	addi $t0,$t0,-32
	sb $t0,var3
	
	lb $t0,var4
	addi $t0,$t0,-32
	sb $t0,var4
	
	lb $t0,var5
	
	li $v0,4
	la $a0,var1
	syscall
	
	#caratteri stampati a video : MIPS
	#var5 serve per identificare la fine

	li $v0,10
	syscall
	.end main
