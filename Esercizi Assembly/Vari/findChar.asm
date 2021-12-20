#il programma permette di cercare un carattere all'interno della stringa.
.globl main
.data
pr1:	.asciz	"Inserisci una stringa (max 31char): "
trovato:	.asciz	"Carattere trovato."
nonTrovato:	.asciz	"Carattere non trovato."

in_str:	.space	31
.text
main:
	la	a0,pr1	#stampo
	li	a7,4
	ecall
	
	la	a0,in_str	#leggo la stringa
	li	a1,31
	li	a7,8
	ecall
	
	la	a0,in_str
	li	a1,'i'
	jal	findChar
	
	mv	a0,a1
	li	a7,1
	ecall
	
	li	a7,10
	ecall

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

	