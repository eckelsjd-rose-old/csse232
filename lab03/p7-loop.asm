
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

	.globl	arrayAudio
	.globl	A
	.globl	N
	.globl	p7



	.data

arrayAudio:	.word	1	#set this to 1 to 'hear' the array as a test
A:		.word	20, 56, -90, 37, -2, 30, 10, -66, -4, 18
N:		.word	10

#**********************************************************************

	.text
	jal 	main	#run the test program

p7:			#start of program7

#----------------------------------------------------------------------
# Sort the array by repeatedly calling SwapMaxWithLast
#----------------------------------------------------------------------

#
# Write code here to call your SwapMaxWithLast
#
# You will need to edit p7-swap.asm to update the 
# actual SwapMaxWithLast procedure
#



	j	p7done	#return to testing code
