#program reads and prints a string
.data
in_prompt:	.asciz	"immetti una stringa di max 10ch: "
out_prompt:	.asciz	"la stringa immessa e': "
str:		.space	11

.text
.globl	main
main:	la	a0,in_prompt
	li	a7,4
	ecall
	
	la	a0,str
	li	a1,11
	li	a7,8
	ecall
	
	la	a0,out_prompt
	li	a7,4
	ecall
	la	a0,str
	li	a7,4
	ecall