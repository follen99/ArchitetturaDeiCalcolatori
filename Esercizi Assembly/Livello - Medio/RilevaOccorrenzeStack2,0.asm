#Riconosci le occorrenze salvando una stringa su stack
.data
request: .asciz "Inserisci una stringa e primi invio per confermare: "
result: .asciz "\nLe occorrenze trovate sono: "
str: .space 40

.globl main

.text
addi sp, sp, -40
li s0, '\n'
la a2, str
	
main:
	la a0, request
	li a7, 4
	ecall
	
	jal insert
	
	jal clc
	
	jal compute
	
	jal clc
	
	la a0, result
	li a7, 4
	ecall
	
	jal print
	
	j exit
	
exitCycle:
	jr ra
	
insert:
	add t1, sp, t2
	
	li a7, 12
	ecall
	
	beq a0, s0, exitCycle
	sb a0, 0(t1)
	
	addi t2, t2, 1
	
	j insert

clc:
	li t1, 0
	li t2, 0
	li t3, 0
	li t4, 0
	li t5, 0
	
	jr ra
	
compute:
	add t1, sp, t2
	lb t3, 0(t1)
	beq t3, zero, exitCycle
	lb t4, 1(t1)
	
	mv a3, t3
	beq t3, t4, string
	
	addi t2, t2, 1
	j compute
	
string:
	add t4, a2, t5
	sb a3, 0(t4)
	
	addi t5, t5, 1
	addi t2, t2, 1
	j compute
	
print:
	add t1, a2, t2
	lb t3, 0(t1)
	
	beq t3, zero, exitCycle
	
	mv a0, t3
	li a7, 11
	ecall
	
	addi t2, t2, 1
	j print

exit:
	li a7, 10
	ecall