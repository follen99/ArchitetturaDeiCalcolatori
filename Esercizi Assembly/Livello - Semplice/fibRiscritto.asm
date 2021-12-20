#fibonacci riscritto
.data
in_prompt:	.asciz	"Inserisci fino a quale cifra vuoi calcolare la serie: "
out_prompt:	.asciz 	"La serie e': "
space_b:	.asciz	", "
.text
.globl	main
main:	#stampo la frase in
	la	a0,in_prompt
	li	a7,4
	ecall

	#leggo la cifra
	li	a7,5
	ecall
	mv	a1,a0
	
	#stampo la frase out
	la	a0,out_prompt
	li	a7,4
	ecall
	
	li	t0,0
	li	t1,1
	
loop:	beqz	a1,exit
	add	a0,t0,t1
	jal	print
	addi	a1,a1,-1
	add	t1,zero,t0
	add	t0,zero,a0
	j	loop
	
	
print:	li	a7,1
	ecall
	mv	t2,a0
	la	a0,space_b
	li	a7,4
	ecall
	mv	a0,t2
	jr	ra

exit:	li	a7,10
	ecall
	