.text
.globl main
.ent main

main:

	li $v0, 5
	syscall
	add $a0, $v0, $0 #a1
	
	li $v0, 5
	syscall
	add $a1, $v0, $0 #b1
	
	li $v0, 5
	syscall
	add $a2, $v0, $0 #a2
	
	li $v0, 5
	syscall
	add $a3, $v0, $0 #b2
	
	jal determinante2x2
	
	add $s0,$v0,$0
	
	li $v0, 1
	add $a0,$s0,$0
	syscall
	
	li $v0, 10
	syscall
	.end main
	
.globl determinante2x2
.ent determinante2x2

determinante2x2:
	
	mul $t0,$a0,$a3
	mul $t1,$a2,$a1
	sub $v0,$t0,$t1
	
	jr $ra
	.end determinante2x2
