.data
	DIM=5
	wMat:
		.word 1, 4, 5, 6, 7
		.word 4, 2, 4, 6, 4
		.word 5, 8, 3, 2, 9
		.word 6, 6, 2, 4, 4
		.word 7, 4, 9, 4, 5
	wMatT: .space DIM*DIM*4
	msgSiDiagonale: .asciiz "La matrice e' diagonale"
	msgNoDiagonale: .asciiz "La matrice non e' diagonale"
	msgSiSimmetrica: .asciiz "La matrice e' simmetrica"
	msgNoSimmetrica: .asciiz "La matrice non e' simmetrica"
	
.text
.globl main
.ent main

main:
	
	la $t0, wMat #base_address
	
	li $t1, 0 #i
	li $t2, 0 #j
	
	loopi:
		loopj:
			
			beq $t1,$t2,endloopj
					
			mul $t3,$t1,DIM #i*N
			sll $t3,$t3,2 #i*n*4
			sll $t4,$t2,2 #j*4
			add $t3,$t3,$t4 #i*n*4 + j*4
			add $t3,$t0,$t3 #base_address + i*n*4 + j*4
			
			lw $t3,($t3) #carico in t3 il valore mat[i][j]
			
			bne $t3,0,printNoMatDiagonale
			
			endloopj:
				addi $t2,$t2,1
				bne $t2,DIM,loopj
				
		li $t2, 0 #j
		addi $t1,$t1,1
		bne $t1,DIM,loopi
		
	printSiMatDiagonale:
		li $v0, 4
		la $a0,msgSiDiagonale
		syscall
		j fine
	
	printNoMatDiagonale:
		li $v0, 4
		la $a0,msgNoDiagonale
		syscall
		
	li $v0, 11
	li $a0,'\n'
	syscall
	
	la $t5,wMatT
		
	li $t1, 0 #i
	li $t2, 0 #j
	li $t8, 0 
	li $t9, 0
	
	loopjT:
		loopiT:
								
			mul $t3,$t1,DIM #i*N
			sll $t3,$t3,2 #i*n*4
			sll $t4,$t2,2 #j*4
			add $t3,$t3,$t4 #i*n*4 + j*4
			add $t6,$t0,$t3 #base_address + i*n*4 + j*4
			
			mul $t3,$t8,DIM #i*N
			sll $t3,$t3,2 #i*n*4
			sll $t4,$t9,2 #j*4
			add $t3,$t3,$t4 #i*n*4 + j*4
			add $t7,$t5,$t3 #base_address + i*n*4 + j*4
			
			lw $t6,($t6)
			sw $t6,($t7)
			
			addi $t1,$t1,1
			addi $t9,$t9,1
			bne $t1,DIM,loopiT
				
		li $t1, 0 #j
		li $t9, 0
		addi $t2,$t2,1
		addi $t8,$t8,1
		bne $t2,DIM,loopjT
		
	li $t1, 0 #i
	li $t2, 0 #j
	
	simmetricMatI:
		simmetricMatJ:
			mul $t3,$t1,DIM #i*N
			sll $t3,$t3,2 #i*n*4
			sll $t4,$t2,2 #j*4
			add $t3,$t3,$t4 #i*n*4 + j*4
			add $t6,$t5,$t3 #base_address + i*n*4 + j*4
			add $t7,$t0,$t3
			lw $t6,($t6)
			lw $t7,($t7)
			
			bne $t6,$t7,printNoMatSimmetrica
			
			addi $t2,$t2,1
			bne $t2,DIM,simmetricMatJ
			
		li $t2,0
		addi $t1,$t1,1
		bne $t1,DIM,simmetricMatI
		
	li $v0, 4
	la $a0,msgSiSimmetrica
	syscall
	j fine
	
	printNoMatSimmetrica:
		li $v0, 4
		la $a0,msgNoSimmetrica
		syscall
		j fine
		
	fine:
		li $v0, 10
		syscall
		.end main
