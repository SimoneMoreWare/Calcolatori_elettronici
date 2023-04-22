.data
	msg: .asciiz "\nOverflow\n"

.text
.globl main
.ent main

main:

	#li $v0, 5
	#syscall
	#add $t0,$v0,$0
	#Se l'utente introduce da tastiera un carattere non numerico non viene assegnato nessun valore al registro t0
	# \n = 10
	
	add $t1,$0,$0
	li $t2,0
	li $t3,10
	
	j input
	
	overflow:
		li $v0, 4
		la $a0, msg
		syscall
		j fine
	
	checkGreater:
			bge $t0, '0', printOk
			j continue
			
	printOk:
		#li $v0, 4
		#la $a0,msg
		#syscall
		addi $t0,$t0,-48
		multu $t2,$t3
		mflo $t2
		mfhi $t5
		bne $t5,$0,overflow
		add $t1,$t2,$t0
		add $t2,$t1,$0
		j continue
			
	
	input:
		li $v0, 12
		syscall 
		add $t0,$v0,$0
		ble $t0, '9', checkGreater
		continue:
			bne $t0,'\n',input
			
	li $v0, 1
	add $a0,$t1,$0
	syscall
			
	fine:
		li $v0, 10
		syscall
		.end main
	
