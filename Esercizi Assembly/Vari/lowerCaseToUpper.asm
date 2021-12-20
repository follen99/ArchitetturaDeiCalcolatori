#descrizione:	il programma converte una stringa di lowercase in uppercase
.data
insert:	.asciz 	"Inserisci il tuo nome: "
out:	.asciz	"Il tuo nome in UpperCase e': "
in_name:	.space 31 
a:	.word	97
z:	.word	122
.text
.globl main
main:	la	a0,insert
	li	a7,4
	ecall
	#leggo il nome
	li	a1,31	#al massimo 30 char + null char
	li	a7,8
	ecall
	
	la	a0,out
	li	a7,4
	ecall
	
loop:	lbu	sp,0(sp)
	beqz	a0,exit
	
	la	t2,a
	blt	t1,t2,no_change	#se la lettera precede la 'a' allora non effettuo cambiamenti
	la	t2,z
	bgt	t1,t2,no_change	#se la lettera succede la 'z' allora non effettuo cambiamenti
	
	addi	t1,t1,-32	#converto in uppercase
	sb	sp,0(sp)
no_change:	addi	t0,t0,1	#increment pointer
		j	loop
exit:	la	a0,out
	li	a7,4
	ecall
	li	a7,10
	ecall
	
	
	li	a7,10
	ecall
	