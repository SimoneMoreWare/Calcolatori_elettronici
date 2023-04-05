.data 
	msgError: .asciiz "Non rappresentabile su byte"
	msgSucc: .asciiz "Risultato operazione\n"
.text
.globl main
.ent main

main:

	li $v0,5
	syscall
	move $t0,$v0
	
	li $v0,5
	syscall
	move $t1,$v0
	
	li $t2,128
	li $t3,-127
	
	bgt $t0,$t2,jump
	blt $t0,$t3,jump
	bgt $t1,$t2,jump
	blt $t0,$t3,jump
	
	li $v0,4
	la $a0,msgSucc
	syscall
	
	not $t3, $t1 # not B
	and $t3, $t0, $t3 # A and (not B)
	not $t3, $t3 # not (A and (not B))
	xor $t0, $t0, $t1 # A xor B
	or $t0, $t0, $t3 # not (A and (not B)) or (A xor B)
	
	li $v0,1
	move $a0,$t0
	syscall
	j fine
	
	jump:
		li $v0, 4
		la $a0,msgError
		syscall
	
	fine:
		li $v0, 10
		syscall
		.end main
