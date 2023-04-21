.data
	msg: .asciiz "\nCifra\n"

.text
.globl main
.ent main

main:

	#li $v0, 5
	#syscall
	#add $t0,$v0,$0
	#Se l'utente introduce da tastiera un carattere non numerico non viene assegnato nessun valore al registro t0
	# \n = 10
	
	j input
	
	checkGreater:
			bge $t0, '0', printOk
			j continue
			
	printOk:
		li $v0, 4
		la $a0,msg
		syscall
		j continue
			
	
	input:
		li $v0, 12
		syscall 
		add $t0,$v0,$0
		ble $t0, '9', checkGreater
		continue:
			bne $t0,'\n',input
	
	li $v0, 10
	syscall
	.end main