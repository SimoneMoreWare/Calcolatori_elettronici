.data
	DIM = 3
	
.text
.globl main
.ent main

main:
	
	add $t1,$0,$0 #variabile somma
	add $t2,$0,$0 #contatore
	
	loop:
		li $v0,5
		syscall
		add $t0,$v0,$0
		add $t1,$t1,$t0
		addi $t2,1
		bne $t2,DIM,loop
		
	div $t1,$t1,$t2
	
	li $v0,1
	add $a0,$t1,$0
	syscall
		
	#– Si noti il tipo di arrotondamento effettuato sul
	# risultato della divisione
	# per difetto
	
	li $v0,10
	syscall
	.end main