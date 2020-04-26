#**********************************************************************
# Add your names here.
#      Your name:  Joshua Eckels
# Partner's name:  Cameron Reid
#**********************************************************************


#**********************************************************************
# This file contains a recursive MIPS assembly language 
# procedure which calculates Fibonacci numbers.
#**********************************************************************

	.globl fib
	
	
	.text

	j	main	# Run the test program which will call your fib procedure


#----------------------------------------------------------------------
#   Procedure: fib
#       
#   Frame is 4 words long, as follows:
#     -- previous ra
#     -- nothing
#     -- previous s1
#     -- previous s0
#
#   Arguments:
#     $a0 - n
#
#   Returns:
#     $v0 - fib(n)
#
#   Register allocations:
#     $s0 - n
#     $s1 - fib(n-1)
#
#----------------------------------------------------------------------

fib:
	# back up registers
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $s1, 8($sp)
	sw $s0, 0($sp)

	move $s0, $a0
	
	# base case 0
	bne $a0, $0, next
	add $v0, $0, $0
	j exit
	
next:
	# base case 1
	addi $t0, $0, 1
	bne $t0, $a0, recursive
	add $v0, $t0, $0
	j exit
	
recursive:
	# f(n-1)
	sub $a0, $s0, 1
	jal fib
	move $s1, $v0
	
	# f(n-2)
	sub $a0, $s0, 2
	jal fib
	add $v0, $v0, $s1	

exit:
	# restore values
	lw $ra, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 16
	jr $ra
	
	
	

	
	
