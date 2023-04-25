.data
	opa: .word 2043
	opb: .word 5
	res: .space 4
	
.text
.globl main
.ent main

main:

	la $t1,opa
	la $t2,opb
	lw $t1,($t1)
	lw $t2,($t2)
	la $t3,res

	li $v0, 5
	syscall
	add $t0,$v0,$0
	
	if1:
		beq $t0,0,somma
		j if2
		somma:
			add $t1,$t1,$t2
			sw $t1,($t3)
			j fine
	
	if2:
		beq $t0,1,sottrazione
		j if3
		sottrazione:
			sub $t1,$t1,$t2
			sw $t1,($t3)
			j fine
			
	if3:
		beq $t0,2,moltiplicazione
		j if4
		moltiplicazione:
			mul $t1,$t1,$t2
			sw $t1,($t3)
			j fine
		
	if4:
		beq $t0,3,divisione
		j fine
		divisione:
			div $t1,$t1,$t2
			sw $t1,($t3)
			j fine
		
	fine:
		li $v0, 10
		syscall
		.end main
