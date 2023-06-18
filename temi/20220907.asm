#lunghezza della piu lunga sequenza di caratteri esistente nella seconda stringa e presente anche nella prima
#caratteri della sequenza in comune:
# possono iniziare in un qualunque punto delle stringhe
# possono termina in un qualunque punto delle stringhe
# possono non essere presenti consecutivament enelle due stringhe
# devono essere presenti nello stesso ordine in entrambe le stringhe

.data
	stringa1: .asciiz "calcolatori elettronici"
	stringa2: .asciiz "raccolta"

.text
.globl main
.ent main
main: 
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, stringa1
	la $a1, stringa2
	jal cercaSequenza
	
	add $a0,$v0,$0
	li $v0, 1
	syscall
	
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end main
	
.globl cercaSequenza
.ent cercaSequenza

cercaSequenza:

	add $t0,$a0,$0 #stringa 1
	add $t1,$a1,$0 #stringa 2
	
	li $t2, 0 #res
	
	loopSecondaStringa:
		
		add $t3,$t1,$0 #indirizzo primo carattere che man mano shifta
		lb $t4,($t1) #carattere corrente i esimo seconda stringa
		beq $t4,0,next
		add $t0,$a0,$0 #inizializzo indirizzo prima cella stringa 1
		li $t6, 0 #risultato parziale
		
		loopCercaSequenza:
			lb $t5,($t0)
			
			beq $t5,$t4,setCercaSequenza
			
			j nextCercaSequenza
			
			setCercaSequenza:
				addi $t6,$t6,1
				addi $t3,$t3,1
				lb $t4,($t3)
				beq $t4,0,endLoopCercaSequenza
			
			nextCercaSequenza:
				addi $t0,$t0,1
				bne $t5,0,loopCercaSequenza
				
		endLoopCercaSequenza:
		
			bgt $t6,$t2,setMax
			
			j nextLoopSecondaStringa
			
			setMax:
				add $t2,$t6,$0
			
			nextLoopSecondaStringa:
				addi $t1,$t1,1
				j loopSecondaStringa
		
		
	next:
		add $v0,$t2,$0
		jr $ra
		.end cercaSequenza
