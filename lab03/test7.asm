# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm, p3.asm, p4.asm and p5.asm.
#
# It also takes advantage of several spim syscalls and the assembly
# directive .asciiz
#

#**********************************************************************

	.globl	main
	.globl	ProcedureConventionTester
	.globl	p7done
	.data

tempregs:	.asciiz	"Used 'a' and 't' registers "
pass:		.asciiz "[PASS]\n"
fail:		.asciiz	"[FAIL]\n"
message1:	.asciiz "The input array:\t"
message2:	.asciiz "The sorted array:\t"
sep:		.asciiz " "
newline:	.asciiz "\n"

#**********************************************************************

	.text

main:

	addi	$sp, $sp, -12	# Create space on the stack
	sw	$ra, 0($sp)	# Save $ra
	sw	$s0, 4($sp)	# need for tests
	sw	$s1, 8($sp)


#----------------------------------------------------------------------
# Print the unsorted array
#----------------------------------------------------------------------

	la	$a0, N		  
	lw	$a0, 0($a0)	# pass the length of A
	la	$a1, A		# pass address of A
	la	$a2, message1   # pass address of message1
	jal	print		# call print

#----------------------------------------------------------------------
# Play the unsorted array
#----------------------------------------------------------------------
	la	$a0, arrayAudio
	lw	$a0, 0($a0)
	beq	$a0, $0, skipplay1
	
	la	$a0, A  
	la	$a1, N          
	lw	$a1, 0($a1)     # pass the length of A
	jal	playsounds

skipplay1:

#----------------------------------------------------------------------
# Put values in all the temp registers
#----------------------------------------------------------------------
	li	$a0, 0x00100000
	li	$a1, 0x00100000
	li	$a2, 0x00100000
	li	$a3, 0x00100000
	li	$v0, 0x00100000
	li	$v1, 0x00100000
	li	$t0, 0x00100000
	li	$t1, 0x00100000
	li	$t2, 0x00100000
	li	$t3, 0x00100000
	li	$t4, 0x00100000
	li	$t5, 0x00100000
	li	$t6, 0x00100000
	li	$t7, 0x00100000
	li	$t8, 0x00100000
	li	$t9, 0x00100000

#----------------------------------------------------------------------
#	   Call p7 to test it
#----------------------------------------------------------------------

	j	p7
	
p7done:

#----------------------------------------------------------------------
# Verify that temp registers have changed
#  Makes sure they didn't use the a/v/t in s style
#----------------------------------------------------------------------

	add	$s0, $a0, $0	#backup a0,v0
	add	$s1, $v0, $0
	la	$a0, tempregs
	li	$v0, 4
	syscall			#temp reg message
	
	add	$a0, $s0, $0
	add	$a0, $a0, $a1
	add	$a0, $a0, $a2
	add	$a0, $a0, $a3
	li	$v0, 0x00400000
	beq	$a0, $v0, tempregfail

#	add	$v0, $s1, $0
#	add	$v0, $v0, $v1
#	li	$a0, 0x00200000
#	beq	$v0, $a0, tempregfail

	add	$t0, $t0, $0
	add	$t0, $t0, $t1
	add	$t0, $t0, $t2
	add	$t0, $t0, $t3
	add	$t0, $t0, $t4
	add	$t0, $t0, $t5
	add	$t0, $t0, $t6
	add	$t0, $t0, $t7
	add	$t0, $t0, $t8
	add	$t0, $t0, $t9
	li	$a0, 0x00a00000
	beq	$a0, $t0, tempregfail

tempregpass:
	la	$a0, pass
	li	$v0, 4
	syscall			#temp reg message
	j	tempregdone

tempregfail:
	la	$a0, fail
	li	$v0, 4
	syscall			#temp reg message

tempregdone:

	
	
#----------------------------------------------------------------------
#	   Print the sorted array
#----------------------------------------------------------------------

	la	$a0, N		  
	lw	$a0, 0($a0)	# pass the length of A
	la	$a1, A		# pass address of A
	la	$a2, message2   # pass address of message2
	jal	print		# call print

#----------------------------------------------------------------------
#       Sleep, then play the sorted array
#----------------------------------------------------------------------

	la	$a0, arrayAudio
	lw	$a0, 0($a0)
	beq	$a0, $0, skipplay2
	
	li	$a0, 400
	li	$v0, 32
	syscall

	la      $a0, A  
	la      $a1, N          
	lw      $a1, 0($a1)     # pass the length of A
	jal	playsounds
skipplay2:

# ---------------------------------------------------------------------
#   Exit the main procedure.
# ---------------------------------------------------------------------

ExitMain:
	lw	$ra, 0($sp)	# Restore $ra
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12	# Remove the space on the stack
	
	li	$v0, 10
	syscall





	.globl print

# ---------------------------------------------------------------------
# Procedure: print
#
# No frame, none is needed.
#
# Arguments:
#  $a0 = number of elements in A
#  $a1 = pointer to A
#  $a2 = pointer to message
#
# Returns:
#  none
#
# Register allocations:
#  none:
#
# Prints the array.
# ---------------------------------------------------------------------

print:

