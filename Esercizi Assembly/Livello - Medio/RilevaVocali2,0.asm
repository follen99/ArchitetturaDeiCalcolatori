#Rileva vocali
.data
request: .asciz "Inserisci la stringa da analizzare: "
result: .asciz "\nLe vocali inserite sono: "
str: .space 40
voc: .space 40

.globl main

.text
main:
	la a0, request
	li a7, 4
	ecall
	
	jal insert
	jal compute
	
	la a0, result
	li a7, 4
	ecall
	
	jal print
	j exit
	
exitCycle:
	jr ra
	
insert:
	la a1, str
	li a3, '\n'
	li t0, 0
	
	insertLoop:
		add a2, a1, t0
		
		li a7, 12
		ecall
		
		beq a0, a3, exitCycle
		sb a0, 0(a2)
		
		addi t0,t0,1
		j insertLoop
	
compute:
	li t0, 0
	la a4, voc
	li t2, 0
	
	computeLoop:
		add a2, a1, t0
		lb a3, 0(a2)
		
		addi t0, t0, 1
		
		li t1, 'A'
		beq a3, t1, vocals
		li t1, 'E'
		beq a3, t1, vocals
		li t1, 'I'
		beq a3, t1, vocals
		li t1, 'O'
		beq a3, t1, vocals
		li t1, 'U'
		beq a3, t1, vocals
		
		li t1, 'a'
		beq a3, t1, vocals
		li t1, 'e'
		beq a3, t1, vocals
		li t1, 'i'
		beq a3, t1, vocals
		li t1, 'o'
		beq a3, t1, vocals
		li t1, 'u'
		beq a3, t1, vocals
	
		beqz a3, exitCycle
		j computeLoop
		
	vocals:
		add a5, a4, t2
		sb a3, 0(a5)
		
		addi t2, t2, 1
		j computeLoop
	
print:
	li t0, 0
	
	printLoop:
		add a2, a4, t0
		lb a0, 0(a2)
		
		li a7, 11
		ecall
		
		addi t0, t0, 1
		beqz a0, exitCycle
		j printLoop
	
exit:
	li a7, 10
	ecall
	