.globl main
.data
pr1:	.asciz	"Inserisci la stringa: Max 256Ch"

#testString:	.asciz	"ciao come va"
.text
main:
	jal	readString
	addi	sp,sp,-256
	mv	a0,sp
	addi	sp,sp,256

	#la	a0,testString
	jal 	findVowels
	
	li	a7,10
	ecall

#riceve in a0 l'indirizzo della stringa
findVowels:
	mv	s0,a0		#salvo l'indirizzo
	addi	sp,sp,-4	#spazio per ra
	sw	ra,0(sp)	#salvo ra
	
	li	a0,'a'
	mv	a1,s0
	jal 	checkLetter
	
	li	a0,'e'
	mv	a1,s0
	jal 	checkLetter
	
	li	a0,'i'
	mv	a1,s0
	jal 	checkLetter
	
	li	a0,'o'
	mv	a1,s0
	jal 	checkLetter
	
	li	a0,'u'
	mv	a1,s0
	jal 	checkLetter
	
	
	lw	ra,0(sp)
	addi	sp,sp,4
	jr	ra
	

#riceve in a0 la lettera da trovare
#riceve in a1 l'indirizzo della stringa
#se la trova la stampa
checkLetter:
	lbu	t0,0(a1)	#carico l'elemento
	beqz	t0,return	#esco se arrivo alla fine
	
	beq	t0,a0,printLetter	#stampo la lettera
	addi	a1,a1,1		#incremeneto
	j	checkLetter

#prende in a0 la lettera da stampare
printLetter:
	li	a7,11		#stampo il carattere
	ecall
	li	a0,' '
	ecall
	
	li	a0,0		#pulisco
	li	a1,0
return:
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