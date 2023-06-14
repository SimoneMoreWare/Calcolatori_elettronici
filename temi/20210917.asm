#elemento i,j matrice c media tra elemento i,j di A ed elemento i,j di B

N = 3
M = 4
.data
	matriceA: 	.word 0xAB317811, 0xCD514229, 0xEF832040, 0xA1346269
				.word 0xB2178309, 0xC3524578, 0x65702887, 0x59227465
				.word 0x14930352, 0x24157817, 0x39088169, 0x63245986
	
	matriceB: 	.word 0x39916800, 0x47900160, 0x62270208, 0x87178291
				.word 0xA7674368, 0xB2092278, 0xC3556874, 0xD6402373
				.word 0xE1216451, 0x24329020, 0x51090942, 0x11240007

	matriceC: .space N * M * 4

.text
.globl main
.ent main
main: 
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, matriceA
	la $a1, matriceB
	la $a2, matriceC
	li $a3, N
	li $t0, M
	subu $sp, $sp, 4
	sw $t0, ($sp)
	jal MediaMatrice	
	
	la $t0,matriceA
	li $t1,0 #i
	
	printLoopARiga:
		li $t2, 0 #j
		printLoopAColonna:
			lw $a0,($t0)
			li $v0, 1
			syscall
			li $v0, 11
			li $a0,' '
			syscall
			addi $t2,$t2,1
			addi $t0,$t0,4
			bne $t2,4,printLoopAColonna
		li $v0, 11
		li $a0,'\n'
		syscall
		addi $t1,$t1,1
		bne $t1,3,printLoopARiga
		
		
	li $v0, 11
	li $a0,'\n'
	syscall
	la $t0,matriceB
	li $t1,0 #i
	
	printLoopBRiga:
		li $t2, 0 #j
		printLoopBColonna:
			lw $a0,($t0)
			li $v0, 1
			syscall
			li $v0, 11
			li $a0,' '
			syscall
			addi $t2,$t2,1
			addi $t0,$t0,4
			bne $t2,4,printLoopBColonna
		li $v0, 11
		li $a0,'\n'
		syscall
		addi $t1,$t1,1
		bne $t1,3,printLoopBRiga
		
		
	li $v0, 11
	li $a0,'\n'
	syscall
	la $t0,matriceC
	li $t1,0 #i
	
	printLoopCRiga:
		li $t2, 0 #j
		printLoopCColonna:
			lw $a0,($t0)
			li $v0, 1
			syscall
			li $v0, 11
			li $a0,' '
			syscall
			addi $t2,$t2,1
			addi $t0,$t0,4
			bne $t2,4,printLoopCColonna
		li $v0, 11
		li $a0,'\n'
		syscall
		addi $t1,$t1,1
		bne $t1,3,printLoopCRiga
		
	
	addiu $sp, $sp, 4
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	.end main
	
.globl MediaMatrice
.ent MediaMatrice
MediaMatrice:
	
	li $t2, 0 #i
	lw $t7,($sp)
	li $t9,0x80000000
	loopRiga:
		li $t3, 0 #j
		loopColonna:
			lw $t0,($a0)
			lw $t1,($a1)
			
			srl $t4,$t0,31
			srl $t5,$t1,31
			
			bne $t4,$t5,setAvgDirectly
			
			j setAvgWithAddu #stesso segno
			
			setAvgDirectly:
				add $t6,$t0,$t1
				sra $t6,$t6,1
				sw $t6,($a2)
				addi $a2,$a2,4
				
			j next	
				
			setAvgWithAddu:
				addu $t6,$t0,$t1
				srl $t6,$t6,1
				beq $t4,1,putSegnoMeno
				j nextSetAvgWithAddu
				putSegnoMeno:
					or $t6,$t6,$t9
				nextSetAvgWithAddu:
					sw $t6,($a2)
					addi $a2,$a2,4
			
			next:
				addi $t3,$t3,1
				addi $a0,$a0,4
				addi $a1,$a1,4
				bne $t3,$t7,loopColonna
		
		addi $t2,$t2,1
		bne $t2,$a3,loopRiga
			
	
	
	jr $ra
	.end MediaMatrice
