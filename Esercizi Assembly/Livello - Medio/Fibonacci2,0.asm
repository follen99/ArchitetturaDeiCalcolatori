#Fibonacci
.data
request: .asciz "Inserisici il numero d' ordine della successione di Fibonacci: "
result: .asciz "\nLa successione all'ordine inserito è:\n"
wrd: .space 30

.globl main

.text
main:
	li s0, 1
	li s1, ' '
	
	la a0, request
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	mv a2, a0
	
	la a3, wrd
	
	jal prepare
	jal compute
	jal clear
	
	la a0, result
	li a7, 4
	ecall
	jal print
	j exit
	
exitCycle:
	jr ra

prepare:
	add t1, a3, t2
	sb s0, 0(t1)
	sb s0, 1(t1)
	
	jr ra
	
compute:
	add t3, a3, t4
	lb t5, 0(t3)
	lb t6, 1(t3)
	
	beq t4, a2, exitCycle
	
	add a4, t5, t6
	sb a4, 2(t3)
	
	addi t4, t4, 1
	j compute

clear:
	li t1, 0
	li t2, 0
	li t3, 0
	li t4, 0
	li t5, 0
	li t6, 0
	
	jr ra
	
print:
	add t1, a3, t2
	lb t3, 0(t1)
	beq t2, a2, exitCycle
	
	mv a0, t3
	li a7, 1
	ecall
	
	mv a0, s1
	li a7, 11
	ecall
	
	addi t2, t2, 1
	j print
	
exit:
	li a7, 10
	ecall