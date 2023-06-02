# Esame 09/07/2019
				
				
				
				DIM = 4
				.data
matrice:		.word 126, -988,   65,   52
				.word   7,    0,    2,  643
				.word  66,  532,   43, 9254
				.word   5,  -51, 4352, -452
				
				.text
				.globl main
				.ent main
				
main:			subu $sp, $sp, 4
				sw $ra, ($sp)
				la $a0, matrice
				li $a1, DIM
				jal calcolaTrasp
				lw $ra, ($sp)
				addiu $sp, $sp, 4
				jr $ra
				.end main
				
				
				
				.globl calcolaTrasp			# INIZIO PROCEDURA
				.ent calcolaTrasp
calcolaTrasp:	sll $t0, $a1, 2				# $t0 = DIM*4 = offset prossimo elemento nella colonna (DIM=4 => $t0=16)
				mul $t1, $a1, 5				# $t1 = DIM*5 = offset prossimo elemento nella diagonale principale (DIM=4 => $t1=20)
				li $t2, 1					# $t2 = contatore ciclo esterno (sulla diagonale principale)
											# CICLO ESTERNO: sulla diagonale principale
cicloEsterno:	add $t3, $a0, 4				# $t3 = riferimento all'elemento successivo di riga
				add $t4, $a0, $t0			# $t4 = riferimento all'elemento successivo di colonna
				move $t7, $t2				# $t7 = contatore per il ciclo interno inizializzato al contatore di ciclo esterno (ad ogni ciclo cicla una volta in meno)
											# CICLO INTERNO: sulla riga e colonna partendo dal rispettivo elemento sulla diagonale principale
cicloInterno:	lw $t5, ($t3)				# lettura elementi
				lw $t6, ($t4)
				sw $t5, ($t4)				# scrittura (invertita) elementi
				sw $t6, ($t3)
				add $t3, $t3, 4				# incremento prossimo elemento di riga
				add $t4, $t4, $t0			# incremento prossimo elemento di colonna
				add $t7, $t7, 1				# incremento il contatore di ciclo interno
				bne $t7, $a1, cicloInterno	# ciclo fino alla fine degli elementi sulla riga/colonna

				add $t2, $t2, 1				# incremento contatore sugli elementi della colonna
				add $a0, $a0, $t1			# aggiorno il riferimento all'elemento successivo sulla diagonale principale
				bne $t2, $a1, cicloEsterno	# ciclo fino alla fine degli elementi sulla diagonale
				
				jr $ra
				.end calcolaTrasp			# FINE PROCEDURA
				
				
				