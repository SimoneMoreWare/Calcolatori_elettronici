#vettore contenente anni (interi
#procedura bisestile: anno_iesimo bisestile oppure no
#	$a0 indirizzo vettore (di word)
#	$a1 indirizzo vettore di byte contenente il risultato sul fatto che l anno iesimo e' bisestile oppure no
# 	$a2 lunghezza

.data
	anni: .word 1904, 2008, 1800, 1920, 1924, 1932
	risultato: .byte 0, 0, 0, 0, 0, 0
	lunghezza = 6
	
.text
.globl main
.ent main

main:

	la $a0, anni
	la $a1, risultato
	li $a2,lunghezza
	
	jal bisestile
	
	li $v0, 10
	syscall
	.end main
	
.globl bisestile
.ent bisestile

bisestile:
	li $t0, 0 #contatore
	add $t1,$a0,$0 #indirizzo date
	add $t2,$a1,$0 #indirizzo risultato
	loop:
	
		lw $t3,($t1)
		li $t5,100
		div $t3,$t5
		mfhi $t4
		beq $t4,0,checkdiv400
		
		checkdiv4:
			li $t5,4
			div $t3,$t5
			mfhi $t4
			beq $t4,0,setTrue
			
		j exitif
		
		checkdiv400:
			li $t5,400
			div $t3,$t5
			mfhi $t4
			beq $t4,0,setTrue
			
		j exitif
		
		setTrue:
			li $t4, 1
			sb $t4,($t2)
			
		exitif:
			lb $a0,($t2)
			li $v0, 1
			syscall
			li $v0, 11
			li $a0,' '
			syscall
			addi $t1,$t1,4
			addi $t2,$t2,1
			addi $t0,$t0,1
			bne $t0,$a2,loop
		
	jr $ra
	.end bisestile
