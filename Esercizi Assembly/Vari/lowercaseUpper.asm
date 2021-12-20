#il programma riceve una stringa e converte i caratteri in uppercase
.globl main
.data
pr1:	.asciz	"Inserisci una stringa (max 30 char): "
pr2:	.asciz	"La stringa in uppercase e': "
in_str:	.space	31


.text
main:
	la	a0,pr1		#stampo la stringa
	li	a7,4
	ecall
	
	la	a0,in_str	#leggo la stringa
	li	a1,31
	li	a7,8
	ecall
	
	la	a0,pr2		#stampo la seconda stringa
	li	a7,4
	ecall
	li	a0,0		#pulisco a0
	
	la	a0,in_str
	jal	toUpperCase
	
	la	a0,in_str
	li	a7,4
	ecall
	
	li	a7,10
	ecall


#la funzione riceve in a0 l'indirizzo della stringa da convertire
toUpperCase:
	lbu	t0,0(a0)	#carico il carattere n
	beqz	t0,return	#esco se ho finito la stringa
	addi	a0,a0,1		#incremento
	
	
	li	t1,97
	blt	t0,t1,toUpperCase
	li	t1,122
	bgt	t0,t1,toUpperCase
	li	t1,0		#pulisco
	
	addi	t1,t0,-32	#scendo di 32 byte

	addi	a0,a0,-1
	sb	t1,0(a0)
	addi	a0,a0,1
	
	j	toUpperCase

return:
	jr	ra


