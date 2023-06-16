DIM = 6
.data
	vetB: .byte 2, 14, 119, 54, 10, 41
	vetN: .space DIM

.text
.globl main
.ent main
main: 
	la $a0, vetB
	la $a1, vetN
	li $a2, DIM
	jal Cambio
	
	la $t0,vetN
	li $t1,0
	
	loopPrint:
		lb $t2,($t0)
		li $v0, 1
		add $a0,$t2,$0
		syscall
		li $v0, 11
		li $a0,' '
		syscall
		addi $t0,$t0,1
		addi $t1,$t1,1
		bne $t1,DIM,loopPrint
	
	li $v0, 10
	syscall
	.end main
	
.globl Cambio
.ent Cambio

Cambio:
	li $t0, 0 #i
	loopValue:
		li $t1, 1 #j
		lb $t2,($a0)
		li $t5, 0 #res
		loopBit:
			
			andi $t3,$t2,1
			srl $t2,$t2,1
			andi $t4,$t2,1
			
			bne $t4,$t3,incrementRes
			
			j nextLoopBit
			
			incrementRes:
				addi $t5,$t5,1
			
			nextLoopBit:
				addi $t1,$t1,1
				bne $t1,8,loopBit
		
		sb $t5,($a1)
		addi $a1,$a1,1
		addi $t0,$t0,1
		addi $a0,$a0,1
		bne $t0,$a2,loopValue
	
	
	jr $ra
	.end Cambio
