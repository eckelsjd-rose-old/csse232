
#**********************************************************************
# Add your names here.
#      Your name:  Joshua Eckels
# Partner's name:  Jerry Zheng
#**********************************************************************

# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm and p3.asm plus the following:
#
#   bne rs, rt, label	- Conditionally branch to label if register rs is
#			  not equal to register rt.
#
# It adds the numbers from 1 to N.  It assumes N > 0.
#
#
# $t0 - several uses:
#	   1) the address of N
#	   2) the value of N
#	   3) the address of Sum
# $t1 - the constant 1
# $t2 - i (the counter)
# $t3 - total (the running total)


	.globl p4		# Make p4, N, Sum, loop and done globl
	.globl N		# so you can refer to them by name.
	.globl Sum
	.globl loop
	.globl done

	.globl testN
	.globl test0

	.data			# Data section of the program.

N:	.word -5
Sum:	.word 0

testN:	.word 0			# Set this to 1 to test your program with N=1..5
test0:	.word 0			# Set this to 1 to test your program with N=0

	.text			# Text section of the program
	jal	main		# Start the test program
	
p4:				# Program4 starts here.
	# Initialization
	la	$t0, N		# Set $t0 to the address of N
	lw	$t0, 0($t0)	# Set $t0 to the value of N
	li	$t1, 1		# Set $t1 to 1
	li	$t2, 0		# Set $t2 (hereafter called i) to 0
	li	$t3, 0		# Set $t3 (hereater called total) to 0
	ble	$t0, $0, done

loop:
	add   $t2, $t2, $t1	# Increment i
	add   $t3, $t3, $t2	# Add i to total
	bne   $t2, $t0, loop	# Continue loop if i < N

done:
	la	$t0, Sum	# Set $t0 to the address of Sum
	sw	$t3, 0($t0)	# Store the total in Sum

	jr $ra			# Finish running the program

