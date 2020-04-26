#**********************************************************************
# This file contains a MIPS assembly language program that tests a
# recursive procedure fib which calculates Fibonacci numbers.
#**********************************************************************

	.globl main
	.globl Start
	.globl Okay
	.globl Again
	.globl ExitMain
	.globl  fibtest

	.data
prompt:		.asciiz "Input a non-negative integer => "
prompt2:	.asciiz "Do you wish to try another? (1/0) "
message:	.asciiz "Fibonacci number "
message2:	.asciiz " is: "
newline:	.asciiz "\n"
error:		.asciiz "The integer must be non-negative\n"
sregerror:	.asciiz "fib() appears to use an s reg without backing it up.\n"
sperror:	.asciiz "fib() does not appears to restore the stack size correctly.\n"

#----------------------------------------------------------------------
#   Frame is 12 words long, as follows:
#     -- previous s0
#     -- previous s1
#     -- previous s2
#     -- previous s3
#     -- previous s4
#     -- previous s6
#     -- previous s6
#     -- previous s7
#     -- previous ra
#     -- empty
#     -- empty
#     -- empty
#
#   Arguments:
#     none
#
#   Returns:
#     none
#
#   Register allocations:
#    $s6 - n
#    $t0 - temp storage for fib(n)
#
#   asks user for number n and gives n to fib
#----------------------------------------------------------------------

	.text

main:
	sub	$sp, $sp, 44	# Create a multiword frame to set 16 byte frame align
	sw	$ra, 32($sp)	# Save $ra
	sw	$s7, 28($sp)	# Save $s7
	sw	$s6, 24($sp)	# Save $s6
	sw	$s5, 20($sp)	# Save $s5
	sw	$s4, 16($sp)	# Save $s4
	sw	$s3, 12($sp)	# Save $s3
	sw	$s2, 8($sp)	# Save $s2
	sw	$s1, 4($sp)	# Save $s1
	sw	$s0, 0($sp)	# Save $s0
	li	$s0, 42
	li	$s1, 42
	li	$s2, 42
	li	$s3, 42
	li	$s4, 42
	li	$s5, 42
	li	$s6, 42
	move	$s7, $sp

#----------------------------------------------------------------------
#       Read an integer
#----------------------------------------------------------------------

Start:	la	$a0, prompt	# load address of prompt
	li	$v0, 4		# use system call to
	syscall			# print prompt
	li	$v0, 5		# use system call for reading
	syscall			# an integer n
	move	$s6, $v0	# Copy integer n into $s6

#----------------------------------------------------------------------
#       Check if the integer is in bounds
#----------------------------------------------------------------------

	slt	$t0, $s6, $zero		# check if n is negative
	beq	$t0, $zero, Okay	# if non-negative, calc fib(n)
	la	$a0, error		# load address of prompt
	li	$v0, 4			# use system call to
	syscall				# print error mesage
	j	Again

# ---------------------------------------------------------------------
#   Execute the fib procedure.
# ---------------------------------------------------------------------

Okay:   move	$a0, $s6	# Pass n to
	jal	fib		#       fib
	move	$t0, $v0	# save result
	la	$a0, message	# load address of message
	li	$v0, 4	  	# use system call to
	syscall			# print message
	move	$a0, $s6	# n
	li	$v0, 1	  	# use system call to
	syscall		 	# print n
	la	$a0, message2   # load address of message2
	li	$v0, 4		# use system call to
	syscall			# print message2
	move	$a0, $t0	# fib(n)
	li	$v0, 1		# use system call to
	syscall			# print fib(n)
	la	$a0, newline	# load address of newline
	li	$v0, 4		# use system call to
	syscall			# print newline
	la	$a0, newline	# load address of newline
	li	$v0, 4		# use system call to
	syscall			# print newline

# ---------------------------------------------------------------------
#   Test call convention
# ---------------------------------------------------------------------

	li	$t0, 0	# start with 0
	add	$t0, $t0, $s0	# accumulate s reg value
	add	$t0, $t0, $s1	# accumulate s reg value
	add	$t0, $t0, $s2	# accumulate s reg value
	add	$t0, $t0, $s3	# accumulate s reg value
	add	$t0, $t0, $s4	# accumulate s reg value
	add	$t0, $t0, $s5	# accumulate s reg value
				# s6 and s7 are being used
	li	$t1, 252	# load 6*42
	beq	$t0, $t1, Test2 # no error
	la	$a0, sregerror  # load address of string
	li	$v0, 4		# use system call to
	syscall			# print string
	j	ExitMain

