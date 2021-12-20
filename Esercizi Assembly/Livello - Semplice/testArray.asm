#il programma fa inserire una stringa su array
.data
in_prompt:	.asciz	"inserisci la stringa:	"
out_prompt:	.asciz	"la stringa e':	"
str:		.space	31

.text
.globl	main
main:	la	a0,in_prompt
	li	a7,4
	ecall
	
	jal	read
	
	la	a0,out_prompt
	li	a7,4
	ecall
	
	mv	a0,a0
	li	a7,4
	ecall
	
	j	exit
	
read:	la	a1,str
	li	a7,8
	ecall
	li	a7,4
	ecall
	jr	ra


exit:	li	a7,10
	ecall