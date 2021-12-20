#descrizione: uppercase to lowercase
.data
in_prompt:	.asciz	"inserisci il nome con le maiuscole che vuoi: "
out_prompt:	.asciz	"Il nome tutto in lowercase e': "
in_name:	.space	31	#30 byte+term
.text
.globl	main
main:	la	a0,in_prompt
	li	a7,4
	ecall
	
	la	a0,in_name
	li	a1,31
	li	a7,8
	ecall
	
	la	a0,out_prompt
	li	a7,4
	ecall
	
	la	t0,in_name
	li	t2,'A'
	li	t3,'Z'
	
loop:	lbu	t1,0(t0)
	beqz	t1,exit
	blt	t1,t2,no_change
	bgt	t1,t3,no_change
	addi	t1,t1,32
	sb	t1,(t0)
no_change:
	addi	t0,t0,1
	j	loop
exit:	la	a0,in_name
	li	a7,4
	ecall
	
	li	a7,10
	ecall