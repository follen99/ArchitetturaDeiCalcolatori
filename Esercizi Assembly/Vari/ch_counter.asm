#il programma conta i caratteri presenti in una stringa inserita
.data
in_prompt:	.asciz	"Inserisci una stringa, max 25 char: "
out_prompt1:	.asciz	"La stringa ha "
out_prompt2:	.asciz	" caratteri."

in_lenght:	.space	26	#max 25 char+1 term
.text
.globl	main
main:	#stampo la stringa in
	la	a0,in_prompt
	li	a7,4
	ecall
	#immetto la stringa in a0
	la	a0,in_lenght
	li	a1,26
	li	a7,8
	ecall
	
	mv	t0,a0
	
	la	a0,out_prompt1
	li	a7,4
	ecall
	li	a0,0
	
loop:	lbu	t1,0(t0)
	beqz	t1,exit		#se la stringa e' vuota esco
	addi	a0,a0,1
	addi	t0,t0,1
	j	loop
exit:	addi	a0,a0,-1
	li	a7,1
	ecall
	la	a0,out_prompt2
	li	a7,4
	ecall
	
	li	a7,10
	ecall
	