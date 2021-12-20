#nome: giuliano Ranauro
#programma: Leaf_Example 
.data
g:	.word 5
h:	.word 5
i:	.word 3
j:	.word 3

prompt_in:	.asciz "Inserisci una parola di massimo 256 caratteri"
.text
.globl main
main:
	la	a0,prompt_in
	li	a7,4
	ecall
	
	mv 	a0,sp
	li	a1,256
	li	a7,8
	ecall
	
	li	a7,4
	ecall
	
	#lw 	a0,g
	lw 	a1,h
	lw	a2,i
	lw	a3,j
	
	jal 	ra,leaf_example
	li	a7,10
	ecall
	


leaf_example:
	addi	sp,sp,-24
	sw	s0,16(sp)
	sw	s1,8(sp)
	sw	s4,0(sp)
	add	s0,a0,a1
	add	s1,a2,a3
	sub	s4,s0,s1
	addi	a0,s4,0
	lw	s4,0(sp)
	lw	s1,8(sp)
	lw	s0,16(sp)
	addi 	sp,sp,24
	jr	ra
