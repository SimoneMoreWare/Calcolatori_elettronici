.data
	msgNoEquazioneSecondoGrado: .asciiz "Non e' equazione secondo grado"
	msgNoSoluzioni: .asciiz "Non ci sono soluzioni reali"
	msgSiSoluzioni: .asciiz "Ci sono soluzioni reali"
.text
.globl main
.ent main

main:
	
	li $v0, 5
	syscall
	add $t0,$v0,$0 #a
	
	li $v0, 5
	syscall
	add $t1,$v0,$0 #b
	
	li $v0, 5
	syscall
	add $t2,$v0,$0 #c
	
	#b*b - 4*a*c
	
	beq $t0,0,printNoEquazioneSecondoGrado
	
	mul $t0,$t0,$t2
	sll $t0,$t0,2
	
	mul $t1,$t1,$t1
	
	sub $t0,$t1,$t0 #discriminante calcolato
	
	slt $t0,$t0,$0 #$t0 impostato a 1 se negativo
	beq $t0,1,printNoSoluzioni
	
	printSiSoluzioni:
		li $v0, 4
		la $a0,msgSiSoluzioni
		syscall
		j fine
	
	printNoEquazioneSecondoGrado:
		li $v0, 4
		la $a0,msgNoEquazioneSecondoGrado
		syscall
		j fine
		
	printNoSoluzioni:
		li $v0, 4
		la $a0,msgNoSoluzioni
		syscall
		j fine
	
	fine:
		li $v0, 10
		syscall
		.end main
