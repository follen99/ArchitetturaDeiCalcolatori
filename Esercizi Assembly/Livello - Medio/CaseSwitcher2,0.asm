#Case switcher
.data
intro: .asciz "Questo programma converte le stringhe in Maiuscolo o in minuscolo."
request1: .asciz "\nInserisci una stringa: "
request2: .asciz "\nInserire [0] per convertire in maiuscolo o [1] per convertire in minuscolo: "
result: .asciz "\nLa nuova stringa è: "
str: .space 60

.globl main
.text

start:
	li s0, '\n'
	
	la a0, intro
	li a7, 4
	ecall

main:
	la a0, request1
	li a7, 4
	ecall
	
	jal insert
	
	la a0, request2
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	mv a1, a0
	
	jal request
	
	jal clc
	
	la a0, result
	li a7, 4 
	ecall
	
	jal print
	
	j exit
	
insert:
	la a2, str
	
	add t1, a2, s2
	
	li a7, 12
	ecall
	
	sb a0, 0(t1)
	
	addi s2, s2, 1
	beq a0, s0, exitCycle
	j insert
	
request:
	beq a1, zero, lowerToUpper
	bne a1, zero, upperToLower

lowerToUpper:
	add a6, a2, t2
	lb a4, 0(a6)
	addi t2, t2, 1
	
	beq t2, s2, exitCycle
	
	li t4, 97
	li t5, 122
	
	blt a4, t4, lowerToUpper
	bgt a4, t5, lowerToUpper
	
	addi t3, a4, -32
	sb t3, 0(a6)
		
	j lowerToUpper
	
upperToLower:
	add a6, a2, t2
	lb a4, 0(a6)
	addi t2, t2, 1
		
	beq t2, s2, exitCycle
	
	li t4, 65
	li t5, 90
	
	blt a4, t4, upperToLower
	bgt a4, t5, upperToLower
	
	addi t3, a4, 32
	sb t3, 0(a6)

	j upperToLower
	
exitCycle:
	jr ra
	
clc:
	li t1, 0
	li t2, 0
	li t3, 0
	li t4, 0
	li t5, 0
	li t6, 0
	li a1, 0
	li a3, 0
	li a4, 0
	li a5, 0
	li a6, 0
	
	jr ra	
	
print:
	add a3, a2, t1
	lb a4, 0(a3)
	
	mv a0, a4
	li a7, 11
	ecall
	
	beq t1, s2, exitCycle
	addi t1, t1, 1
	
	j print	
exit:
	li a7, 10
	ecall