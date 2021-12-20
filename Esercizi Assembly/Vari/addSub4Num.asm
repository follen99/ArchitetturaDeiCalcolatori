#Descrizione: il programma effettua: (a+b)-(c+d)
.data
ins_a:	.asciz "Inserisci A: "
ins_b:	.asciz "Inserisci B: "
ins_c:	.asciz "Inserisci C: "
ins_d:	.asciz "Inserisci D: "

result:	.asciz "Il Risultato e': "
.text
.globl main

main:	jal	ra,read
	jal	ra,print
	jal	ra,calc
	jal	ra,p_res
	
	li	a7,10
	ecall

print:	la	a0,result
	li	a7,4
	ecall
	jr	ra

p_res:	li	a7,1
	ecall
	jr	ra

calc:	add	a0,a1,a2 #Calcolo a0=(a+b)
	add	t0,a3,a4 #calcolo t0=(c-d)	
	sub	a0,a0,t0 #calcolo a0=(a+b)-(c+d)
	jr	ra	 #ritorno

read:	la	a0,ins_a
	li	a7,4
	ecall
	li	a7,5
	ecall
	mv	a1,a0
	
	la	a0,ins_b
	li	a7,4
	ecall
	li	a7,5
	ecall
	mv	a2,a0
	
	la	a0,ins_c
	li	a7,4
	ecall
	li	a7,5
	ecall
	mv	a3,a0
	
	la	a0,ins_d
	li	a7,4
	ecall
	li	a7,5
	ecall
	mv	a4,a0
	
	jr	ra