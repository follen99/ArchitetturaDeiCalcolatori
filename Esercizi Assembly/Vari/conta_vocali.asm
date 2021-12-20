#il programma riceve una stringa e ne conta le vocali
.data
in_prompt:	.asciz	"Immettere una stringa, max 25 ch: "
out_prompt1:	.asciz	"La stringa ha "
out_prompt2:	.asciz	" vocali."

in_space:	.space	26	#max 25 ch
.text
.globl	main
main:	#stampo in prompt
	la	a0,in_prompt
	li	a7,4
	ecall
	
	la	a0,in_space
	li	a1,26
	li	a7,8
	ecall
	
	mv	t0,a0
	la	a0,out_prompt1
	li	a7,4
	ecall
	
	li	a0,0
	
loop:	lbu	t1,0(t0)
	beqz	t1,exit		#se la stringa è vuota esco
	j	check
	addi	t0,t0,1
	j	loop

check:	li	t2,'a'
	beq	t1,t2,incr
	li	t2,'e'
	beq	t1,t2,incr
	li	t2,'i'
	beq	t1,t2,incr
	li	t2,'o'
	beq	t1,t2,incr
	li	t2,'u'
	beq	t1,t2,incr
	addi	t0,t0,1
	j	loop		#se non ho riscontrato una vocale itero
	
	
incr:	addi	a0,a0,1
	addi	t0,t0,1
	j	loop

exit:	li	a7,1
	ecall
	la	a0,out_prompt2
	li	a7,4
	ecall
	
	li	a7,10
	ecall
	