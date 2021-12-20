#Riordina i numeri inseriti in senso decrescente
.data
request1: .asciz "Quanti numeri vuoi inserire?(MAX 10): "
request2: .asciz "\nInserisci un numero: "
result: .asciz "\nI numeri ordinati sono:\n"
wrd: .word 40

.globl main

.text
main:
	la a3, wrd							#Carico in a3 la struttura dati
	li t0, 4							#Associo a t0 il valore 4 che mi servirà per specificare in a2 il numero di iterazioni da effettuare
	
	la a0, request1						#Associo in a0 la stringa request1 che viene poi stampata a schermo mediante syscall
	li a7, 4
	ecall
	
	li a7, 5							#Prendo in input da tastiera il numero di iterazioni
	ecall
	
	mv a2, a0							#Sposto l'input in a2
	
	mul a2, a2, t0						#Moltiplico a2 per t0 in quanto il cursore dell'array si muoverà di 4 in 4 siccome contiene word
	
	jal insertNum						#Richiamo la funzione di inserimento 
	li t2, 0							#Pulisco il registro t2(cursore dell'array) che mi servirà dopo
	
	jal compute							#Richiamo la funzione di effettiva computazione, che effettuerà controlli su chi sia il maggiore e aggiornerà l'array
	li t2, 0
	
	la a0, result							#Associo ad a0 la stringa result che viene poi stampata a schermo mediante syscall
	li a7, 4
	ecall
	
	jal print							#Richiamo la funzione di stampa
	j exit								#Uscita del programma con conseguente terminazione
	
exitCycle:								#Funzione che consente di ritornare alla riga immediatamente successiva all'invocazione di una funzione
	jr ra								#Invocata prevalentemente come label della condizione di arresto dei cicli
	
insertNum:
	add t1, a3, t2						#Salvo in t1 l' array a3 con offset t2
	
	la a0, request2						#Associo ad a0 la stringa request2 che viene poi stampata ciclicamente a schermo mediante syscall
	li a7, 4
	ecall
	
	li a7, 5							#Prendo in input da tastiera il numero da inserire nell'array all'offset indicato
	ecall
	
	mv t3, a0							#Sposto in t3 il numero
	sw t3, 0(t1)							#Inserisco il numero nella posizione t2
	
	addi t2, t2, 4						#Incremento t2 per la prossima iterazione di 4 poichè è un array di word
	beq t2, a2, exitCycle					#Condizione di arresto: Se il numero di iterazioni è uguale all'offset t2 allora richiamo la funzione exitCycle
	
	j insertNum
	
compute:
	add t1, a3, t2						#Salvo in t1 l' array a3 con offset t2; (Serve a prelevare il numero campione da confrontare con gli altri)
	lw t3, 0(t1)							#Carico in t3 il numero contenuto nell'array all'offset t2
	
	add t4, a3, t5						#Salvo in t4 l' array a3 con offset t5; (Serve a scorrere l'array per consentire il confronto con il numero precedentemente prelevato)
	lw t6, 0(t4)							#Carico in t6 il numero contenuto nell'array all'offset t5
	
	beq t2, a2 exitCycle					#Condizione di arresto sulle iterazioni
	
	bgt t6, t3, refresh						#Se il numero da confrontare è maggiore del numero campione invoco la funzione refresh
	addi t5, t5, 4						#Incremento l'offset del ciclo di controllo
	bge t5, a2, next						#Se l'offset del ciclo di controllo è maggiore delle iterazioni massime invoco la funzione next
	
	j compute

refresh: 								#Funzione che effettua un swap per l'aggiornamento delle posizioni 
	sw t6, 0(t1)
	add t0, a3, t5
	sw t3, 0(t0)

	j compute

next:									#Funzione che incrementa gli offset una volta che il numero campione è stato confrontato con tutti
	addi t2, t2, 4						#L'offset dei numeri campione viene incrementato di una posizione
	addi t5, t2, 4						#L'offset dell'array di controllo viene incrementato di una posizione in più rispetto all'array dei numeri campione
	j compute

print:									#Funzione di stampa
	add t1, a3, t2						#Salvo in t1 l' array a3 con offset t2
	lw t3, 0(t1)							#Carico in t3 il numero contenuto nell'array all'offset t2
	
	li t0, ' '							#Carico il carattere "spazio" in t0

	mv a0, t3							#Stampo il numero caricato in t3
	li a7, 1
	ecall
	
	mv a0, t0							#Stampo il carattere spazio
	li a7, 11
	ecall
	
	addi t2, t2, 4						#Incremento l'offset dell'array
	beq t2, a2, exitCycle					#Condizione di arresto: se l'offset è uguale al numero massimo di iterazioni invoco la funzione exitCycle
	j print

exit:
	li a7, 10							#Termino il programma mediante syscall
	ecall
