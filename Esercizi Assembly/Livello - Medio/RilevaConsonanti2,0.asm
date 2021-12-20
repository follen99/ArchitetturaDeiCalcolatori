#Rileva consonanti
.data
request: .asciz "Inserisci una stringa da analizzare: "
result: .asciz "\nLe consonanti inserite sono: "
str: .space 50

.globl main

.text
start:
	addi sp, sp, -40
	la a2, str
	li s0, '\n'
	li s1, 65
	li s2, 90
	li s3, 97
	li s4, 122
	
main:
	la a0, request
	li a7, 4
	ecall
	
	jal insert
	jal clear
	jal compute
	jal clear
	
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
	
	sb a0, 0(t1)
	beq a0, s0, exitCycle
	

	addi t2, t2, 1
	mv s5, t2
	j insert

clear:
	li t1, 0
	li t2, 0
	li t3, 0
	li t4, 0
	li t5, 0
	li t6, 0
	li a3, 0
	
	jr ra
	
compute:
	add t3, sp, t4
	lb t5, 0(t3)
	
	beq t4, s5, exitCycle
	
	li t6, 'a'
	beq t6, t5, skip
	
	li t6, 'e'
	beq t6, t5, skip
	
	li t6, 'i'
	beq t6, t5, skip
	
	li t6, 'o'
	beq t6, t5, skip
	
	li t6, 'u'
	beq t6, t5, skip
	
	li t6, 'A'
	beq t6, t5, skip
	
	li t6, 'E'
	beq t6, t5, skip
	
	li t6, 'I'
	beq t6, t5, skip
	
	li t6, 'O'
	beq t6, t5, skip
	
	li t6, 'U'
	beq t6, t5, skip
	
	mv a3, t5
	bge t5, s1, consonants
	ble t5, s2, consonants
	
	bge t5, s3, consonants
	ble t5, s4, consonants
	
	addi t4, t4, 1
	j compute
	
skip:
	addi t4, t4, 1
	j compute
	
consonants:
	add t1, a2, t2
	sb a3, 0(t1)
	
	addi t2, t2, 1
	addi t4, t4, 1
	j compute

print:
	add t1, a2, t2
	lb a0, 0(t1)
	
	li a7, 11
	ecall
	
	beq a0, zero, exitCycle
	addi t2, t2, 1
	j print

exit:
	addi sp, sp, 40
	li a7, 10
	ecall