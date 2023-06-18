#t_amb < t_desiderata -> y=-1, altrimenti y=K*intervalli
# vett diff (t_amp-t_desiderata)

DIM=5
.data
	costante: .word 12
	intervalli: .byte 0 2 4 7 10

.text
.globl main
.ent main
main: 
	subu $sp, $sp, 4
	sw $ra, ($sp)

	li $a0, 31
	li $a1, 25
	la $a2, intervalli
	la $a3, costante
	jal clima

	add $s0,$v0,$0
	li $v0, 1
	add $a0,$s0,$0
	syscall
	
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end main
	
.globl clima
.ent clima
clima:

	blt $a0,$a1,setYwrong

	add $t0,$a0,$0 #temp ambientale
	add $t1,$a1,$0 #temp desiderata
	sub $t1,$t0,$t1 #differenza
	add $t2,$a2,$0 #vett intervall
	lw $t3,($a3) #costante
	li $t4, 0 #flag
	li $t5, 0 #i
	loop:
	
		lb $t6, ($t2)
		
		bge $t6,$t1,setY
		
		j nextLoop
		
		setY:
			mul $v0,$t3,$t5
			j next
		
		nextLoop:
			addi $t5,$t5,1
			addi $t2,$t2,1
			bne $t5,DIM,loop
			
	mul $v0,$t3,DIM
		
	j next
	
	setYwrong: 
		li $v0, -1

	next:
		jr $ra
		.end clima
