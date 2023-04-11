.data
	v0: .word 53
	v1: .word 12
	v2: .word 1 
	
.text
.globl main
.ent main

main:
	
	lw $t0,v0
	
	lw $t1,v1
	
	lw $t2,v2
	
	bgt $t0,$t1,swapAB
	
	j ifAC
	
	swapAB:
		add $t0,$t0,$t1
		sub $t1,$t0,$t1
		sub $t0,$t0,$t1
	
	ifAC:
		bgt $t0,$t2,swapAC
	
	j ifBC
		
	swapAC:
		add $t0,$t0,$t2
		sub $t2,$t0,$t2
		sub $t0,$t0,$t2
	
	ifBC:
		bgt $t1,$t2,swapBC

	j fine
	
	swapBC:
		add $t1,$t1,$t2
		sub $t2,$t1,$t2
		sub $t1,$t1,$t2
	
	fine:
		li $v0,1
		add $a0,$t0,$0
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		
		li $v0,1
		add $a0,$t1,$0
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		
		li $v0,1
		add $a0,$t2,$0
		syscall
		
		li $v0,10
		syscall
		.end main
