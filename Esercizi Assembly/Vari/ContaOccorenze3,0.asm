#Conta le occorrenze in una strings
.data
request: .asciz "Inserisci la stringa da analizzare: "
result: .asciz "Il numero di occorrenze trovate è: "
str: .space 40

.globl main

.text
main:
	la a0, request 
	li a7, 4
	ecall
	
 	jal insert
 	
 	jal compute
 	
 	jal print
 	
 	j exit
 	
 exitCycle:
 	jr ra
 	
 insert:
 	la a1, str
 	li t0, 0
 	li a3, '\n'
 	
 insertLoop:
 	add a2, a1, t0
 	
 	li a7, 12
 	ecall
 	
 	sb a0, 0(a2)
 	
 	addi t0, t0, 1
 	beq a0, a3, exitCycle
 	j insertLoop
 
 compute:
 	li a3, 0
 	
 computeLoop:
 	add a2, a1, a3
 	lb a4, 0(a2)
 	lb a5, 1(a2)
 	
 	beq a4, a5, counter
 	
 	addi a3, a3, 1
 	beqz a5, exitCycle
 	j computeLoop
 
 counter:
 	addi a6, a6, 1
 	addi a3, a3, 1
 	j computeLoop
 	
 print:
 	la a0, result
 	li a7, 4
 	ecall
 	
 	mv a0, a6
 	li a7, 1
 	ecall
 	
 	jr ra
 	
 exit:
 	li a7, 10
 	ecall
 	