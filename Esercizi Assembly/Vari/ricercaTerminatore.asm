.data
str:	.space	31
.text
main:
	la	a0,str
	li	a1,31
	li	a7,8
	ecall
	
	la	a0,str
	lbu	a0,4(a0)
	
	li	a7,1
	ecall
	
	li	a7,10
	ecall