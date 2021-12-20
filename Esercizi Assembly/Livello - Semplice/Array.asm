#prova array
.data
.align 2
arr:	.word	1,2,3,4,5,6,7,8,9,10
space:	.asciz	" "
.text
.globl	main
main:
	la	a1,arr
	la	a2,arr
	addi	a2,a2,40
printLoop:
	lw	a0,0(a1)
	li	a7,1
	ecall
	la	a0,space
	li	a7,4
	ecall
	
	addi	a1,a1,4
	bne	a1,a2,printLoop		#finche' l'ultimo elemento (che sto scorrendo) non è uguale all'ultimo elemento impostato
					#manualmente, continua ad incrementare
					#l'ultimo elemento è calcolato moltiplicando il num di elementi nell'arr * 4 
					#(byte, =32 ovvero una word)
	
