# Sum of three integers
#
# Objective: Computes the sum of three integers. 
#     Input: Requests three numbers.
#    Output: Outputs the sum.
################### Data segment ###################
.data
prompt:		.asciz	"Please enter three numbers: \n"
sum_msg:	.asciz	"The sum is: "
################### Code segment ###################
.text
.globl main
main:
la    	a0,prompt							# display prompt string
li	a7,4
ecall
li	a7,5								# read 1st integer into t0
ecall
mv	t0,a0
li	a7,5								# read 2nd integer into t1
ecall
mv  	t1,a0
li	a7,5								# read 3rd integer into t2
ecall
mv  	t2,a0

add	t0,t0,t1							# accumulate the sum
add	t0,t0,t2
la   	a0,sum_msg							# write sum message
li	a7,4
ecall
mv 	a0,t0								# output sum
li	a7,1
ecall
li	a7,10								# exit
ecall
