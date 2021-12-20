#stampa le consonanti doppie in una stringa
.globl main
.data

.text
main:
	addi	sp,sp,-4		#faccio spazio per l'ra
	jal	readString
	
	jal	printDoubles

	
	li	a7,10
	ecall


printDoubles:
	addi	sp,sp,-256		#vado alla stringa
	mv	s1,sp			#salvo il puntatore
	addi	sp,sp,256		#repristino
	
	#addi	sp,sp,-4
	sw	ra,0(sp)		#salvo il ra
	
	
	li	a1,'a'		#lower limit
	li	s0,'z'		#upper limit
printLoop:
	bgt	a1,s0,restore	#ho controllato fino alla zeta
	
	mv	a0,s1
	mv	a2,a1
	jal	findChar
	addi	a1,a1,1		#incr
	
	j	printLoop

restore:
	lw	ra,0(sp)
	addi	sp,sp,4
	jr	ra
#prende in a0 l'indirizzo della stringa
#prende in a2 il carattere da trovare
findChar:
	lbu	t0,0(a0)	#carico il carattere n
	beqz	t0,return	#ritorno se ho finito di scorrere la stringa
	
	addi	a0,a0,1
	
	bne	t0,a2,findChar
	lbu	t1,0(a0)	#carico il carattere successivo
	beq	t1,t0,charFound	#ho trovato il carattere
	j	findChar
return:
	jr	ra

charFound:
	mv	a0,a2
	li	a7,11
	ecall
	
	li	a0,' '
	li	a7,11
	ecall
	
	jr	ra		#return to callee
	
	
#non riceve nulla, salva sullo sp la stringa
#ripristina lo stack
readString:
	addi	sp,sp,-256
	mv	a0,sp
	li	a1,256
	li	a7,8
	ecall
	addi	sp,sp,256
	
	jr	ra
	
	
	