.globl main
.data
strings:	.space	31	#spazio per 30 ch
strLen:		.word 	1	#numero che verra' sovrascritto
.text
main:
	la	a0,strings
	jal	readString
	
	la	a0,strLen
	sw	a1,0(a0)
	
	li	a0,0
	li	a1,0
	
	la	a0,strLen
	lw	a0,0(a0)
	
	li	a7,1
	ecall
	
	la	a0,strings
	li	a7,4
	ecall
	
	li	a7,10
	ecall
	
#prende in a0 l'array dove salvare la stringa
#ritorna in a1 la lunghezza della stringa
readString:
	mv	t0,a0		#sposto a0
	li	a0,0		#pulisco
	li	a1,0		#contatore
readLoop:
	li	a7,12		#ho in a0 il carattere
	ecall	
	
	li	t1,10		#ascii terminatore
	beq	a0,t1,return	#esco se premo invio
	
	sb	a0,0(t0)	#salvo il carattere
	addi	t0,t0,1		#inc pointer
	addi	a1,a1,1		#incr counter
	j	readLoop
	
return:
	jr	ra		#ritorno
	