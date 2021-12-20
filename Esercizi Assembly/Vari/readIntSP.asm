.globl main
.data

.text
main:
	addi	sp,sp,-4
	mv	a0,sp
	li	a7,5
	ecall
	
	mv	a0,sp
	lw	a0,0(sp)
	li	a7,1
	ecall
	
	
	li	a7,10
	ecall



