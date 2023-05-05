.data
	msgPalindromo: .asciiz "palidromo: si"
	msgNonPalindromo: .asciiz "palindromo: no"
	msgNoInput: .asciiz "no input"

.text
.globl main
.ent main

main:	
	
	li $t1,-1 #contatore
	
	inputLoop:
		li $v0, 12
		syscall
		add $t0,$v0,$0
		addi $sp,$sp,-4
		addi $t1,$t1,1
		sw $t0,($sp)
		bne $t0,'\n',inputLoop
	
	beq $t1,0,noInput
	beq $t1,1,siPalindromo #se dim 1 allora è sicuramente palindromo
	li $t2,0 #usate per muovermi nello stack
	li $t4,0 #contatore ciclo
	addi $sp,$sp,4 
	sll $t3,$t1,2 #per calcolarmi l'offsset piu grande devo moltiplicare la dimensione totale per 4
	srl $t1,$t1,1 #il ciclo non sarà su tutte i caratteri, ma sulla meta, in quanto confronto primo ultimo, secondo penultimo ecc....
	addi $t3,$t3,-4 #l'ofsset massimo è l'offsset calcolato in precedenza - 4, ricordandosi che parte da 0
	add $t5,$t3,$0 #in t3 quindi tengo salvato l'offsset massimo, in t5 inserisco in seguito il valore effettivo in cui spostarmi
	
	ifPalindromo:
		
		lw $t0,($sp) #carico valore dalla $sp in $t0
		
		sub $sp,$sp,$t2 #ritorno in posizioe iniziale
		add $sp,$sp,$t5 #ci aggiungo $t5
		lw $t6,($sp) #carico secondo valore
		
		bne $t0,$t6,noPalindromo #se sono diversi salto
		
		sub $sp,$sp,$t5 #ritorno alla posizione iniziale
		addi $t5,$t5,-4 #sottrago di 4 il stack, cosi dall ultimo vado al penultimo offset per esempio
		addi $t2,$t2,4 #aggiungo 4 allo stack, cosi dal primo vado al secondo offsset per esempio
		add $sp,$sp,$t2 #aggiungo offsett appena calcolato a sp in modo tale che dopo posso accederci
		
		addi $t4,$t4,1
		
		bne $t4,$t1,ifPalindromo
	
	siPalindromo:
		li $v0, 4
		la $a0,msgPalindromo
		syscall
		j fine
	
	noInput:
		li $v0, 4
		la $a0,msgNoInput
		syscall
		j fine
	
	noPalindromo:
		li $v0, 4
		la $a0,msgNonPalindromo
		syscall
	
	fine:	
		li $v0, 10
		syscall
		.end main
