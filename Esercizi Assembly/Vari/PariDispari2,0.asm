#Pari o dispari
.data
request1: .asciz "Quanti numeri vuoi inserire? (MAX 10): "
request2: .asciz "\nInserisci un numero: "
resultZ: .asciz "\nZero non è nè pari nè dispari."
resultP: .asciz "\nI numeri pari sono: "
resultD: .asciz "\nI numeri dispari sono: "
num: .space 40
par: .space 40
dis: .space 40

.globl main

.text
main:
	la a0, request1
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	mv a1, a0
	
	jal insert
	jal compute
	jal printPari
	jal printDispari
	j exit

exitCycle:
	jr ra
insert:
	la a2, num
	li t0, 0

insertLoop:
	add a3, a2, t0
	
	la a0, request2
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	sb a0, 0(a3)
	addi t0, t0, 1
	beq t0, a1, exitCycle
	j insertLoop

compute:
	li a3, 0
	la a5, par
	la a6, dis
computeLoop:
	add t0, a2, a3
	lb a4, 0(t0)
	
	beq a3, a1, exitCycle
	li t2, 2
	rem t1, a4, t2
	
	beqz a4, Zero
	bnez t1, dispari
	beqz t1, pari

Zero:
	la a0, resultZ
	li a7, 4
	ecall
	
	addi a3, a3, 1
	j computeLoop
pari:
	add t3, a5, t5
	sb a4, 0(t3)
	
	addi t5, t5, 1
	addi a3, a3, 1
	j computeLoop
	
dispari:
	add t4, a6, t6
	sb a4, 0(t4)
	
	addi t6, t6, 1
	addi a3, a3, 1	
	j computeLoop
	
printPari:
	la a0, resultP
	li a7, 4
	ecall
	
	mv a1, t5
	li t1, 0
pariLoop:
	add a2, a5, t1
	
	lb a0, 0(a2)
	li a7, 1
	ecall
	
	li t2, ' '
	mv a0, t2
	li a7, 11
	ecall
	
	addi t1, t1, 1
	beq t1, a1, exitCycle
	j pariLoop
	
printDispari:
	la a0, resultD
	li a7, 4
	ecall
	
	mv a3, t6
	li t3, 0
	
dispariLoop:
	add a4, a6, t3
	
	lb a0, 0(a4)
	li a7, 1
	ecall
	
	li t2, ' '
	mv a0, t2
	li a7, 11
	ecall
	
	addi t3, t3, 1
	beq t3, a3, exitCycle
	j dispariLoop
	
exit:
	li a7, 10
	ecall
	
	