Test2:  beq	$s7, $sp, Again	# no error
	la	$a0, sperror	# load address of string
	li	$v0, 4		# use system call to
	syscall			# print string
	j	ExitMain
	
# ---------------------------------------------------------------------
#   Do it again?
# ---------------------------------------------------------------------

Again:  la	$a0, prompt2	# load address of prompt2
	li	$v0, 4		# use system call to
	syscall			# print prompt2
	li	$v0, 5		# use system call for reading
	syscall			# an integer
	move	$t0, $v0	# save response
	la	$a0, newline	# load address of newline
	li	$v0, 4		# use system call to
	syscall			# print newline
	bne	 $t0, $zero, Start # do it again.

# ---------------------------------------------------------------------
#   Exit the main procedure.
# ---------------------------------------------------------------------

ExitMain:
	lw	$s0, 0($sp)	# Restore $s0
	lw	$s1, 4($sp)	# Restore $s1
	lw	$s2, 8($sp)	# Restore $s2
	lw	$s3, 12($sp)	# Restore $s3
	lw	$s4, 16($sp)	# Restore $s4
	lw	$s5, 20($sp)	# Restore $s5
	lw	$s6, 24($sp)	# Restore $s6
	lw	$s7, 28($sp)	# Restore $s7
	lw	$ra, 32($sp)	# Restore $ra
	sub	$sp, $sp, 36	# Undo the 9-word frame.
#	jr	$ra		# Return
	li	$v0, 10
	syscall


# ---------------------------------------------------------------------
#   Procedure: fibtest
#
# Blows away registers to test compliance with the procedure calling
#  conventions.
# ---------------------------------------------------------------------
  

fibtest:
	sub	$sp, $sp, 36	 # Create frame for s regs
	sw	$s0,  0($sp)	 # Save $s0
	sw	$s1,  4($sp)	 # Save $s1
	sw	$s2,  8($sp)	 # Save $s2
	sw	$s3, 12($sp)	 # Save $s3
	sw	$s4, 16($sp)	 # Save $s4
	sw	$s5, 20($sp)	 # Save $s5
	sw	$s6, 24($sp)	 # Save $s6
	sw	$s7, 28($sp)	 # Save $s7
	sw	$ra, 32($sp)	 # Save $ra
		

	li	$v0, -1
	li	$v1, -1
#	li	$a0, -1
	li	$a1, -1
	li	$a2, -1
	li	$a3, -1
	li	$t0, -1
	li	$t1, -1
	li	$t2, -1
	li	$t3, -1
	li	$t4, -1
	li	$t5, -1
	li	$t6, -1
	li	$t7, -1
	li	$t8, -1
	li	$t9, -1
	li	$s0, -1
	li	$s1, -1
	li	$s2, -1
	li	$s3, -1
	li	$s4, -1
	li	$s5, -1
	li	$s6, -1
	li	$s7, -1
	li	$k0, -1
	li	$k1, -1

	jal	 fib
	
	
	
#	li	$v0, -1
	li	$v1, -1
	li	$a0, -1
	li	$a1, -1
	li	$a2, -1
	li	$a3, -1
	li	$t0, -1
	li	$t1, -1
	li	$t2, -1
	li	$t3, -1
	li	$t4, -1
	li	$t5, -1
	li	$t6, -1
	li	$t7, -1
	li	$t8, -1
	li	$t9, -1
	li	$s0, -1
	li	$s1, -1
	li	$s2, -1
	li	$s3, -1
	li	$s4, -1
	li	$s5, -1
	li	$s6, -1
	li	$s7, -1
	li	$k0, -1
	li	$k1, -1

	lw	$s0,  0($sp)	 # Restore $s0
	lw	$s1,  4($sp)	 # Restore $s1
	lw	$s2,  8($sp)	 # Restore $s2
	lw	$s3, 12($sp)	 # Restore $s3
	lw	$s4, 16($sp)	 # Restore $s4
	lw	$s5, 20($sp)	 # Restore $s5
	lw	$s6, 24($sp)	 # Restore $s6
	lw	$s7, 28($sp)	 # Restore $s7
	lw	$ra, 32($sp)	 # Restore $ra
	add	$sp, $sp, 36   # Undo the frame.

	jr	$ra
