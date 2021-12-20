#nested loops

	li	s3,0		#i=0
for1tst:
	bge	s3,a1,exit1	#go to exit1 if s3 >= a1 (i>=n)
	#body of outer for loop
	addi	s3,s3,1		#i++
	j	for1tst
exit1:

#inner loop
	addi	s4,s2,-1
for2tst:
	blt	s4,zero,exit2	#go to exit2 if (j<0)
	slli	t0,s4,3		
	add	t0,a0,t0
	lw	t1,0(t0)
	lw	t2,8(t0)
	ble	t1,t2,exit2
	mv	s5,a0
	mv	s6,a1
	mv	a0,s5
	mv	a1,s4
	jal	ra,swap
	addi	s4,s4,-1
	j	for2tst
exit2: