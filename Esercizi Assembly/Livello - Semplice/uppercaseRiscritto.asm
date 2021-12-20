#il programma riceve in input una stringa e la trasforma in uppercase
.data
in_prompt:	.asciz	"Inserisci una stringa: "
out_prompt:	.asciz	"La stringa convertita e': "
in_space:	.space	31
.text
.globl	main
main:	la	a0,in_prompt
	li	a7,4
	ecall
	
	la	a0,in_space
	li	a1,31
	li	a7,8
	ecall

	la	a0,out_prompt
	li	a7,4
	ecall
	
	la	t0,in_space
	li	t2,'a'
	li	t3,'z'
	
loop:	lbu	t1,0(t0)
	beqz	t1,exit
	blt	t1,t2,no_ch
	bgt	t1,t3,no_ch
	addi	t1,t1,-32
	
	sb	t1,0(t0)
no_ch:	addi	t0,t0,1
	j	loop
	
	
exit:	la	a0,in_space
	li	a7,4
	ecall
	
	li	a7,10
	ecall



