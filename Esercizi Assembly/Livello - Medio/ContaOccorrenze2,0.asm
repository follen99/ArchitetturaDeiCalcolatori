#Conta occorrenze
.data
intro: .asciz "Questo programma conta le occorreze in una stringa."
request: .asciz "\nInserisci la stringa da analizzare: "
result: .asciz "\nIl numero di parole ripetute è: "
str: .space 30

.globl main
.text
	
	li s0, '\n'
	la a2, str

	introduction:
		la a0, intro
		li a7, 4
		ecall
	
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
		add t1, a2, a3
		
		li a7, 12
		ecall
		
		beq a0, s0, exitCycle
		
		sb a0, 0(t1)
		addi a3, a3, 1
		j insert
		
	compute:
		add t3, a2, t4
		lb t5, 0(t3)
		lb t6, 1(t3)
		
		beq t4, a3, exitCycle
		addi t4, t4, 1
		
		beq t5, t6, counter
		
		j compute
		
	counter:
		addi a4, a4, 1
		j compute
		
	print:
		la a0, result
		li a7, 4
		ecall
		
		mv a0, a4
		
		li a7, 1
		ecall
		
		jr ra
		
	exit:
		li a7, 10
		ecall
		
		
		
	

