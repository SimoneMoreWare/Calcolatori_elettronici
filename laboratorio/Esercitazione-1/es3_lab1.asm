.data 
	op1: .byte 150 #attenzione, i valori massimi rappresentabili su 8 bit con segno è 2^7 = 128
	op2: .byte 100
	
.text
.globl main
.ent main

main:
	lbu $t0,op1 #caricare in un registro il valore presente in una cella di memoria compresa tra 0-255
	
	lb $t1,op2 #carico in un registro un byte dalla memoria princiaple
	
	add $a0,$t0,$t1 #memorizzo nel registro $a0, utilizzato poi per la stampa, il valore derivante dalla somma tra i due registri
	
	li $v0,1 #codice per stampa intero, stamperà il contenuto di $a0
	syscall
	
	li $v0,10
	syscall
	.end main
