.globl main
.data
pr1:	.asciz	"Inserisci una stringa (max 30 caratteri): "


.text
main:
	addi	sp,sp,-31
	
	la	a0,pr1
	li	a7,4
	ecall
	
	mv	a0,sp
	li 	a1,31
	li	a7,8
	ecall
	
	mv	a0,sp
	addi	sp,sp,31	#ripristino lo stack
	jal	findLettere
	
	li	a7,10
	ecall

#riceve in a0 l'indirizzo della stringa
#non ritorna nulla ma stampa direttamente
findLettere:
	addi	sp,sp,-4
	sw	ra,0(sp)

	mv	t0,a0		#salvo a0
	mv	a2,a0		#salvo anche l'indirizzo
	
	li	a0,0		#pulisco
	li	t2,'a'
	li	s0,'z'		#ultimo elemento
findLoop:
	bgt	t2,s0,restore	#ritorno quando arrivo alla z
	
	mv	a1,t2		#devo cercare t1
	jal	findLettera	#ritorna in a1 0 o 1
	addi	t2,t2,1
	
	
	addi	a0,t2,-1
	beqz	a1,notFound	#stampo a1	ovvero t1
	j	findLoop

restore:
	lw	ra,0(sp)
	addi	sp,sp,4
	jr	ra

#prende in a0 la lettera e la stampa
notFound:
	li	a7,11
	ecall
	li	a0,' '
	li	a7,11
	ecall
	j	findLoop
	
	

	

#riceve in a2 l'indirizzo della stringa
#riceve in a1 la lettera
#ritorna in a1 1 se la lettera e' trovata 0 se non e' trovata
findLettera:
	mv	t3,a2		#salvo a0
	mv	t5,a1		#sposto a1 in t5
letteraLoop:
	lbu	t4,0(t3)	#carico il carattere
	beqz	t4,return	#torno
	addi	t3,t3,1		#incr pointer
	
	li	a1,1
	beq	t4,t5,return	#ritorno 1
	
	li	a1,0		#ritorno 0
	j	letteraLoop	#itero
return:
	jr	ra



