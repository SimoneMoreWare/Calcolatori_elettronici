# reads DIM elements from the keyboard, stores them in a vector and prints them on the screen in reverse order

.data
	DIM = 5
	vett: .space 20
	msg: .asciiz "Inserire numeri\n"

.text
.globl main
.ent main

main:
	
	li $v0, 4 #code for syscall: print_string
	la $a0, msg # pointer to string, load the address of msg
	syscall
	
	la $t0, vett #inserisco in $t0 l'indirizzo di memoria della prima cella
	and $t1,$0,$0 #indice 
	
	input:
		li,$v0,5 #code for syscall: Get integer
		syscall
		sw $v0,($t0) #scrivo nella cella i-esima il valore che è stato inserito nella console
		addi $t0,$t0,4 #passo alla cella successiva
		addi $t1,$t1,1 # incremento indice
		bne $t1,5,input #se l'indice è minore di 5 allore rivado nella etichetta inptu
		
	la $t0, vett #resetto in $t0 l'indirizzo della prima cella di memoria del vettore
	and $t1,$0,$0 #resetto il contatore (indice)
	
	output:
		li $v0,1 #code for sysacall: print_integer
		lw $a0,($t0) #devo scrivere in $a0 il contenuto della cella-iesima del vettore 
		syscall
		addi $t0,$t0,4 #vado nella cella successiva
		addi $t1,$t1,1 #incremento l'indice (contatore)
		bne $t1,5,output #se l'indice è minore di 5 allora vado nella etichetta output
	
	li $v0,10
	syscall
	.end main

	