#----------------------------------------------------------------------
# Save arguments
#----------------------------------------------------------------------
	
	move	$t0, $a1	# initialize the ptr (start of array)
	sll	$t1, $a0, 2	# index*4
	add	$t1, $t1, $t0   # ptr + index*4 = end address

#----------------------------------------------------------------------
# Print prompt
#----------------------------------------------------------------------

	move	$a0, $a2	# store pointer to message
	li	$v0, 4		# use system call to
	syscall			# print message

#----------------------------------------------------------------------
# Print array
#----------------------------------------------------------------------

loop2:  lw	$a0, 0($t0)	# store next element
	li	$v0, 1		# use system call to
	syscall			# print the min
	la	$a0, sep	# store pointer to sep
	li	$v0, 4		# use system call to
	syscall			# print sep
	add	$t0, $t0, 4	# increment the index
	bne	$t0, $t1, loop2 # check if we've printed all the elements

#----------------------------------------------------------------------
# Print final return
#----------------------------------------------------------------------

	la	$a0, newline	# store pointer to a new line
	li	$v0, 4		# use system call to
	syscall			# print new line

# ---------------------------------------------------------------------
# Exit the print procedure.
# ---------------------------------------------------------------------

	jr	$ra		# Return



# ---------------------------------------------------------------------
# Procedure: ProcedureConventionTester
#
# Frame is 12 words long, as follows:
#  -- previous s0
#  -- previous s1
#  -- previous s2
#  -- previous s3
#  -- previous s4
#  -- previous s5
#  -- previous s6
#  -- previous s7
#  -- previous a0
#  -- previous a1
#  -- previous ra
#  -- empty
#
# Arguments:
#  $a0 - $a2 -- passed through unchanged
#
# Returns:
#  none
#
# Register allocations:
#  none:
#
# Blows away registers to test compliance with the procedure calling
#  conventions.
# ---------------------------------------------------------------------

	.data
BadArg: .asciiz "The argument values appear to be incorrect. Check a0 and a1.\n"

	.text   
	

ProcedureConventionTester:
	addi	$sp, $sp, -48	# Create a 12-word frame.
	sw	$s0,  0($sp)	# Save $s0
	sw	$s1,  4($sp)	# Save $s1
	sw	$s2,  8($sp)	# Save $s2
	sw	$s3, 12($sp)	# Save $s3
	sw	$s4, 16($sp)	# Save $s4
	sw	$s5, 20($sp)	# Save $s5
	sw	$s6, 24($sp)	# Save $s6
	sw	$s7, 28($sp)	# Save $s7
	sw	$a0, 32($sp)	# Save $a0
	sw	$a1, 36($sp)	# Save $a1
	sw	$ra, 40($sp)	# Save $ra

	la	$t0, A
	beq	$t0, $a0, A0_OK
	la	$a0, BadArg
	li	$v0, 4
	syscall
	li	$v0, 10
	syscall

A0_OK:
	li	$v0, -1
	li	$v1, -1
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

	lw	$a0, 32($sp)	# Restore $a0
	lw	$a1, 36($sp)	# Restore $a1
	jal	SwapMaxWithLast
	li	$a0, -1
	li	$a1, -1

	lw	$s0,  0($sp)	# Restore $s0
	lw	$s1,  4($sp)	# Restore $s1
	lw	$s2,  8($sp)	# Restore $s2
	lw	$s3, 12($sp)	# Restore $s3
	lw	$s4, 16($sp)	# Restore $s4
	lw	$s5, 20($sp)	# Restore $s5
	lw	$s6, 24($sp)	# Restore $s6
	lw	$s7, 28($sp)	# Restore $s7
	lw	$ra, 40($sp)	# Restore $ra
	addi	$sp, $sp, 48	# Undo the 12-word frame.

	jr	$ra



# ---------------------------------------------------------------------
#   Procedure: playsounds
#
#   No frame, none is needed.
#
#   Arguments:
#     $a0 = pointer to A
#     $a1 = number of elements in A
#
#   Returns:
#     none
#
#   Register allocations:
#     none:
#
#   Plays the array as a series of MIDI notes.
# ---------------------------------------------------------------------

playsounds:
	addi	$sp, $sp -16
	li      $t1, 0        
	sw      $t1, 0($sp)
	sw	$a0, 4($sp)
	sw	$a1, 8($sp)
	sw	$ra, 12($sp)
	beq	$a1, $0, playdone1
playloop1:
        
	lw      $t1, 0($sp)
	lw	$a0, 4($sp)
	sll 	$t1, $t1, 2
	add 	$t2, $a0, $t1 	# get address of A[i]
	lw 	$t2, 0($t2)
        
	addi	$a0, $t2, 60	#pitch
	li	$a1 100		#duration
	li	$a2 4		#instrument
	li	$a3 100		#volume
	li	$v0 33
	syscall
        
	lw      $t1, 0($sp)
	lw	$a1, 8($sp)
	add     $t1, $t1, 1
	sw      $t1, 0($sp)
	bne     $t1, $a1, playloop1
playdone1:
	lw	$ra, 12($sp)
	addi	$sp, $sp 16
	jr $ra