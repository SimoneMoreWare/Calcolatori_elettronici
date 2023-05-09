.data
	DIM = 8
	
.text
.globl main
.ent main

main:

	jal stampaTriangolo
	jal stampaQuadrato
	
	li $v0, 10
	syscall
	.end main
	
.globl stampaTriangolo
.ent stampaTriangolo

stampaTriangolo: 

	li $t0, 0
	li $t1, -1
	printTriangoloI:
		printTriangoloJ:
			
			li $v0, 11
			li $a0,'*'
			syscall
			addi $t1,$t1,1
			bne $t1,$t0,printTriangoloJ
		
		addi $t0,$t0,1
		li $v0, 11
		li $a0,'\n'
		syscall
		li $t1,-1
		bne $t0,DIM,printTriangoloI
		
	jr $ra
	
	.end stampaTriangolo
	
	
.globl stampaQuadrato
.ent stampaQuadrato
	
stampaQuadrato:

	li $t0,0
	li $t1,0
	
	printQuadratoI:
		printQuadratoJ:
			
			li $v0, 11
			li $a0,'*'
			syscall
			addi $t1,$t1,1
			bne $t1,DIM,printQuadratoJ
			
		addi $t0,$t0,1
		li $t1,0
		li $v0, 11
		li $a0, '\n'
		syscall
		bne $t0,DIM,printQuadratoI
		
	jr $ra
	
	.end stampaQuadrato
