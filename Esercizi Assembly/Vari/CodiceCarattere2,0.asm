#Convertitore di carattere ASCII in decimale, binario e esadecimale
.data
request: .asciz "Inserisci il carattere da anailizzare: "
result: .asciz "\nIl codice ASCII del carattere è: "
dec: .asciz " (DEC)	"
bin: .asciz " (BIN)		"
hex: .asciz " (HEX)"

.globl main

.text
main:
	la a0, request
	li a7, 4
	ecall
	
	li a7, 12
	ecall
	
	mv a1, a0
	
	la a0, result
	li a7, 4
	ecall
	
	jal decimale
	
	jal binario
	
	jal esadecimale
	
	jal finish
	
exitCycle:
	jr ra
	
decimale:
	mv a0, a1
	li a7, 1
	ecall
	
	la a0, dec
	li a7, 4
	ecall
	
	jr ra

binario:
	addi sp, sp, -32
	mv a6, a1
	li a3, 2
	
	li t1, 0 							#Inizializzo il registro t1 da usare poi come offset di scorrimento dello stack
	li t0, 0							#Inizializzo il registro t0 da usare poi come offset di scorrimento dello stack
	j loopB
	
	exitBin:
		addi sp, sp, 32
		
		la a0, bin 
		li a7, 4
		ecall
	
		jr ra
		
		loopB:
			add a4, sp, t1
	
			rem a5, a6, a3
			div a6, a6, a3
	
			sw a5, 28(a4)
	
			addi t1, t1, -4
			beqz a6, printB
	
			j loopB

		printB:
			add a4, sp, t0
			lw a5, 0(a4)
	
			mv a0, a5
			li a7, 1
			ecall
	
			li t1, 32
			addi t0, t0, 4
			beq t0, t1, exitBin
	
			j printB

esadecimale:
	addi sp, sp, -8
	li a3, 16
	
	j computeH
	
	exitHex:
		addi sp, sp, 4
		
		la a0, hex
		li a7, 4
		ecall
		
		jr ra
	
	computeH:	
		div a4, a1, a3
		rem a5, a1, a3
		
		sw a4, 0(sp)
		sw a5, 4(sp)
		
		li a6, 0 						#Inizializzo il registro a6 da usare poi come offset di scorrimento dello stack
		j printH
	
	printH:
		add a3, sp, a6
		lw a4, 0(a3)
		
		li t0, 10
		beq a4, t0, A
		li t0, 11
		beq a4, t0, B
		li t0, 12
		beq a4, t0, C
		li t0, 13
		beq a4, t0, D
		li t0, 14
		beq a4, t0, E
		li t0, 15
		beq a4, t0, F
		
		mv a0, a4
		li a7, 1
		ecall
		
		li t2, 8
		addi a6, a6, 4
		beq a6, t2, exitHex
		j printH
		
			A:
				li t1, 'A'
				mv a0, t1
				li a7, 11
				ecall
				
				addi a6, a6, 4
				j printH

			B:
				li t1, 'B'
				mv a0, t1
				li a7, 11
				ecall
				
				addi a6, a6, 4
				j printH

			C:
				li t1, 'C'
				mv a0, t1
				li a7, 11
				ecall
				
				addi a6, a6, 4
				j printH

			D:
				li t1, 'D'
				mv a0, t1
				li a7, 11
				ecall
				
				addi a6, a6, 4
				j printH

			E:
				li t1, 'E'
				mv a0, t1
				li a7, 11
				ecall
				
				addi a6, a6, 4
				j printH

			F:
				li t1, 'F'
				mv a0, t1
				li a7, 11
				ecall
				
				addi a6, a6, 4
				j printH
		
finish:
	li a7, 10
	ecall
	

