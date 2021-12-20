#provo a fare il revers
main:	li	t0,1
	li	t1,2
	li	t2,3
	li	t3,4
	
	addi	sp,sp,-24
	sb	t0,0(sp)
	sb	t1,8(sp)
	sb	t2,16(sp)
	sb	t3,24(sp)
	
	mv	a0,t3
	jal	print
	addi	sp,sp,8
	mv	a0,t2
	jal	print
	addi	sp,sp,8
	mv	a0,t1
	jal	print
	addi	sp,sp,8
	mv	a0,t0
	jal	print
	addi	sp,sp,8
	
print:	li	a7,1
	ecall
	jr	ra