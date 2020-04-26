
#**********************************************************************
# Add your names here.
#      Your name:  Josh Eckels
# Partner's name:  Jerry Zheng
#**********************************************************************

# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm, p3.asm, p4.asm and p5.asm.
#

	.globl	p6
	.globl	V
	.globl	N

	.data

V:	.word   20, 56, -90, 37, -2, 30, 10, -66, -4, 18
N:	.word	10

#**********************************************************************

	.text

	jal	main	# Start test program

p6:			# Program 6 starts here

#----------------------------------------------------------------------
#	 Rotate the array V
#----------------------------------------------------------------------
#
# Insert your code here
#
#----------------------------------------------------------------------

# Initialization
	la	$t4, N
	lw	$t6, 0($t4)	# store N in reg t6 (t4 used temporarily)
	la	$t0, V		# Set $t0 to the address of N
	li	$t1, 1		# Set $t1 to 0; used for index i
	addi	$t2, $t0, 36	# Set $t2 to memory location of last element
	li	$t3, 0		# $t3 used for address of V[i]
	li	$t4, 0		# $t4 used for swapping first and last elements
	li	$t5, 0		# temp reg
	
	# swap first and last elements
	
	lw $t4, 0($t2)
	lw $t5, 0($t0)
	sw $t5, 0($t2)
	sw $t4, 0($t0)
	
loop:
	beq $t1, $t6, exit
	# get the address of V(i) and store in $t3
	sll $t3, $t1, 2
	add $t3, $t3, $t0
	# swap V(i) with last element
	lw $t4, 36($t0)
	lw $t5, 0($t3)
	sw $t4, 0($t3)
	sw $t5, 36($t0)
	# increment i
	addi $t1, $t1, 1
	j loop
	
exit:
	jr	$ra		# Exit program 6
