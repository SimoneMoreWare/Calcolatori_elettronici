.data
	wMat: .word 1, 2, 3, 4, 5, 6, 7, 8, 9

.text
.globl main
.ent main

main:

	addi $sp,$sp,-4
	sw $ra,($sp)

	la $t0,wMat
	lw $a0,($t0) #a1
	lw $a1,4($t0) #b1
	lw $a2,8($t0) #c1
	lw $a3,12($t0) #a2
	lw $t1,16($t0) #b2
	lw $t2,20($t0) #c2
	lw $t3,24($t0) #a3
	lw $t4,28($t0) #b3
	lw $t5,32($t0) #c3
	addi $sp,$sp,-20
	sw $t1,16($sp) #b2
	sw $t2,12($sp) #c2
	sw $t3,8($sp) #a3
	sw $t4,4($sp) #b3
	sw $t5,0($sp) #c3
	
	jal determinante3x3
	
	add $s0,$v0,$0
	li $v0, 1
	add $a0,$s0,$0
	syscall
	
	addi $sp,$sp,20
	
	lw $ra, ($sp) # ripristina $ra
	addu $sp, 4 # ripristina $sp
	jr $ra
	.end main
	
.globl determinante3x3
.ent determinante3x3

determinante3x3:

	add $fp,$sp,$0 #fp permette di avere riferimento costante ai parametri ricevuti nel main
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	add $t0,$a0,$0 #a1
	add $t1,$a1,$0 #b1
	add $t2,$a2,$0 #c1
	add $t3,$a3,$0 #a2
	
	# Salvataggio registri $tx
	addi $sp, $sp, -16
	sw $t0, 12($sp)
	sw $t1, 8($sp)
	sw $t2, 4($sp)
	sw $t3, 0($sp)
	lw $a0,16($fp) #b2
	lw $a1,12($fp) #c2
	lw $a2,4($fp) #b3
	lw $a3,0($fp) #c3
	jal determinante2x2
	#ripristino registri $tx
	lw $t3, 0($sp)
	lw $t2, 4($sp)
	lw $t1, 8($sp)
	lw $t0, 12($sp)
	addiu $sp, $sp, 16
	add $s0,$v0,$0
	mul $s0,$s0,$t0

	# Salvataggio registri $tx
	addi $sp, $sp, -16
	sw $t0, 12($sp)
	sw $t1, 8($sp)
	sw $t2, 4($sp)
	sw $t3, 0($sp)
	add $a0,$t3,$0 #a2
	lw $a1,12($fp) #c2
	lw $a2,8($fp) #a3
	lw $a3,0($fp) #c3
	jal determinante2x2
	#ripristino registri $tx
	lw $t3, 0($sp)
	lw $t2, 4($sp)
	lw $t1, 8($sp)
	lw $t0, 12($sp)
	addiu $sp, $sp, 16
	add $s1,$v0,$0
	mul $s1,$s1,$t1
	
	# Salvataggio registri $tx
	addi $sp, $sp, -16
	sw $t0, 12($sp)
	sw $t1, 8($sp)
	sw $t2, 4($sp)
	sw $t3, 0($sp)
	add $a0,$t3,$0 #a2
	lw $a1,16($fp) #b2
	lw $a2,8($fp) #a3
	lw $a3,4($fp) #b3
	jal determinante2x2
	#ripristino registri $tx
	lw $t3, 0($sp)
	lw $t2, 4($sp)
	lw $t1, 8($sp)
	lw $t0, 12($sp)
	addiu $sp, $sp, 16
	add $s2,$v0,$0
	mul $s2,$s2,$t2
	
	sub $s0,$s0,$s1
	add $s0,$s0,$s2

	add $v0,$s0,$0
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

.globl determinante2x2
.ent determinante2x2	
determinante2x2:
	mul $t0, $a0, $a3
	mul $t1, $a1, $a2
	sub $v0, $t0, $t1
	jr $ra
	.end determinante2x2
