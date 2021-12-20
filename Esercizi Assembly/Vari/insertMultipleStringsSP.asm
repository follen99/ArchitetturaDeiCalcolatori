.globl main
.data
pr1:	.asciz	"Numero di stringhe da immettere: "
pr2:	.asciz	"Immetti le stringhe: "

strings:	.word	1

.text
main:
	la	a0,pr1
	li	a7,4
	ecall
	
	li	a7,5
	ecall
	
	la	t0,strings
	sw	a0,0(t0)	#salvo quante stringhe voglio immettere
	li	t0,0		#pulisco
	
	jal	insertStrings
	
	
	jal printAllStrings
	
	li	a7,10
	ecall

printAllStrings:
	la	t0,strings
	lw	t0,0(t0)	#numero di stringhe
	mv	s0,t0		#salvo il numero di stringhe
	
	li	t1,25
	mul	t0,t0,t1	#25*num stringhe
	
	sub	sp,sp,t0	#spiazzo per n stringhe		#######parte importante#######
	
	li	t1,0
	li	t0,0		#pulisco
printLoop:
	beqz	s0,return
	addi	s0,s0,-1

	mv	a0,sp
	li	a7,4
	ecall
	
	addi	sp,sp,25
	j	printLoop
return:
	jr	ra

insertStrings:
	la	s0,strings
	lw	s0,0(s0)	#numero di stringhe da immettere

insertLoop:
	beqz	s0,restore
	addi	s0,s0,-1

	addi	sp,sp,-25	#25 ch piu terminatore
	mv	a0,sp		#leggo la stringa
	li	a7,8
	li	a1,25
	ecall		
	
	j	insertLoop
	
restore:
	la	t0,strings
	lw	t0,0(t0)	#carico quante stringhe ho immesso
	
	li	t1,25
	mul	t0,t1,t0	#25*stringhe immesse
	
	add	sp,sp,t0	#reimposto lo stack pointer
	
	li	t0,0
	li	t1,0		#pulisco
	
	jr	ra
	
	
	
	
	