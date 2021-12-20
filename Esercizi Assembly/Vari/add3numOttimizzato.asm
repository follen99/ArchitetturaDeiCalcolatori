#Descrizione: il programma effettua: (a+b)-(c+d), utilizzando delle funzioni ottimizzate
.data
ins_a:	.asciz "Inserisci A: "
ins_b:	.asciz "Inserisci B: "
ins_c:	.asciz "Inserisci C: "
ins_d:	.asciz "Inserisci D: "
descr:	.asciz "il programma effettua: (a+b)-(c+d)"

result:	.asciz "Il Risultato e': "
.text
.globl main

main:	la	a0,descr
	jal	ra,p_str	#stampo descrizione
	
	la	a0,ins_a
	jal	ra,p_str	#stampo "ins a"
	jal 	ra,r_int
	mv	a1,a0
	
	la	a0,ins_b	
	jal	ra,p_str	#stampo "ins b"
	jal 	ra,r_int
	mv	a2,a0
		
	la	a0,ins_c
	jal	ra,p_str	#stampo "ins c"
	jal 	ra,r_int
	mv	a3,a0
	
	la	a0,ins_d
	jal	ra,p_str	#stampo "ins d"
	jal 	ra,r_int
	mv	a4,a0
	
	la	a0,result
	jal	ra,p_str
	jal	ra,calc
	jal	ra,p_int
	

	li	a7,10
	ecall		#esco

calc:	add	a0,a1,a2 #Calcolo a0=(a+b)
	add	t0,a3,a4 #calcolo t0=(c-d)	
	sub	a0,a0,t0 #calcolo a0=(a+b)-(c+d)
	jr	ra	 #ritorno
	
r_int:	li	a7,5
	ecall
	jr	ra

p_str:	li	a7,4	#Put in a0 a string
	ecall
	jr ra
p_int:	li	a7,1	#put in a0 an int
	ecall
	jr ra