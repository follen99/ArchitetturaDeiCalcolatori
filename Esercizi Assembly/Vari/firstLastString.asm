.globl main
.data
.text
main:
	addi	sp,sp,-100	#alloco spazio per 4 stringhe da 24 piu terminatore
	
	mv	a0,sp
	li	a7,8
	li	a1,25
	ecall
	
	addi	sp,sp,25	
	
	mv	a0,sp		#leggo seconda scritta
	li	a7,8
	li	a1,25
	ecall
	
	addi	sp,sp,25	
	
	mv	a0,sp		#leggo terza stringa
	li	a7,8
	li	a1,25
	ecall
	
	addi	sp,sp,25	#ora lo stack e' a -25
	
	mv	a0,sp		#leggo quarta stringa
	li	a7,8
	li	a1,25
	ecall
	
	addi	sp,sp,-75	#torno a 0
	
	mv	a0,sp		#sposto la prima stringa in a0
	addi	sp,sp,25
	mv	a1,sp		#sposto la seconda stringa
	
	addi	sp,sp,-25	#torno a 0 perchè seno' l'ra fa storie
	
	jal	strCmp
	
	li	a7,1
	ecall
	
	
	li	a7,10
	ecall

#riceve in a0 il puntatore alle stringhe (sp)	
#non ritorna nulla ma stampa
first_string:
	


#la funzione riceve in a0 la prima stringa e in a1 la seconda
#ritorna in a0 0 se sono uguali, <0 se la prima precede la seconda > se la seconda precede la prima 
#ATTENZIONE! la funzione sporca a0 
strCmp:
	addi	sp,sp,-4
	sw	ra,0(sp)	#salvo l'ra
	
	jal	getCode		#ritorna in a0 il codice di str1
	mv	t2,a0		#salvo 
	
	mv	a0,a1		
	jal	getCode
	
	
	sub	a0,t2,a0	#effettuo la sottrazione
	
	lw	ra,0(sp)
	addi	sp,sp,4
	
	jr	ra

#riceve in a0 una stringa
#ritorna in a0 la somma dei valori ascii di ogni carattere
getCode:
	mv	t0,a0	#salvo a0
	li	a0,0
getLoop:
	lbu	t1,0(t0)
	beqz	t1,return	#ho finito
	addi	t0,t0,1		#incremento il puntatore
	
	add	a0,a0,t1	#incremento la somma
	j	getLoop
return:
	jr	ra
	
	