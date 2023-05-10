.data
	msg: .asciiz "Inserire dimensione\n"
	
.text
.globl main
.ent main

main:
	
	li $v0, 4
	la $a0, msg
	syscall
	li $v0, 5
	syscall
	add $s0,$v0,$0 #devo inserire il valore delle dimensione in un registro s, non posso utilizzare $a0 per tutte le procedure perche' nelle procedure modifico $a0, tramite le li per esempio quindi devo fare attenzione

	add $a0,$s0,$0 #parametro
	jal stampaTriangolo
	add $a0,$s0,$0 #parametro
	jal stampaQuadrato
	
	li $v0, 10
	syscall
	.end main
	
.globl stampaTriangolo
.ent stampaTriangolo

stampaTriangolo: 

	li $t0, 0
	li $t1, -1
	add $t2,$a0,$0
	
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
		bne $t0,$t2,printTriangoloI
		
	jr $ra
	
	.end stampaTriangolo
	
	
.globl stampaQuadrato
.ent stampaQuadrato
	
stampaQuadrato:

	li $t0,0
	li $t1,0
	add $t2,$a0,$0
	
	printQuadratoI:
		printQuadratoJ:
			
			li $v0, 11
			li $a0,'*'
			syscall
			addi $t1,$t1,1
			bne $t1,$t2,printQuadratoJ
			
		addi $t0,$t0,1
		li $t1,0
		li $v0, 11
		li $a0, '\n'
		syscall
		bne $t0,$t2,printQuadratoI
		
	jr $ra
	
	.end stampaQuadrato
