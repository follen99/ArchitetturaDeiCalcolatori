#provo a fare il revers con loop
main:	li	t0,1
	li	t1,2
	li	t2,3
	li	t3,4
	
	li	s0,4
	
loop:	beqz	s0,exit
	addi	sp,sp,-8
	sb	t0,0(sp)

exit: