#il programma mostra le consonanti doppie
.data
in_prompt:	.asciz	"Inserisci la parola: "
out_prompt:	.asciz	"Le consonanti doppie sono: "
prompt_space:	.asciz	" "

.text
.globl	main
main:	
	la	a0,in_prompt
	li	a7,4
	ecall
	
	addi	sp,sp,-256
	mv 	a0,sp
	li	a1,256
	li	a7,8
	ecall
	
	la	a0,out_prompt
	li	a7,4
	ecall

loop:	lbu	a0,0(sp)
	beqz	a0,exit		#esco se nulla
	mv	s0,a0		#salvo in s0
	jal 	check

	addi 	sp,sp,1
	beqz	a0,loop		#se in a0 c'è zero passo al carattere successio
	
	lbu	a1,(sp)
	beqz	a1,exit		#se il carattere succ è il terminatore esco
	mv	a0,s0		#sposto s0 in a0
	
	jal	equal		#funzione che verifica se i due caratteri sono uguali
	
	beqz	a0,loop		
	
	mv	a0,s0		#sposto il ch in a0 e stampo
	li	a7,11
	ecall
	
	la	a0,prompt_space
	li	a7,4
	ecall
	
	j	loop

exit:	li	a7,10
	ecall
	
	

check:	
	li t0,'B'	#decimale ascii corrispondente a 'B'
	li t1,'E'	#decimale ascii corrispondente a 'E'
	li t2,'I'	#decimale ascii corrispondente a 'I'
	li t3,'O'	#decimale ascii corrispondente a 'O'
	li t4,'U'	#decimale ascii corrispondente a 'U'
	li t5,'a'	#decimale ascii corrispondente a 'a'
	li t6,'z'	#decimale ascii corrispondente a 'z'
	
	bgt	a0,t6,case0
	blt	a0,t5,next	#deve diventare minuscolo
	addi	a0,a0,-32	#converto
	
next:	blt	a0,t0,case0
	beq	a0,t1,case0
	beq	a0,t2,case0
	beq	a0,t3,case0
	beq	a0,t4,case0	#se uguale ad una vocale non lo considero

case1:	li	a0,1
	jr	ra
case0:	li	a0,0
	jr	ra

equal:	beq	a0,a1,yes	#se sono uguali ritorno 1 altrimenti 0
	li	a0,0
	jr	ra
yes:	li	a0,1
	jr	ra





	