#Nome:		Giuliano
#Cognome:	Ranauro
#Matricola: 	
.globl main
.data
pr1:	.asciz	"Inserisci l'intero: "
pr2:	.asciz	"I numeri pari sono: "
.text
main:
	la	a0,pr1		#stampo il primo prompt
	li	a7,4
	ecall

	jal	readInt		#leggo l'intero	e non ripristino lo sp, cosi mi trovo all'indirizzo dell'intero
	
	la	a0,pr2		#stampo l'ultimo prompt
	li	a7,4
	ecall
	
	mv	a1,sp		#passo come parametro alla funzione findPari l'indirizzo che punta al numero inserito
	lw	a1,0(a1)	#carico effettivamente il numero
	addi	sp,sp,100	#ripristino lo stack pointer
	jal	findPari	#cerco i numeri pari e torno qui per uscire
	
	li	a7,10		#esco
	ecall

#prende in a1 l'intero
#in t6 salvo 10 che rimane tale per tutto il tempo
findPari:
	addi	sp,sp,-4	#spiazzo lo stack
	sw	ra,0(sp)	#salvo il return address che mi farà finire il programma
	
	li	t6,10
findLoop:
	rem	a2,a1,t6
	####vedo se e pari
	jal	isPari		#stampa se il numero e' pari
	
	div	a1,a1,t6	
	beqz	a1,restore
	j	findLoop

restore:	
	lw	ra,0(sp)
	addi	sp,sp,4
	jr	ra

#prende in a2 il numero da controllare
isPari:
	li	t1,2		#carico 2 per fare la divisione
	rem	t0,a2,t1	#se resto zero stampo
	beqz	t0,printPari	#seno' torno
	
	jr	ra

#la funzione accetta in a2 l'intero da stampare,stampa anche uno spazio 
printPari:	
	mv	a0,a2		#sposto in a0
	li	a7,1		#stampo l'intero
	ecall
	
	li	a0,' '		#stampo uno spazio
	li	a7,11
	ecall
	
	jr	ra
	

readInt:
	addi	sp,sp,-100		#spiazzo lo stack pointer
	
	li	a7,5			#leggo l'intero in a0
	ecall
	
	sw	a0,0(sp)		#salvo l'intero nello stack pointer
	
	jr	ra			#ritorno al chiamante