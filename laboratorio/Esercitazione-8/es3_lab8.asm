#calcola_sconto
#calcolare prezzo scontato degli articoli (contenuti in un vettore)
#salvare risultato in un vettore
#a0 indirizzo vettore prezzi (prezzi di ciascun articolo venduti in un negozio)
#a1 indirizzo vettore scontati, inizialmente di contenuto indeterminato
#a2 numero elementi
#a3 ammontare dello sconto percentuale da applicare
#arrotondamento: 1 cifra sup, 0 cifra inf
#procedyra restituisce ammontare totale riduzione
#preservare registri

.data
	NUM = 5
	DIM = NUM * 4
	SCONTO = 30
	ARRONTONDA = 0
	prezzi: .word 39, 1880, 2394, 1000, 1590
	scontati: .space DIM
	
.text
.globl main
.ent main
main:
	la $a0, prezzi
	la $a1, scontati
	li $a2, NUM
	li $a3, SCONTO
	li $t0, ARRONTONDA 
	addi $sp,$sp,-4
	sw $t0,($sp)
	jal calcola_sconto
	add $s0,$v0,$0
	
	la $t0, prezzi
	li $t1, 0
	printLoop1:
		lw $a0,($t0)
		li $v0, 1
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		addi $t0,$t0,4
		addi $t1,$t1,1
		bne $t1,NUM,printLoop1
	li $v0, 11
	la $a0, '\n'
	syscall

	
	la $t0, scontati
	li $t1, 0
	printLoop2:
		lw $a0,($t0)
		li $v0, 1
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		addi $t0,$t0,4
		addi $t1,$t1,1
		bne $t1,NUM,printLoop2
	
	li $v0, 11
	la $a0, '\n'
	syscall
	li $v0, 1
	add $a0,$s0,$0
	syscall
	
	addi $sp,$sp,4
	li $v0, 10 
	syscall
	.end main
	
.globl calcola_sconto
.ent calcola_sconto
calcola_sconto:
	
	add $t0,$0,$a0 #indirizzo prezzi
	add $t1,$0,$a1 #indirizzo sconti
	add $t2,$0,$a2 #NUM
	add $t3,$0,$a3 #sconto
	lw $t4,($sp) #arrotondamento
	li $t5,0
	li $t6, 100
	li $t9,0
	loop:
		lw $s0,($t0)
		sub $t8,$t6,$t3
		mul $t7,$s0,$t8
		div $t7, $t6
		mfhi $t8 #resto
		mflo $t7 

		beq $t4,1,effettuaArrontondamento
		
		j continueLoop
		
		effettuaArrontondamento:
			bge $t8,50,incrementValue
			j continueLoop
			incrementValue:
				addi $t7,$t7,1
		
		continueLoop:
			sub $s0,$s0,$t7
			sw $t7,($t1)
			add $t9,$t9,$s0
			addi $t5,$t5,1
			addi $t0,$t0,4
			addi $t1,$t1,4
			bne $t5,$t2,loop
		
	add $v0, $t9, $0	
	jr $ra
	.end calcola_sconto
