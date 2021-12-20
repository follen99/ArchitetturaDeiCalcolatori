#Fattoriale
.data
request: .asciz "Inserisci un numero da analizzare: "
result: .asciz "\nIl fattoriale del numero iserito è: "
arr: .space 30

.globl main

.text

main:
	la a5, arr
	
	la a0, request
	li  a7, 4
	ecall
	
	li a7, 5
	ecall
	
	mv a2, a0 					#A2: valore da decrementare di uno per il fattoriale
	mv a3, a0					#A3: valore da moltiplicare per A2
	mv a4, a0
	
	addi a4, a4, -1				#A4: indice condizione d'arresto per il ciclo (decrementato di uno altrimenti il risultato sarebbe 0)
	
	jal computeFact
	
	la a0, result
	li a7, 4
	ecall
	jal print
	
	j exit
	
exitCycle:
	jr ra	
	
computeFact:	
	addi t0, t0, 1
	
	addi a2, a2, -1
	mul a3, a3, a2	
	
	beq t0, a4, exitCycle
	j computeFact
	
print:
	mv a0, a3
	li a7, 1
	ecall
	jr ra

exit:
	li a7, 10
	ecall
