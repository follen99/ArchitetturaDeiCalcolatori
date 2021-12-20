#Ordinamento decrescente
.data
request1: .asciz "Quanti numeri vuoi inserire? (MAX 10): "
request2: .asciz "\nInserisci un numero: "
result: .asciz "I numeri ordinati in modo decrescente sono:\n"
wrd: .word 40

.globl main

.text
main:
	la a2, wrd								#Carico in a2 la struttura dati
	li a3, 4								#Associo a a3 il valore 4 che mi servirà per specificare in a2 il numero di iterazioni da effettuare
	
	la a0, request1							#Associo in a0 la stringa request1 che viene poi stampata a schermo mediante syscall
	li a7, 4
	ecall
	
	li a7, 5								#Prendo in input da tastiera il numero di iterazioni
	ecall
	
	mul a3, a0, a3							#Moltiplico l'input per a3 in quanto il cursore dell'array si muoverà di 4 in 4 siccome contiene word
	
	jal insertNum							#Richiamo la funzione di inserimento
	
	li a0, 0
	
	jal compute								#Richiamo la funzione di effettiva computazione, che effettuerà controlli su chi sia il maggiore e aggiornerà l'array
	
	la a0, result								#Associo ad a0 la stringa result che viene poi stampata a schermo mediante syscall
	li a7, 4
	ecall
	
	jal print								#Richiamo la funzione di stampa
	
	j exit									#Uscita del programma con conseguente terminazione
	
exitCycle:									#Funzione che consente di ritornare alla riga immediatamente successiva all'invocazione di una funzione
	jr ra									#Invocata prevalentemente come label della condizione di arresto dei cicli
	
insertNum:									#Funzione di insermento
	add a1, a2, t0							#Associo in a1 l'array a2 con offset t0
	
	la a0, request2							#Stampo a schermo request2
	li a7, 4
	ecall
	
	li a7, 5								#Prendo in input il numero da inserire
	ecall
	
	sw a0, 0(a1)							#Salvo il numero alla posizione indicata dall'offset
	
	addi t0, t0, 4							#Incremento l'offset di una posizione
	beq t0, a3, exitCycle						#Condizione di arresto
	j insertNum

compute:									#Pseudo-Bubble sort
	add a1, a2, a0
	lw a4, 0(a1)		
										#Inizializzo due array uno con numero campione e l'altro di controllo
	add t0, a2, a5	
	lw a6, 0(t0)	
	
	beq a0, a3 exitCycle						#Condizione di arresto
	
	sub t1, a4, a6							#Salvo in un registro temporaneo la sottrazione tra il campione e il numero di controllo
	bgtz t1, swap							#Controllo che il risultato sia maggiore di zero e invoco la funzione swap
	
	addi a5, a5, 4							#Incremento l'offset del controllo
	bge a5, a3, refreshC					 
	
	j compute
	
swap:									#Funzione che di avvale di un buffer per invertire le posizioni dei numeri
	sw a6, 0(a1)
	add t0, a2, a5
	sw a4, 0(t0)

	addi a5, a5, 4							#Incremento l'offset dei numeri di controllo
	j compute
	
refreshC:
	addi a0, a0, 4							#incremento l'offset del campione
	li a5, 0								#Ripristino l'offset dei numeri di controllo per ricominciare i confronti
	j compute
	
print:										#Funzione di stampa
	add a1, a2, t2
	lw a0, 0(a1)
	
	li a7, 1
	ecall
	
	li t0, ' '								#Stampa del carattere spazio
	mv a0, t0
	li a7, 11
	ecall
	
	addi t2, t2, 4
	beq t2, a3 exitCycle
	j print

exit:										#Uscita
	li a7, 10
	ecall