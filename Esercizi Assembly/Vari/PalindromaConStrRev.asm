#Controllare se la stringa inserita è palindroma
.data
request: .asciz "Inserisci una stringa da analizzare (Tieni a mente che lo spazio e l'andata a capo interrompono l'inserimento):\n"
result1: .asciz "\nLa stringa inserita è palindroma."
result0: .asciz "\nLa stringa inserita NON è palindroma."
str: .space 60
rev: .space 60

.globl main

.text
main:
	la a0, request
	li a7, 4
	ecall
	
	jal string
	jal reverse
	jal compute
	jal printPositive
	j exit
	
exitCycle:
	jr ra
	
string:
	la a1, str
	
stringLoop:
	add t0, a1, a3
	
	li a7, 12
	ecall
	
	sb a0, 0(t0)
	
	li t1, '\n'
	beq a0, t1, exitCycle
	li t1, ' '
	beq a0, t1, exitCycle
	
	addi a3, a3, 1
	j stringLoop

reverse:
	la a2, rev
	mv a6, a3
	addi a3, a3, -1
	li t3, 0
	
revLoop:
	add t0, a1, a3
	lb t1, 0(t0)
	
	add t2, a2, t3
	sb t1, 0(t2)
	
	addi a3, a3, -1
	addi t3, t3, 1
	
	li t4, -1
	beq a3, t4, exitCycle
	j revLoop

compute:
	li t0, 0
	li t1, 0

computeLoop:
	add t2, a1, t0
	lb a3, 0(t2)
	
	add t3, a2, t1
	lb a4, 0(t3)
	
	beq t0, a6, exitCycle
	bne a3, a4, printNegative
	
	addi t0, t0, 1
	addi t1, t1, 1
	
	j computeLoop
	
printNegative:
	la a0, result0
	li a7, 4
	ecall
	
	j exit
	
printPositive:
	la a0, result1
	li a7, 4
	ecall
	
	jr ra
	
exit:
	li a7, 10
	ecall
	