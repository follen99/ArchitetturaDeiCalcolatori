#conversione esadecimale decimale
.data
numconv:	.word	0:30
num:		.space	11
in:		.asciz	"Inserisci un numero esadecimale: "
out:		.asciz	"Il numero in decimale risulta: "
.text
	la a0, in
	li a7, 4
	ecall
	
	la a0, num
	li a1, 11
	li a7, 8
	ecall
load:
	la s0, num	
body:	
	jal len
	addi s9, s9, -1
	
	la a4, num
	la a5, numconv
	mv a6, s9
	
	jal convert
	
	la s2, numconv
	li s8, 0
	mv a3, s9		#sposto la len in a3
	
	jal compute
	
	j print
	
compute:
	beqz a3, return
	lw t2,0(s2)
	
	li a2, 16		#base per il label power
	mv a4, a3		#esponente per la potenza in base alla lunghezza del numero inserito
	addi a4, a4, -1		#counter dell'esponente, -1 perchè tieni conto della pot ^0 che fa 1

	addi sp,sp,-4
	sw ra,0(sp)
	
	jal power

	lw ra,0(sp)
	addi sp,sp,4
	
	addi a3, a3, -1		#esponente che in questo ciclo usi come contatore per uscire, inoltre ti da le posizioni per le potenze
	
	mul t1, a0, t2		
	
	add s8, s8, t1
	
	addi s2, s2, 4

	j compute
					
power:
	li t0, 0
	li a0, 1		#registro di ritorno dell'elevazione a potenza
loopp:
	beq t0, a4, return
	mul a0, a2, a0
	addi t0, t0, 1
	j loopp
return:
	jr ra
	
len:
	lbu t0,0(s0)
	
	beqz t0, return
	
	addi s9, s9, 1
	addi s0, s0, 1
	j len
convert:
	beqz a6, return
	addi a6, a6, -1
	
	lbu t0,0(a4)
	addi a4, a4, 1
	
	li t1, 48
	li t6, 57
	
	li t2, 'A'
	beq t0, t2, convertA
	li t2, 'B'
	beq t0, t2, convertB
	li t2, 'C'
	beq t0, t2, convertC
	li t2, 'D'
	beq t0, t2, convertD
	li t2, 'E'
	beq t0, t2, convertE
	li t2, 'F'
	beq t0, t2, convertF
 
	
	blt t0, t1, convert
	bgt t0, t6, convert
	
	addi t0, t0, -48

	sw t0,0(a5)
		
	addi a5, a5, 4	
	j convert
	
convertA:
	li t0, 10
	sw t0,0(a5)
	addi a5, a5, 4
	j convert
convertB:
	li t0, 11
	sw t0,0(a5)
	addi a5, a5, 4
	j convert
convertC:
	li t0, 12
	sw t0,0(a5)
	addi a5, a5, 4
	j convert	
convertD:
	li t0, 13
	sw t0,0(a5)
	addi a5, a5, 4
	j convert
convertE:
	li t0, 14
	sw t0,0(a5)
	addi a5, a5, 4
	j convert
convertF:
	li t0, 15
	sw t0,0(a5)
	addi a5, a5, 4
	j convert
print:
	la a0, out
	li a7, 4
	ecall
	
	mv a0, s8
	
	li a7, 1
	ecall
exit:
	li a7, 10
	ecall