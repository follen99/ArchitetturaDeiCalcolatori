#il programma riceve in input un numero intero in input e da in output il corrispondente binario
.data
in_prompt:	.asciz 	"Inserisci un numero intero: "
out_prompt:	.asciz	"Il numero in binario e': "

in_space:	.word	10
.text
.globl main
main:	la	a0,in_prompt
	li	a7,4
	ecall
	
	la	a0,in_space
	li	a1,10
	li	a7,5
	ecall
	
	mv	t0,a0
	
	la	a0,out_prompt
	li	a7,4
	ecall
	li	t4,2
	li	t6,0
	
loop:	beqz	t0,exit1
	div	t1,t0,t4
	rem	t2,t0,t4
	
	mv	a0,t2
	
	mv	t0,t1
	
	addi	sp,sp,-1
	sb	a0,0(sp)
	addi	t6,t6,1
	j	loop

print:	li	a7,1
	ecall
	jr	ra
print_loop:
	beqz	t6,exit2
	lb	a0,0(sp)
	addi	sp,sp,1
	addi	t6,t6,-1
	li	a7,1
	ecall
	j	print_loop
	
exit1:	j	print_loop
exit2:	li	a7,10
	ecall

	




	
