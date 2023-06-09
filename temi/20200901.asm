DIM = 64
.data
	vetRX: .byte 0x84, 0xFA, 0x09, 0x54, 0x20, 0x42, 0x19, 0x20, 0x41, 0xB1, 0x03
	vetTX: .space DIM

.text
.globl main
.ent main
main: 
	la $a0, vetRX
	la $a1, vetTX
	jal SpaceRemove
	add $t0,$v0,$0
	la $t1,vetTX
	li $t2,0
	printLoop:
			lb $t3,($t1)
			li $v0, 1
			add $a0,$t3,$0
			syscall
			li $v0, 11
			li $a0, ' '
			syscall
			addi $t1,$t1,1
			addi $t2,$t2,1
			bne $t2,$t0,printLoop
	li $v0, 10
	syscall
	.end main
	
.globl SpaceRemove
.ent SpaceRemove
SpaceRemove:
	
	add $t0,$a0,$0
	add $t1,$a1,$0
	
	lb $t2,($t0)
	addi $t0,$t0,1
	lb $t3,($t0)
	addi $t0,$t0,1
	sb $t3,($t1)
	addi $t1,$t1,1
	sb $t2,($t1)
	addi $t1,$t1,1
	
	li $t3, 2 #dim
	
	loop:
		lb $t2,($t0)
		
		bne $t2,0x20,storeRes
		
		j next
		
		storeRes:
			sb $t2,($t1)
			addi $t1,$t1,1
			addi $t3,$t3,1
		
		next:
			addi $t0,$t0,1
			bne $t2,0x03,loop
	
	add $v0,$t3,$0
	jr $ra
	.end SpaceRemove
	
