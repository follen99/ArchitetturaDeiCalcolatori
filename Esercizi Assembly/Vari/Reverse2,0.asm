#Reverse
.data
request: .asciz "Inserisci la stringa da ribaltare: "
result: .asciz "\nLa stringa ribaltata è: "
str: .space 40
rev: .space 40

.globl main

.text
main:
	la a0, request
	li a7, 4
	ecall
	
	jal insert
	jal reverse
	
	la a0, result
	li a7, 4
	ecall
	
	jal print
	j exit

exitCycle:
	jr ra
	
insert:
	la a1, str
	li a3, 0
	
insertLoop:
	add t0, a1, a3
	
	li a7, 12
	ecall
	
	li t1, ' '
	beq a0, t1, exitCycle
	li t1, '\n'
	beq a0, t1, exitCycle
	sb a0, 0(t0)
	addi a3, a3, 1
	j insertLoop

reverse:
	mv a6, a3
	addi a6, a6, -1
	la a2, rev

reverseLoop:
	add t0, a1, a6
	lb t3, 0(t0)
	
	add t1, a2, t2
	sb t3, 0(t1)
	
	addi a6, a6, -1
	addi t2, t2, 1
	
	li t4, -1
	beq a6, t4, exitCycle
	j reverseLoop
	
print:
	li t1, 0
	
printLoop:
	add t0, a2, t1
	lb a0, 0(t0)
	
	li a7, 11
	ecall
	
	addi t1, t1, 1
	beqz a0, exitCycle
	j printLoop
	
exit:
	li a7, 10
	ecall
