.globl main
.data
presente:	.asciz	"La parola e' presente nella frase"
nonPresente:	.asciz	"La parola non e' presente nella frase"
default:	.asciz	"oggi e una bella"

in_str:		.space	31

subStringSpace:	.space	31
#abcdefghi

#defg
.text
main:
	la	a0,in_str	#in in_str ho la stringa immessa
	li	a1,31		
	li	a7,8
	ecall
	
	#######################SEZIONE DELLA STRCMP####################################
	
	#la	a2,default	#in a2 la stringa di default
	#la	a3,in_str	#in a3 l'altra stringa di default
	#jal	strCmp
	
	
	#######################SEZIONE DELLA SUBSTRING####################################
	
	#la	a0,subStringSpace	#carico l'array da pulire
	#li	a1,31		#pulisco 31 caratteri
	#jal	clearArray	#pulisco l'array
	
	
	#la	a0,default
	#li	a1,5		#sottostringa di 5 caratteri
	#jal	subString	#effettuo la sottostringa
	
	#la	a0,subStringSpace
	#li	a7,4
	#ecall
	
	jal findWord

finish:
	la	a0,nonPresente
	li	a7,4
	ecall
exit:
	li	a7,10
	ecall

#riceve in a0 la stringa da spezzettare
findWord:
	addi	sp,sp,-4
	lw	ra,0(sp)	#salvo il return address

	
	
	li	a5,10			#TEMPORANEO
	
	la	a0,default		#metto in a0 la stringa da "spezzettare"
findLoop:
	beqz	a5,finish
	addi	a5,a5,-1
	
	mv	s7,a0			#salvo a0
	
	la	a1,in_str		#carico in a1 la stringa immessa
	jal	strLen			#restituisce in a0 la lunghezza
	mv	a1,a0			#metto in a1 la lunghezza
	addi	a1,a1,-1
	
	mv	a0,s7			#riprendo a0 per la funzione subString
	jal	subString		#effettuo la substring
	
	
	
	mv	s7,a0
	
	
	######################################DEBUG#####################################
	#la	a0,subStringSpace	#stampo
	#li	a7,4
	#ecall	
	
	#li	a0,'\n'
	#li	a7,11
	#ecall
	######################################DEBUG#####################################
	
	la	a2,in_str
	la	a3,subStringSpace
	jal	strCmp			#ritorna in a0 1 se uguale
	
	mv	s6,a0			#salvo 1 o 0 in s6
	
	
	la	a0,subStringSpace
	li	a1,31
	jal 	clearArray		#pulisco l'array
	
	#mv	a0,s7			#risposto in a0
	#addi	a0,a0,1			#incremento il puntatore
	#li	s7,0			#pulisco t0
	
	bnez	s6,wordFound		#se s6 non e' zero ho trovato una corrispondenza
	
	j	findLoop
	
restore:
	lw	ra,0(sp)
	addi	sp,sp,4
	jr	ra

#gli passo a0+1 che contiene l'indirizzo al carattere successivo a quello che deve essere eliminato
wordFound:
	mv	s7,a0		#salvo a0

	
	la	a1,in_str		#carico in a1 la stringa immessa
	jal	strLen			#restituisce in a0 la lunghezza
	mv	a1,a0			#sposto in a1 il numero di caratteri da eliminare
	
	mv	a0,s7			#copio in a0 l'indirizzo da cui eliminare i caratteri
	addi	a0,a0,-1		#decremento di uno perche' si
	
	jal 	clearArray		#pulisco l'array
	
	mv	a0,s7			#restoro a0 con s7 e pulisco s7
	li	a7,0	
	
	la	a0,presente
	li	a7,4
	ecall
	
	#j	findLoop		#ritorno al loop
	j	exit

#riceve in a0 l'array da pulire
#riceve in a1 il numero di caratteri
#imposta a1 caratteri di a0 a 0
clearArray:
	beqz	a1,return
	addi	a1,a1,-1
	sb	zero,0(a0)
	
	addi	a0,a0,1
	j	clearArray

#la funzione riceve in a0 l'indirizzo della stringa
#riceve in a1 quanto deve essere lunga la sottostringa
#crea l'array contenente la nuova stringa
subString:
	la	t1,subStringSpace
	mv	t4,a0
subLoop:
	beqz	a1,return
	addi	a1,a1,-1

	lbu	t0,0(t4)
	sb	t0,0(t1)
	
	addi	t4,t4,1		#incremento
	addi	t1,t1,1
	
	j	subLoop
	
	

#riceve in a1 l'indirizzo della stringa da "contare"
#restituisce in a0 la lunghezza
strLen:	
	li	a0,0		#azzero il contatore
lenLoop:
	lbu	t0,0(a1)	#carico l'elemento n
	addi	a1,a1,1
	beqz	t0,return	#esco 
	
	addi	a0,a0,1		#incremento il contatore
	
	j	lenLoop
return:
	jr	ra
	

#ritorna in a0 0 o 1 
#0: le stringhe sono diverse
#1: le stringhe sono uguali

#riceve in a2 e a3 le stringhe da comparare
strCmp:
	addi	sp,sp,-4
	sw	ra,0(sp)
	
	
	#la	a2,default	#in a2 la stringa di default
	
	mv	a1,a2
	jal	strLen		#calcolo la lunghezza
	mv	s0,a0		#sposto la lunghezza della prima stringa in s0
	addi	s0,s0,-1
	
	#la	a3,in_str	#in a3 la stringa immessa
	
	mv	a1,a3
	jal	strLen		
	mv	s1,a0		#in s1 la lunghezza di s2
	
	li	a0,0		#restituisco zero
	bne	s1,s0,restore
	li	s1,0		#pulisco s1
	
strLoop:
	beqz	s0,restore
	addi	s0,s0,-1
	
	lbu	t0,0(a2)	#carico il primo char della prima str
	lbu	t1,0(a3)	#carico il primo char della seconda str
	
	li	a0,0
	bne	t0,t1,restore	#ritorno zero se non sono uguali
	
	addi	a2,a2,1
	addi	a3,a3,1
	
	li	a0,1		#ritorno 1 
	j	strLoop


	
