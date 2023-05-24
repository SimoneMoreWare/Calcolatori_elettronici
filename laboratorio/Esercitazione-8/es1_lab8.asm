.data
	ora_in: .byte 12, 47
	ora_out: .byte 18, 14
	X: .byte 1
	Y: .byte 40
	
.text
.globl main
.ent main

main: 
	la $a0, ora_in 
	la $a1, ora_out 
	lbu $a2, X
	lbu $a3, Y
	jal costoParcheggio
	add $s0,$v0,$0
	li $v0, 1
	add $a0,$s0,$0
	syscall
	li $v0, 10
	syscall
	.end main
	
.globl costoParcheggio
.ent costoParcheggio
costoParcheggio:
	lb $t0,0($a0)
	lb $t1,1($a0)
	lb $t2,0($a1)
	lb $t3,1($a1)
	
	mul $t0,$t0,60
	
	li $v0, 1
	add $a0,$t0,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	
	add $t0,$t0,$t1
	li $v0, 1
	add $a0,$t0,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall

	mul $t2,$t2,60
	li $v0, 1
	add $a0,$t2,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	
	add $t2,$t2,$t3
	li $v0, 1
	add $a0,$t2,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall

	sub $t0,$t2,$t0
	li $v0, 1
	add $a0,$t0,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	
	div $t0,$a3
	mflo $t1
	addi $t1,$t1,1
	li $v0, 1
	add $a0,$t1,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	mul $t1,$t1,$a2
	li $v0, 1
	add $a0,$t1,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	add $v0,$t1,$0
	li $v0, 1
	add $a0,$t1,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	jr $ra
	.end costoParcheggio	
