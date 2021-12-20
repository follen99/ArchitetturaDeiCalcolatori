#Media aritmetica
.data
intro: .asciz "Questo programma calcola la media aritmetica dei numeri inseriti."
request1: .asciz "\nQuanti numeri vuoi inserire? (Max 10): "
request2: .asciz "\nInserisci numero: "
result: .asciz "La media aritmetica dei numeri inseriti è: "

.globl main

.text
main:
	addi sp, sp, -10
	
	la a0, intro
	li a7, 4
	ecall
	
	la a0, request1
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	mv a2, a0
	
	jal input
	
	jal sum
	
	jal division
	
	la a0, result
	li a7, 4
	ecall
	jal print
	
	j exit
	
exitCycle:
	jr ra
		
input:
	la a0, request2
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	add t0, sp, t1
	sb a0, 0(t0)
	
	addi t1,t1,1
	beq t1, a2, exitCycle
	j input

sum:
	add t2, sp, t3
	lb t4, 0(t2)
	
	add a3, a3, t4
	
	addi t3, t3, 1
	beq t3, a2, exitCycle
	j sum

division:
	div a4, a3, a2
	jr ra

print:
	mv a0, a4
	li a7, 1
	ecall

exit:
	li a7, 10
	ecall
	
	