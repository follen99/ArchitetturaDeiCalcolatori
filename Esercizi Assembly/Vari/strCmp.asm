.globl main
.data
default:	.asciz	"prova"

in_str:		.space	31

#abcdefghi

#defg
.text
main:
	la	a0,in_str	#in in_str ho la stringa immessa
	li	a1,31		
	li	a7,8
	ecall
	
	la	a2,default	#in a2 la stringa di default
	la	a3,in_str	#in a3 l'altra stringa di default
	jal	strCmp
	
	li	a7,1
	ecall
	
	li	a7,10
	ecall
	
	

	

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
	
	
	#la	a3,in_str	#in a3 la stringa immessa
	
	mv	a1,a3
	jal	strLen		
	mv	s1,a0		#in s1 la lunghezza di s2
	addi	s1,s1,-1
	
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

restore:
	lw	ra,0(sp)
	addi	sp,sp,4
	
	jr	ra
	
