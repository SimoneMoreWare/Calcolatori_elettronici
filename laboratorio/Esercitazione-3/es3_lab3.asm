.data
	risultato: .space 4 #prima risultato stava sotto e il programma non andava, l ho messo qui e funziona tutto, non ancora il perche'
	g: .byte 255
	h: .byte 255
	m: .byte 255
	
.text
.globl main
.ent main

main:

	lbu $t0, g 
	mul $t1, $t0, 24
	lbu $t0, h
	addu $t1, $t1, $t0 # somma ore
	mul $t1, $t1, 60 
	lbu $t0, m
	addu $t1, $t1, $t0
	
	sw $t1,risultato
	
	#e' possibile ottenere overflow durante i calcoli? se usi addu ed lbu sicuramente no
	
	li $v0,10
	syscall
	.end main
