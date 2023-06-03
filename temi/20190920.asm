.data
	vet: .word 15, 64, 9, 2, 4, 5, 9, 10, 294, 52, -4, 5

.text
.globl main
.ent main

main: 
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	la $a0, vet # indirizzo di vet
	li $a1, 12 # dimensione di vet
	jal monotono
	add $s0,$v0,$0
	add $s1,$v1,$0
	li $v0, 1
	add $a0,$s0,$0
	syscall
	li $v0, 11
	li $a0, ' '
	syscall
	li $v0, 1
	add $a0,$s1,$0
	syscall
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	
.globl monotono
.ent monotono
monotono:
	
	li $t0, 1 #determino lunghezza
	li $t1, 1 #start sequenza
	li $t2, 1 #contatore
	add $t3, $a0, $0
	li $t6, 0 #lunghezza corrente
	li $t7, 0 #start corrente
	li $t8, 0 #flag
	loop:
		
		lw $t4,($t3) #elemento i
		lw $t5,4($t3) #elemento i+1
		
		bgt $t5,$t4,crescente
		
		li $t8,0
		bgt $t6,$t0,setLunghezzaStartMax
		li $t6,0
		li $t7,0
		j next
		setLunghezzaStartMax:
			add $t0,$t6,$0
			addi $t0,$t0,1
			add $t1,$t7,$0
			li $t6,0
			li $t7,0
		j next
		
		crescente:
			addi $t6,$t6,1
			beq $t8,$0,setStart
			j next
			setStart:
				add $t7,$t7,$t2
				addi $t7,$t7,-1
				li $t8,1
			
		next:
			addi $t3,$t3,4
			addi $t2,$t2,1
			bne $t2,$a1,loop
			
	add $v0,$t0,$0
	add $v1,$t1,$0
	jr $ra
	.end monotono
