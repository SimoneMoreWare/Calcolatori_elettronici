.data
	str_orig: .asciiz "% nella citta' dolente, % nell'eterno dolore, % tra la perduta gente"
	str_sost: .asciiz "per me si va"
	str_new: .space 200

.text
.globl main
.ent main

main:
	la $a0, str_orig
	la $a1, str_sost
	la $a2, str_new
	jal sostituisci
	
	add $s0,$v0,$0
	li $v0, 1
	add $a0,$s0,$0
	syscall
	li $v0, 11
	li $a0,'\n'
	syscall
	
	li $v0, 4
	la $a0, str_new
	syscall
	
	li $v0, 10
	syscall
	.end main
	
.globl sostituisci
.ent sostituisci	
sostituisci:
	
	add $t0,$a0,$0
	add $t1,$a1,$0
	add $t2,$a2,$0
	li $t3, 0 #lunghezza
	
	loop:
		lb $t4,($t0)
		beq $t4,'%',insertStrSost
		
		j insertStrOrig
		
		insertStrSost:
			add $t1,$a1,$0
			loop2:
				lb $t5,($t1)
				beq $t5,0,next
				sb $t5,($t2)
				addi $t2,$t2,1
				addi $t1,$t1,1
				addi $t3,$t3,1
				j loop2
				
		insertStrOrig:		
			sb $t4,($t2)
			addi $t2,$t2,1
			addi $t3,$t3,1
		next:
			addi $t0,$t0,1
			bne $t4,0,loop
	
	add $v0,$t3,$0
	jr $ra
	.end sostituisci
