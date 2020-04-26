#	  Your name:  
# Partner's name:  
#
# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm, p3.asm, p4.asm and p5.asm.
#
# It also takes advantage of several syscalls and the assembly
# directive .asciiz
#

	.globl	main

	.data

message1:	.asciiz "Initial array: "
message2:	.asciiz "Rotated array: "
failmsg:	.asciiz "Array rotated by one to the right [FAIL]\n"
passmsg:	.asciiz "Array rotated by one to the right [PASS]\n"
sep:		.asciiz " "
newline:	.asciiz "\n"

#**********************************************************************

	.text

main:
	#print initial array
	la	$a0, message1
	li	$v0, 4
	syscall
	jal 	printArray
	
	jal	p6
	
	#print rotated array
	la	$a0, message2
	li	$v0, 4
	syscall
	jal	printArray
	jal	testarray
	
	#exit
	li	$v0, 10
	syscall

#----------------------------------------------------------------------
#	 Print the rotated array
#----------------------------------------------------------------------

printArray:
	la	$t1, N		# load the address of N
	lw	$t1, 0($t1)	# load the value of N
	sll	$t1, $t1, 2	# multiply by 4
	li	$t0, 0		# initialize the index
loop2:	lw	$a0, V($t0)	# store next element
	li	$v0, 1		# use system call to
	syscall			# print the min
	la	$a0, sep	# store pointer to sep
	li	$v0, 4		# use system call to
	syscall			# print sep
	add	$t0, $t0, 4	# increment the index
	bne	$t0, $t1, loop2	# check if we've printed all the elements
	la	$a0, newline	# store pointer to a new line
	li	$v0, 4		# use system call to
	syscall			# print new line
	jr	$ra

# --------------------------------------------------------------------
#   Test 
# ---------------------------------------------------------------------

testarray:
	la	$t0, V
	add	$t1, $0, $0

	lw	$t1, 0($t0)
	addi	$t1, $t1, -18
	bne	$t1, $0, testfail
	lw	$t1, 4($t0)
	addi	$t1, $t1, -20
	bne	$t1, $0, testfail
	lw	$t1, 8($t0)
	addi	$t1, $t1, -56
	bne	$t1, $0, testfail
	lw	$t1, 12($t0)
	addi	$t1, $t1, 90
	bne	$t1, $0, testfail
	lw	$t1, 16($t0)
	addi	$t1, $t1, -37
	bne	$t1, $0, testfail
	lw	$t1, 20($t0)
	addi	$t1, $t1, 2
	bne	$t1, $0, testfail
	lw	$t1, 24($t0)
	addi	$t1, $t1, -30
	bne	$t1, $0, testfail
	lw	$t1, 28($t0)
	addi	$t1, $t1, -10
	bne	$t1, $0, testfail
	lw	$t1, 32($t0)
	addi	$t1, $t1, 66
	bne	$t1, $0, testfail
	lw	$t1, 36($t0)
	addi	$t1, $t1, 4
	bne	$t1, $0, testfail

testpass:
	la	$a0, passmsg
	li	$v0, 4
	syscall
	j	testdone
testfail:
	la	$a0, failmsg
	li	$v0, 4
	syscall
testdone:
	jr	$ra
