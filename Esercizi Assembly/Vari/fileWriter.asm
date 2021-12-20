#il programma scrive un file
.data
fout:	.asciz	"testout.txt"	#filename for output
buffer:	.asciz	"bonasera tipa cina cibelli brutto"

.text
.globl	main
main:	#open file (for writing) a file that does not exist
	li	a7,13
	la	a0,fout
	li	a1,1	#change to 9 to append
	li	a2,0
	ecall
	mv	s6,a7
	#system call for open file in a7
	#open for writing (flags are 0:read, 1:write)
	#open a file 
	#write file just opened
	mv	a0,s6
	la	a1,buffer
	li	a2,44
	ecall
	#close file
	li	s7,16
	mv	a0,s6
	ecall