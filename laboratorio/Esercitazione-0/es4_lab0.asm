.data
	wVett: .word 5, 7, 3, 4
	wResult: .space 4
	
.text
.globl main
.ent main

main:

	la $t0,wVett
	
	#variabile sum
	and $t4,$0,$0
	
	#variabile i
	and $t3,$0,$0
	
	loop:
		lw $t1,($t0)
		add $t4,$t4,$t1
		addi $t0,$t0,4
		addi $t3,$t3,1
		bne $t3,4,loop
		
	la $t0,wResult
	sw $t4,($t0)
	
	li $v0,10
	syscall
	.end main