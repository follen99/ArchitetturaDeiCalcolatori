# ascii for a: 97
# ascii for z: 122

# leggo la stringa
# la converto in lowercase
# 
.data
in_prompt:	.asciz	"Inserisci la stringa: "
out_prompt:	.asciz	"Le lettere non presenti nella stringa sono: "
space:		.asciz	", "
in_space:	.space	257
.text
.globl	main
main:	la	a0,in_prompt
	li	a7,4
	ecall
	
	la	a0,in_space
	li	a1,257
	li	a7,8
	ecall
	
	mv	t0,a0
	li	t2,'A'
	li	t3,'Z'

loop:	lbu	t1,0(t0)
	beqz	t1,finish		#se la stringa e' vuota esco
	blt	t1,t2,no_ch
	bgt	t1,t3,no_ch
	addi	t1,t1,32
	sb	t1,0(t0)
no_ch:	addi	t0,t0,1
	j	loop

finish:	
	la	t0,in_space
	li	t2,'a'
	li	t3,'z'
	jal	loop1
	
exit:
	la	a0,in_space	#stringa convertita in in_space
	li	a7,4
	ecall
	li	a7,10
	ecall

loop1:	lbu	t1,0(t0)
	beqz	t1,exit		#se finisco o la stringa è vuota esco
	mv	a0,t1
	addi	sp,sp,0		#omissibile
	sw	ra,0(sp)
	
	jal 	check
return:	addi	t0,t0,1
	j	loop1
	
	
	
check:	bne	a0,t2,print	#se le lettere sono uguali stampo
	addi	t2,t2,1		#t++ ovvero a,b,c...z
	ble	t2,t3,check
	jr	ra
print:	li	a7,1
	ecall
	j	loop1


