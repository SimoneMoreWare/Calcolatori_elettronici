.data
	colonna: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
	riga: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
	table: .space 400
	newLine: .asciiz "\n"
	space: .asciiz " "
	
.text
.globl main
.ent main

main:
	
	la $t0, colonna
	la $t1, riga
	la $t2, table
	
	li $t3, 0
	li $t4, 0
	
	add $t5, $t0, $0
	add $t6, $t1, $0
	
	loop0:
		lw $t7,($t5)
		loop1:
			lw $t8,($t6)
			mul $t8, $t8, $t7
			
			mul $t9,$t3,40
			mul $s0,$t4,4
			add $t9,$t9,$s0
			add $t9,$t2,$t9
			
			sw $t8,($t9)
			
			addi $t4,$t4,1
			addi $t6,$t6,4
			
			bne $t4,10,loop1
		li $t4, 0
		addi $t3,$t3,1
		addi $t5,$t5,4
		add $t6,$t1,$0
		bne $t3,10,loop0
		
	li $t3, 0
	li $t4, 0
	
	printLoop0:
		printLoop1:
			
			mul $t9,$t3,40
			mul $s0,$t4,4
			add $t9,$t9,$s0
			add $t9,$t2,$t9
			
			lw $t0,($t9)
			
			#stampa
			li $v0, 1
			add $a0,$t0,$0
			syscall
			li $v0, 4
			la $a0, space
			syscall
						
			addi $t4,$t4,1
			addi $t6,$t6,4
			
			bne $t4,10,printLoop1
		#stampa
		li $v0, 4 
		la $a0, newLine
		syscall
		
		li $t4, 0
		addi $t3,$t3,1
		bne $t3,10,printLoop0
			
	
	
	li $v0, 10
	syscall
	.end main
