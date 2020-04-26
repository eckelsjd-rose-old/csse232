
#**********************************************************************
# Add your names here.
#      Your name:  
# Partner's name:  
#**********************************************************************


# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm, p3.asm, p4.asm and p5.asm.
#
# It also takes advantage of several spim syscalls and the assembly
# directive .asciiz
#

#**********************************************************************

	.globl	SwapMaxWithLast
	.text

# ---------------------------------------------------------------------
# Procedure: SwapMaxWithLast
#
# No frame, none is needed.
#
# Arguments:
#  $a0 = address of the array
#  $a1 = number of elements in the array
#
# Returns:
#  none
#
# Register allocations:
#  none:
#
# Swaps the maximum element with the last element of the array.
# ---------------------------------------------------------------------

SwapMaxWithLast:

# The SwapMaxWithLast label is the procedure entry point.
#
#
# Insert your code here
#
	jr	$ra
