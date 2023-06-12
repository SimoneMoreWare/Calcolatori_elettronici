DIM = 8

.data

	matrice: .byte 3, 1, 41, 5, 9, 26, 5, 35
			 .byte 89, 79, 32, 3, 8, 46, 26, 4
			 .byte 33, 8, 32, 79, 50, 28, 8, 4
             .byte 19, 71, 69, 39, 9, 37, 5, 10
			 .byte 58, 20, 9, 74, 9, 44, 59, 2
			 .byte 30, 7, 8, 16, 40, 6, 28, 6
			 .byte 20, 8, 9, 98, 62, 80, 3, 48
			 .byte 25, 34, 21, 1, 70, 6, 7, 9

.text
.globl main
.ent main

main:

	subu $sp, $sp, 4
	sw $ra, ($sp)

	la $a0, matrice
	li $a1, 7
	li $a2, DIM
	jal maxInTriangolo
	
	add $s0,$v0,$0
	
	li $v0, 1
	add $a0,$s0,$0
	syscall

	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end main
	
.globl maxInTriangolo
.ent maxInTriangolo

maxInTriangolo:

	add $t0,$a0,$0 #base address
	add $t1,$a1,$0 #j cella ipotenusa start

	add $t2,$t1,1 #iterazioni
	
	li $t3,0 #dim attuale
	
	li $t4,0 #i
	
	lb $t7,($t0) #max
	
	loopIpotenusa:
		
		mul $t5,$t4,DIM
				
		add $t5,$t5,$t1
		add $t5,$t5,$t0
		
		lb $t6,($t5)
		
		bgt $t6,$t7,setMax1
		
		j next1
		
		setMax1:
			add $t7,$t6,$0
		
		next1:
			addi $t4,$t4,1
			addi $t1,$t1,-1
			addi $t3,$t3,1
			bne $t3,$t2,loopIpotenusa
	
	li $t1, 0 #j
	li $t3, 0 #dim attuale
	add $t4, $a1, $0 #i
	mul $t5,$t4,$a2
	add $t5,$t0,$t5
	addi $t5,$t5,1
	
	loopRiga:
		
		lb $t6,($t5)
		
		bgt $t6,$t7,setMax2
		
		j next2
		
		setMax2:
			add $t7,$t6,$0
		
		next2:
			addi $t5,$t5,1
			addi $t3,$t3,1
			bne $t3,$t2,loopRiga
			
	add $t1,$a1,$0 #j
	li $t3,0 #dim attuale
	li $t4,0 #i
	
	add $t5,$t0,$t1
	
	loopColonna:
	
		lb $t6,($t5)
		
		bgt $t6,$t7,setMax3
		
		j next3
		
		setMax3:
			add $t7,$t6,$0
			
		next3:
			add $t5,$t5,$a2
			addi $t3,$t3,1
			bne $t3,$t2,loopColonna
	
	add $v0,$t7,$0
	
	jr $ra
	.end ,maxInTriangolo
