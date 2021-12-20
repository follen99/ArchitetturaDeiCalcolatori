.globl main
.data
.align 2
numBin:	.word	0:8	#massimo 8 
max:	.word	8
len:	.word	1

arrayStatico:	.word	1,1,0,0,1		#ovvero 11
.text
main:
	#la	a0,arrayStatico	
	#li	a1,5
	
	#jal	convertToDec
	#mv	s6,s5
	
	#la	a0,arrayStatico	
	#li	a1,5
	#mv	s7,s5
	
	#add	s5,s6,s7
	
	###########################
	la	a1,numBin
	li	a0,11
	jal	convertDecBin
	
	la	a0,numBin
	li	a1,6
	jal	printRev	#in a1 e' gia presente la lunghezza
	
	##############################
	#TEST FUNZIONE REV
	#la	a0,arrayStatico
	#li	a1,5
	#jal	printRev
	
	
	li	a7,10
	ecall

#riceve in a0 il puntatore alla word che contiene il num
#riceve in a1 la lunghezza del numero
printBin:
	mv	t0,a0
printLoop:
	beqz	a1,return
	addi	a1,a1,-1	#decr
	
	lw	a0,0(t0)	#carico il primo num
	addi	t0,t0,4		#incr
	
	li	a7,1		#stampo
	ecall
	
	j	printLoop
	
#riceve in a0 il puntatore
#riceve in a1 la lunghezza
#la funzione punta all'ultimo elemento dell'array e stampa al contrario.
printRev:
	li	t0,4
	mul	t0,a1,t0	#moltiplico per spiazzare
	add	a0,a0,t0
	addi	a0,a0,-4
	mv	t0,a0
revLoop:
	beqz	a1,return
	addi	a1,a1,-1

	lw	t1,0(t0)	#carico l'ultimo elemento
	addi	t0,t0,-4	#decremento
		
	mv	a0,t1		#stampo l'el
	li	a7,1
	ecall
	
	j	revLoop

	
	

#prende in a0 l'indirizzo della word che contiene il num binario
#prende in a1 la sua lunghezza
convertToDec:
	addi	sp,sp,-4
	sw	ra,0(sp)	#salvo ra

	mv	s0,a0	#salvo l'indirizzo in s0
	mv	s1,a1	#salvo la len in s1
	
	li	s5,0		#la somma (num in dec)
convertDecLoop:
	bltz	s1,restore	#se arrivo a meno di zero esco
	addi	s1,s1,-1	#decremento
	

	beqz	s1,lastNumber

	
	li	a0,2
	mv	a1,s1
	
	jal	pow		#ritorna in a0 la potenza
	
	lw	t0,0(s0)	#carico l'el del bin
	addi	s0,s0,4		#incr il puntatore
	mul	t0,t0,a0	#moltiplico 1/0 per la potenza
	add	s5,s5,t0	#la somma del numero binario va in s5
	
	j	convertDecLoop
restore:
	lw	ra,0(sp)
	addi	sp,sp,4
	jr	ra
lastNumber:
	lw	t0,0(s0)
	beqz	t0,restore
	addi	s5,s5,1
	j	restore
	

#riceve in a1 il puntatore dove salvare
#ritorna in a0 la lunghezza del numero, ma lo salva anche in una word
readNumBin:
	la	t1,max
	lw	t1,0(t1)	#max len
	li	a3,0		#contatore per capire quanto e' lungo
readLoop:
	li	a0,8
	beqz	t1,saveLen	#posso mettere massimo 8 numeri!
	addi	t1,t1,-1
	
	li	a7,12		#leggo come carattere
	ecall
	
	li	a2,1
	li	t0,'1'
	beq	a0,t0,addNum
	
	li	a2,0
	li	t0,'0'
	beq	a0,t0,addNum
	
	mv	t2,a0			#salvo a0
	mv	a0,a3			#ritorno la lunghezza
	li	t0,10
	beq	t2,t0,saveLen
	
	j	readLoop

saveLen:
	la	t0,len
	sw	a0,0(t0)	#salvo la lunghezza della stringa in len
	jr	ra

#riceve in a1 il puntatore
#riceve in a2 0 o 1
addNum:
	sw	a2,0(a1)	#aggiungo 1 all'array
	addi	a3,a3,1		#incr contatore lunghezza
	addi	a1,a1,4
	j	readLoop
	
	

#prende in a0 la base e in a1 l'esponente
#ritorna in a0 la potenza
pow:
	mv	s2,a0		#salvo la base
	addi	a1,a1,-1
	
powLoop:
	beqz	a1,return	#ritorno	
	mul	a0,a0,s2
	
	addi	a1,a1,-1
	
	j	powLoop
return:
	jr	ra
	
#prende in a0 il numero da convertire	
#prende in a1 l'indirizzo dove salvare
#ritorna in a1 la lunghezza
convertDecBin:
	li	s0,2
	mv	t1,a1
	li	a1,0
convertLoop:
	rem	t0,a0,s0	#divido per due e prendo il resto
	div	a0,a0,s0	#divido per due e salvo la divisione
	
	
	
	sw	t0,0(t1)	#salvo il resto
	addi	t1,t1,4		#incr pointer
	beqz	a0,return	#ritorno se il risultato e' zero
	
	addi	a1,a1,1		#lunghezza
	j	convertLoop
	


