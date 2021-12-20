.globl main
.data
size:	.word	5
#array:	.word	2,500,4,-20,10
array:	.word	0:50

pr1:	.asciz	"Inserisci i numeri, termina inserendo 0.\n"
pr2:	.asciz	"Numero "
pr3:	.asciz	"Numeri ordinati: "
.text
main:	
	jal	readNums
	
	
	la	a0,pr3
	li	a7,4
	ecall
	
	la	a0,array
	jal	printInOrder
	
	
	li	a7,10
	ecall

#salva i numeri letti in "array"
readNums:
	la	a0,pr1
	li	a7,4
	ecall
	
	li	a3,0		#contatore
	
	la	a2,array	#indirizzo di salvataggio
	
	
readLoop:
	####### INIZIO STAMPA ######
	la	a0,pr2
	li	a7,4
	ecall
	
	mv	a0,a3
	addi	a3,a3,1		#incremento contatore
	
	li	a7,1
	ecall
	
	li	a0,':'
	li	a7,11
	ecall
	
	li	a0,' '
	li	a7,11
	ecall
	
	####### FINE STAMPA ######
	
	li	a7,5		#leggo
	ecall
	
	beqz	a0,endRead
	
	sw	a0,0(a2)	#salvo il numero
	addi	a2,a2,4		#incremento puntatore
	
	j	readLoop

endRead:
	la	t0,size
	addi	a3,a3,-1
	sw	a3,0(t0)	#salvo la lunghezza dell'array
	
	jr	ra

#riceve il puntatore all'elemento da eliminare in a0
deleteElement:
	lw	t0,4(a0)	#carico l'elemento successivo
	beqz	t0,deleteLast	#se ho finito l'array torno
	sw	t0,0(a0)	#salvo l'el succ sull'el corrente
	
	addi	a0,a0,4
	j	deleteElement	#itero
deleteLast:
	sw	zero,0(a0)	#imposto a zero l'ultimo
	jr	ra

#riceve in a0 l'indirizzo della stringa
#riceve in a1 l'elemento da cercare
findElement:
	addi	sp,sp,-4	
	sw	ra,0(sp)
	
	la	t3,size
	lw	t3,0(t3)	#carico lunghezza
findLoop:
	beqz	t3,notFound	
	addi	t3,t3,-1
	
	lw	t1,0(a0)	#carico l'el
	#addi	a0,a0,4		#incr pointer
	
	beq	t1,a1,found
	addi	a0,a0,4		#incr
	j	findLoop
	
#invoco la funzione deleteElement
found:	
	jal	deleteElement	#elimina quell'elemento
notFound:
	lw	ra,0(sp)	#riprendo ra
	addi	sp,sp,4
	
	jr	ra		#torno
	
	
#prende in a0 l'indirizzo dell'array
printInOrder:
	addi	sp,sp,-4
	sw	ra,0(sp)	#salvo ra

	mv	s0,a0		#salvo a0 in s0
	
	la	t2,size
	lw	t2,0(t2)	#carico la lunghezza dell'array
printLoop:
	beqz	t2,restore	#torno se ho trovato tutti i numeri
	addi	t2,t2,-1	#decremento
	
	mv	a0,s0
	jal	findSmallest	#trovo il piu' piccolo
	
	mv	a0,a1
	li	a7,1
	ecall
	
	li	a0,' '		#stampo uno spazio
	li	a7,11
	ecall
	
	####	QUI DOVREI ELIMINARE L'ELEMENTO ###
	
	mv	a0,s0			#indirizzo dell'array
	jal	findElement		#in a1 e' gia presente il num da cercare
	
	j	printLoop
	
restore:
	lw	ra,0(sp)
	addi	sp,sp,4
	
	jr	ra		#torno	
	

#prende in a0 l'indirizzo dell'array da controllare
#ritorna in a1 l'elemento piu' piccolo
findSmallest:
	li	a1,10000	#carico un numero molto grande
	la	t1,size
	lw	t1,0(t1)	#carico la lunghezza dell'array
	
findSmallLoop:
	beqz	t1,return	#se scorro tutto torno
	addi	t1,t1,-1	#decremento
	lw	t0,0(a0)	#carico l'elemento n
	addi	a0,a0,4
	
	bgt	t0,a1,findSmallLoop
	beq	t0,zero,findSmallLoop
	mv	a1,t0		#imposto a1 con il numero piu piccolo
	
	j	findSmallLoop
return:
	jr	ra
	

