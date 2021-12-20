#descrizione:	il programma riceve una stringa e la converte in uppercase
.data
name_prompt:	.asciz	"Inserisci il nome: "
out_prompt:	.asciz	"Il nome in UC e': "
in_name:	.space	31	#spazio riservato
.text
.globl	main
main:	la	a0,name_prompt
	li	a7,4
	ecall
	
	la	a0,in_name
	li	a1,31
	li	a7,8
	ecall
	
	la	t0,in_name
	li	t2,'a'
	li	t3,'z'

loop:	lbu	t1,0(t0)
	beqz	t1,exit		#esco se nullo
	blt	t1,t2,no_change
	bgt	t1,t3,no_change
	addi	t1,t1,-32
	sb	t1,0(t0)
no_change:
	addi	t0,t0,1
	j	loop
exit:
	la	a0,in_name
	li	a7,4
	ecall
	
	li	a7,10
	ecall
	
	