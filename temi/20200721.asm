DIM = 8
.data
	matrice: .byte 16, -41, 36, -5, 27, 62, 55, -18
			 .byte -26, 63, -54, 19, 13, -44, 33, 8
			 .byte -1, 40, 45, 12, 22, -51, -58, 31
			 .byte 23, -50, 59, -30, 4, -37, 48, -9
			 .byte 38, -3, 10, -47, 49, -24, 29, 60
			 .byte 52, -21, -32, -57, 39, 2, 11, 46
			 .byte -43, 14, -7, 34, 64, 25, 20, -53
			 .byte 61, -28, 17, -56, 42, -15, 6, 35

.text
.globl main
.ent main

#contare elementi strettamente positivi nella cornice di livello 3
#lato cornice 3: dim-4 elementi

main: 
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, matrice
	la $a1, DIM
	jal cornice
	add $s0,$v0,$0
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end main
	
.globl cornice
.ent cornice

cornice:

	add $t0,$a0,$0 #mat
	add $t1,$a1,$0 #dim
	
	sll $t2,$t1,1 #2*dim
	add $t3,$t2,$t0 #in t3 ho dove l angolo in alto a sx della mat
	add $t3,$t3,2
	add $t4,$t3,$0
	
	li $t6,0 #res
	li $t2, 4 #contatore
	
	li $v0, 11
	li $a0,'a'
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	
	loop1:
		
		lb $t5,($t4)
		
		li $v0, 1
		add $a0,$t5,$0
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
		
		bgt $t5,$0,setIncrement1
		
		j next1
		
		setIncrement1:
			addi $t6,$t6,1
			
		next1:
			addi $t2,$t2,1
			addi $t4,$t4,1
			bne $t2,$t1,loop1
			
	add $t4,$t3,$0
	add $t4,$t4,$t1
	li $t2,5
	
	li $v0, 11
	li $a0,'b'
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	
	loop2:
		
		lb $t5,($t4)
		
		li $v0, 1
		add $a0,$t5,$0
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
		
		bgt $t5,$0,setIncrement2
		
		j next2
		
		setIncrement2:
			addi $t6,$t6,1
			
		next2:
			addi $t2,$t2,1
			add $t4,$t4,$t1
			bne $t2,$t1,loop2
	
	add $t4,$t3,$0
	li $t2,5
	add $t4,$t4,$t1
	add $t4,$t4,$t1
	add $t4,$t4,$t1
	addi $t4,$t4,1
	
	li $v0, 11
	li $a0,'c'
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	
	loop3:
		
		lb $t5,($t4)
		
		li $v0, 1
		add $a0,$t5,$0
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
		
		bgt $t5,$0,setIncrement3
		
		j next3
		
		setIncrement3:
			addi $t6,$t6,1
			
		next3:
			addi $t2,$t2,1
			addi $t4,$t4,1
			bne $t2,$t1,loop3
			
	add $t4,$t3,$0
	li $t2,6
	addi $t4,$t4,3
	add $t4,$t4,$t1
	
	li $v0, 11
	li $a0,'d'
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	
	loop4:
		
		lb $t5,($t4)
		
		li $v0, 1
		add $a0,$t5,$0
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
		
		bgt $t5,$0,setIncrement4
		
		j next4
		
		setIncrement4:
			addi $t6,$t6,1
			
		next4:
			addi $t2,$t2,1
			add $t4,$t4,$t1
			bne $t2,$t1,loop4
			
	add $v0,$t6,$0
	
	jr $ra	
	.end cornice
