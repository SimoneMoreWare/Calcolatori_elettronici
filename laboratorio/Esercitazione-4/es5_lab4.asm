.data
	NUMCOLNONVUOTE = 5
	NUMRIGHENONVUOTE = 3
	NUMRIGE = 4
	NUMCOLONNE=6
	DIMRIG = 4 * NUMCOLONNE
	wMat: .word 154, 123, 109, 86, 4, 0, 412, -23, -231, 9, 50, 0, 123, -24, 12, 55, -45, 0, 0, 0, 0, 0, 0, 0
	space: .asciiz " "
	newLine: .asciiz "\n"
	
.text
.globl main
.ent main

main:
	
	la $t0, wMat
	
	li $t1,0 #i
	li $t2,0 #j
	li $t3, 0 #somma

	loopJcol:
		loopIcol:
			
			mul $t4,$t1,DIMRIG
			mul $t5,$t2,4
			add $t4,$t4,$t5
			add $t4,$t4,$t0
			
			lw $t5,($t4)
			add $t3,$t3,$t5
			
			addi $t1,$t1,1
			
			bne $t1,NUMRIGHENONVUOTE,loopIcol
			
		addi $t4,$t4,DIMRIG
		
		sw $t3,($t4)
		li $t3,0
		addi $t2,$t2,1
		li $t1,0
		bne $t2,NUMCOLNONVUOTE,loopJcol
	
	li $t1, 0 #i
	li $t2, 0 #j
		
	loopIriga:
		loopJriga:
			
			mul $t4,$t1,DIMRIG
			mul $t5,$t2,4
			add $t4,$t4,$t5
			add $t4,$t4,$t0
			
			lw $t5,($t4)
			add $t3,$t3,$t5
			
			addi $t2,$t2,1
		
			bne $t2,NUMCOLNONVUOTE,loopJriga
		addi $t4,$t4,4
		
		sw $t3,($t4)
		li $t3,0
		addi $t1,$t1,1
		li $t2,0
		bne $t1,NUMRIGE,loopIriga
		
	li $t1,0 #i
	li $t2,0 #j
	
	printLoopI:
		printLoopJ:
			
			mul $t4,$t1,DIMRIG #i*ncol*4
			mul $t5,$t2,4 #j*4
			add $t4,$t4,$t5
			add $t4,$t4,$t0
			
			li $v0, 1
			lw $a0,($t4)
			syscall
			li $v0, 4
			la $a0,space
			syscall
			
			addi $t2,$t2,1
			
			bne $t2,NUMCOLONNE,printLoopJ
		
		li $v0, 4
		la $a0,newLine
		syscall
		
		li $t2, 0
		addi $t1,$t1,1
		bne $t1,NUMRIGE,printLoopI
	
	li $v0, 10
	syscall
	.end main
		
		
	
		
		
