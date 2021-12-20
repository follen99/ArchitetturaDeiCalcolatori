.globl main
.data
pr1:	.asciz	"Inserisci una stringa (max 30 caratteri): "


.text
main:
	addi	sp,sp,-31	#spazio per una stringa di 30 caratteri
		
	la	a0,pr1
	li	a7,4
	ecall
	
	mv	a0,sp		#leggo la stringa nello stack
	li	a7,8
	li	a1,31
	ecall
	
	mv	a0,sp		#sposto la stringa in argomento0
	jal	contaVocali
	
	mv	a0,a1
	li	a7,1
	ecall
	
	addi	sp,sp,31	#ripristino lo stack
	
	li	a7,10
	ecall

#la funzione riceve in a0 l'indirizzo della stringa
#ritorna in a1 il conteggio delle vocali
contaVocali:
	mv	t0,a0	#sposto l'indirizzo in t0 per non sporcarlo
	li	a1,0	#azzero il contatore
	
contaLoop:
	lbu	t1,0(t0)	#carico il carattere n
	addi	t0,t0,1		#incremento
	beqz	t1,return	#esco
	
	li	t2,'a'
	beq	t1,t2,found
	addi	t2,t2,-32
	beq	t1,t2,found
	
	li	t2,'e'
	beq	t1,t2,found
	addi	t2,t2,-32
	beq	t1,t2,found
	
	li	t2,'i'
	beq	t1,t2,found
	addi	t2,t2,-32
	beq	t1,t2,found
	
	li	t2,'o'
	beq	t1,t2,found
	addi	t2,t2,-32
	beq	t1,t2,found
	
	li	t2,'u'
	beq	t1,t2,found
	addi	t2,t2,-32
	beq	t1,t2,found
	
	j	contaLoop
found:
	addi	a1,a1,1
	j	contaLoop

return:
	jr	ra
	
	
	
	
	
