.data
	v0: .word 1, 2, 3, 4
	v1: .word 1, 2, 4, 45
	res: .space 64
	newLine: .asciiz "\n"
	space: .asciiz " "
	
.text
.globl main
.ent main

main:
	
	la $t0, v0 #vettore colonna, in t0 c'e' indirizzo prima cella v0
	la $t1, v1 #vettore riga, in t1 c'e' indirizzo prima cella v1
	la $t2, res #matrice, in t2 c'e' indirizzo prima cella matrix
	
	li $t3, 0 # i
	li $t4, 0 # j
	
	add $t5, $t0, $0 #indirizzo v0 che uso per shiftare
	add $t6, $t1, $0 #indirizzo v1 che uso per shiftare
	
	loop0:
		lw $t7,($t5) #carico in t7 valore della cella v0[t3]
		loop1:
			lw $t8,($t6) # carico in t8 valore della cella v1[t4]
			mul $t8, $t8, $t7 # moltiplico v0[i]*v[j]
			
			#calcolo indirizzo matrix base_address + i*N*4 + j*4
			mul $t9,$t3,16 #i*N*4
			mul $s0,$t4,4 #j*4
			add $t9,$t9,$s0 #i*N*4 + j*4
			add $t9,$t9,$t2#matrix base_address + i*N*4 + j*4
			
			#stampa
			li $v0, 1
			add $a0,$t8,$0
			syscall
			li $v0, 4
			la $a0, space
			syscall
			
			
			sw $t8,($t9) #carico nella cella matrix[i][j]
			
			addi $t4,$t4,1 #incremento j
			addi $t6,$t6,4 #cambio cella
			
			bne $t4,4,loop1 
		#stampa
		li $v0, 4 
		la $a0, newLine
		syscall

		li $t4, 0 #azzero j
		add $t6,$t1,$0 #ritorno alla prima cella del vettore v1
		
		addi $t3,$t3,1 #incremento i
		addi $t5,$t5,4 #cambio cella v0
		bne $t3,4,loop0
		
	li $t3, 0 # i
	li $t4, 0 # j
	
	printLoop1:
		printLoop2:
		
			#calcolo indirizzo matrix base_address + i*N*4 + j*4
			mul $t9,$t3,16 #i*N*4
			mul $s0,$t4,4 #j*4
			add $t9,$t9,$s0 #i*N*4 + j*4
			add $t9,$t9,$t2#matrix base_address + i*N*4 + j*4
			
			lw $t0,($t9)
			
			#stampa
			li $v0, 1
			add $a0,$t0,$0
			syscall
			li $v0, 4
			la $a0, space
			syscall
			
		
			addi $t4,$t4,1
			bne $t4,4,printLoop2
			
		#stampa
		li $v0, 4 
		la $a0, newLine
		syscall
		addi $t3,$t3,1
		li $t4, 0
		bne $t3,4,printLoop1
	
	li $v0, 10
	syscall
	.end main
