DIM = 7
.data
	vettore: .byte 11 5 1 4 6 2 12

.text
.globl main
.ent main
main: 
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, vettore
	li $a1, DIM
	jal EvenParity
	add $a0,$v0,$0
	li $v0, 1
	syscall
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end main
	
.globl EvenParity
.ent EvenParity
EvenParity:
	
	add $t0,$a0,$0
	li $t1, 0 #res
	li $t2, 0 #i
	li $t3, 0 #res tmp
	
	loop:
	
		lb $t4,($t0)
		li $t7, 0 #j
		add $t5,$t4,$0

		
		loopBit:
			andi $t6,$t5,1
			
			beq $t6,1,setTmpRes
			
			j nextLoopBit
			
			setTmpRes:
				add $t3,$t3,1
				
			nextLoopBit:
				srl $t5,$t5,1
				addi $t7,$t7,1
				bne $t7,4,loopBit
				
			
		andi $t3,$t3,1

		beq $t3,0,setRes
		
		ori $t4,$t4,0x80
		
		j nextLoop
		
		setRes:
			addi $t1,$t1,1
			
	
		nextLoop:
			addi $t0,$t0,1
			addi $t2,$t2,1
			li $t3, 0
			bne $t2,$a1,loop
	
	add $v0, $t1, $0
	jr $ra
	.ent EvenParity
