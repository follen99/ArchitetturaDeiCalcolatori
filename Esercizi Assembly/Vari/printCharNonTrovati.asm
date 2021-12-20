#il programma prende in input una stringa e stampa i caratteri non presenti.
.globl main
.data
pr1:	.asciz	"Inserisci una stringa, max 30 char: "
pr2:	.asciz	"I caratteri non presenti sono: "

in_str:	.space	31	#30 ch

.text
main:
	la	a0,pr1
	li	a7,4
	ecall
	
	la	a0,in_str
	li	a1,31
	li	a7,8
	ecall
	
	li	a1,0		#pulisco
	
	la	a0,pr2
	li	a7,4
	ecall
	
	jal	nonPresent
	
	li	a7,10
	ecall

nonPresent:
	addi	sp,sp,-4
	sw	ra,0(sp)	#salvo ra

	li	t3,'a'		#assumo che le stringhe siano lowercase
	li	t1,'z'		#tetto max
presentLoop:
	bgt	t3,t1,restore	#esco se ho fatto tutto il giro
	mv	a1,t3		#sposto la lettera in a1 per la funzione
	la	a0,in_str	#carico la stringa
	jal	findChar	#ritorna in a1 1 o 0
	
	addi	t3,t3,1		#incremento la lettera
	
	bgtz	a1,presentLoop	#se lo trovo itero (non stampo)
	
	mv	t2,a0		#salvo a0
	mv	a0,t3		#sposto la lettera in a0 e la stampo
	addi	a0,a0,-1	#decremento di uno perche' ho incrementato prima
	li	a7,11
	ecall
	
	addi	a0,a0,1		#reincremento
	mv	a0,t2
	
	j	presentLoop

restore:
	li	t0,0
	li	t1,0
	li	t2,0
	li	t3,0
	li	a0,0
	li	a1,0
	
	lw	ra,0(sp)
	addi	sp,sp,4
	jr	ra

#riceve in a0 l'indirizzo
#riceve in a1 il carattere da cercare
#ritorna in a1 0 se il carattere NON e' trovato, 1 se e' trovato
findChar:
	mv	s0,a1		#salvo il carattere da cercare cosi posso sporcare a1
findLoop:
	lbu	t0,0(a0)	#carico il carattere
	beqz	t0,return	#se zero ritorno
	addi	a0,a0,1		#incremento
	
	li	a1,0
	bne	s0,t0,findLoop	#itero
	li	a1,1
	j	return		#ritorno 1 se l'ho trovato

return:
	jr	ra
	
	
	
	
	
	
