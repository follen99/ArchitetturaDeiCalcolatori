#Coverti i numeri inseriti in lettere
.data
request: .asciz "Inserisci un numero compreso tra 1 e 999: "
result: .asciz "\nIl numero che hai inserito convertito in lettere è:\n"

str1: .asciz "uno"
str2: .asciz "due"
str3: .asciz "tre"
str4: .asciz "quattro"
str5: .asciz "cinque"
str6: .asciz "sei"
str7: .asciz "sette"
str8: .asciz "otto"
str9: .asciz "nove"
str10: .asciz "dieci"
str11: .asciz "undici"
str12: .asciz "dodici"
str13: .asciz "tredici"
str14: .asciz "quattordici"
str15: .asciz "quindici"
str16: .asciz "sedici"
str17: .asciz "diciassette"
str18: .asciz "diciotto"
str19: .asciz "diciannove"
str20: .asciz "venti"
str30: .asciz "trenta"
str40: .asciz "quaranta"
str50: .asciz "cinquanta"
str60: .asciz "sessanta"
str70: .asciz "settanta"
str80: .asciz "ottanta"
str90: .asciz "novanta"
str100: .asciz "cento"

num: .space 30

.globl main

.text
main:
	la a0, request
	li a7, 4
	ecall
	
	li a7, 5
	ecall
	
	mv a1, a0
	
	la a0, result
	li a7, 4
	ecall
	
	jal conversion
	j finish
	
conversion:
	li t0, 100
	div a2, a1, t0									#centinaia
	rem a3, a1, t0									#numeri da 10 a 19
	li t3, 10
	div a4, a3, t3									#decine
	rem a5, a3, t3									#unità
	
centinaia:	
	li t6, 0
	beq a2, t6, decine
	
	li t6, 1
	beq a2, t6, cento
	li t6, 2
	beq a2, t6 duecento
	li t6, 3
	beq a2, t6 trecento
	li t6, 4
	beq a2, t6 quattrocento
	li t6, 5
	beq a2, t6 cinquecento
	li t6, 6
	beq a2, t6 seicento
	li t6, 7
	beq a2, t6 settecento
	li t6, 8
	beq a2, t6 ottocento
	li t6, 9
	beq a2, t6 novecento
	
decine:
	li t6, 0
	beq a3, t6, unità
	beq a4, t6, unità
	
	li t6, 10
	beq a3, t6, dieci	
	li t6, 11
	beq a3, t6, undici
	li t6, 12
	beq a3, t6, dodici
	li t6, 13
	beq a3, t6, tredici
	li t6, 14
	beq a3, t6, quattordici
	li t6, 15
	beq a3, t6, quindici
	li t6, 16
	beq a3, t6, sedici
	li t6, 17
	beq a3, t6, diciassette
	li t6, 18
	beq a3, t6, diciotto
	li t6, 19
	beq a3, t6, diciannove
	li t6, 2
	beq a4, t6, venti
	li t6, 3
	beq a4, t6, trenta
	li t6, 4
	beq a4, t6, quaranta
	li t6, 5
	beq a4, t6, cinquanta
	li t6, 6
	beq a4, t6, sessanta
	li t6, 7
	beq a4, t6, settanta
	li t6, 8
	beq a4, t6, ottanta
	li t6, 9
	beq a4, t6, novanta
	
unità:
	li t6, 0
	beq a5, t6, exit
	
	li t6, 1
	beq a5, t6, uno
	li t6, 2
	beq a5, t6, due
	li t6, 3
	beq a5, t6, tre
	li t6, 4
	beq a5, t6, quattro
	li t6, 5
	beq a5, t6, cinque
	li t6, 6
	beq a5, t6, sei
	li t6, 7
	beq a5, t6, sette
	li t6, 8
	beq a5, t6, otto
	li t6, 9
	beq a5, t6, nove
	
cento:
	la a0, str100
	li a7, 4
	ecall
	
	j decine

duecento:
	la a0, str2
	li a7, 4
	ecall
	
	la a0, str100
	li a7, 4
	ecall
	
	j decine

trecento:
	la a0, str3
	li a7, 4
	ecall
	
	la a0, str100
	li a7, 4
	ecall
	
	j decine
	
quattrocento:
	la a0, str4
	li a7, 4
	ecall
	
	la a0, str100
	li a7, 4
	ecall
	
	j decine

cinquecento:
	la a0, str5
	li a7, 4
	ecall
	
	la a0, str100
	li a7, 4
	ecall
	
	j decine

seicento:
	la a0, str6
	li a7, 4
	ecall
	
	la a0, str100
	li a7, 4
	ecall
	
	j decine
	
settecento:
	la a0, str7
	li a7, 4
	ecall
	
	la a0, str100
	li a7, 4
	ecall
	
	j decine

ottocento:
	la a0, str8
	li a7, 4
	ecall
	
	la a0, str100
	li a7, 4
	ecall
	
	j decine

novecento:
	la a0, str9
	li a7, 4
	ecall
	
	la a0, str100
	li a7, 4
	ecall
	
	j decine

dieci:
	la a0, str10
	li a7, 4
	ecall
	
	j exit
	
undici:
	la a0, str11
	li a7, 4
	ecall
	
	j exit
	
dodici:
	la a0, str12
	li a7, 4
	ecall
	
	j exit
	
tredici:
	la a0, str13
	li a7, 4
	ecall
	
	j exit
	
quattordici:
	la a0, str14
	li a7, 4
	ecall
	
	j exit
	
quindici:
	la a0, str15
	li a7, 4
	ecall
	
	j exit
	
sedici:
	la a0, str16
	li a7, 4
	ecall
	
	j exit
	
diciassette:
	la a0, str17
	li a7, 4
	ecall
	
	j exit
	
diciotto:
	la a0, str18
	li a7, 4
	ecall
	
	j exit
	
diciannove:
	la a0, str19
	li a7, 4
	ecall
	
	j exit
	
venti:
	la a0, str20
	li a7, 4
	ecall
	
	j unità
	
trenta:
	la a0, str30
	li a7, 4
	ecall
	
	j unità
	
quaranta:
	la a0, str40
	li a7, 4
	ecall
	
	j unità
	
cinquanta:
	la a0, str50
	li a7, 4
	ecall
	
	j unità
	
sessanta:
	la a0, str60
	li a7, 4
	ecall
	
	j unità
	
settanta:
	la a0, str70
	li a7, 4
	ecall
	
	j unità
	
ottanta:
	la a0, str80
	li a7, 4
	ecall
	
	j unità
	
novanta:
	la a0, str90
	li a7, 4
	ecall
	
	j unità

uno:
	la a0, str1
	li a7, 4
	ecall
	
	j exit
	
due:
	la a0, str2
	li a7, 4
	ecall
	
	j exit
	
tre:
	la a0, str3
	li a7, 4
	ecall
	
	j exit
	
quattro:
	la a0, str4
	li a7, 4
	ecall
	
	j exit
	
cinque:
	la a0, str5
	li a7, 4
	ecall
	
	j exit
	
sei:
	la a0, str6
	li a7, 4
	ecall
	
	j exit
	
sette:
	la a0, str7
	li a7, 4
	ecall
	
	j exit
	
otto:
	la a0, str8
	li a7, 4
	ecall
	
	j exit
	
nove:
	la a0, str9
	li a7, 4
	ecall
	
	j exit
	
exit:
	jr ra
	
finish:
	li a7, 10
	ecall