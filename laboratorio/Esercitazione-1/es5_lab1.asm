.text
.globl main
.ent main

main:

	li $v0,5 #code for syscall: Get integer
	syscall
	move $t1,$v0
	
	li $v0,5 #code for syscall: Get integer
	syscall
	move $t2,$v0
		
	add $t2,$t2,$t1 #in t2 ci metto la somma, pero' mi conservo il valore piu' piccolo in t1 perche' in questo modo posso salvare la differenza in t1
	
	sll $t1,$t1,1 #devo moltiplicare per 2 t1 in modo tale che posso eseguire tale operazione differenza = somma - 2*valorePiccolo
	
	sub $t1,$t2,$t1 #in t1 c'e' la differenza
	
	add $t1,$t1,$t2
	
	srl $t1,$t1,1 #t1 il valore che c era in t2
	
	sub $t2,$t2,$t1 #t2 il valore di t1	
		
	li $v0,10
	syscall
	.end main
