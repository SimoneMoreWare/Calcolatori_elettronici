.data
	h0: .half 874 #per dichiarare una halfword uso .half e un numero decimale
	
.text
.globl main
.ent main

main:

	lh $t0,h0 #in $t0 salvo il contenuto della halfword
	
	add $t1,$0,$0 #contatore
	add $t2,$0,$0 #contatore_iterazioni
	
	j loop # devo primare eseguire il loop
	
	increment:
		addi $t1,$t1,1 #incremento contatore 
		srl $t0,$t0,1 #sposto tutti i bit a destra di una posizione in modo tale che nel loop posso accedere all ultimo bit
		addi $t2,$t2,1 #incremento indice
		beq $t2,16,fine #se sono nell'ultima iterazione devo andare alla fine, per stampare i risultati
		
	
	loop:
		andi $t3,$t0,1 #maschera, isolo l ultimo bit e lo salvo in $t3, in questo modo posso vedere questo, se $t3 ha tutti 0 significa che nell ultimo bit ce 0, altrimenti c'e' 1
		bne $t3,$0,increment #se $t3 e diverso da 0 allora e' 1 e significa che devo incrementare
		srl $t0,$t0,1 #qui vado se e solo se $t3 e' uguale a zero, e sposto tutti i bit a destra di una posizione in modo tale che nel loop posso accedere all ultimo bit
		addi $t2,$t2,1 #incremento indice
		bne $t2,16,loop #finche non raggiungo le 16 iterazioni io rivado nell'etichetta loop
		
	fine:
		li $v0,1 #codice per stampare numero intero
		add $a0,$t1,$0 #metto in $a0 il contenuto di $t1
		syscall
		

		li $v0, 10
		syscall
		.end main
