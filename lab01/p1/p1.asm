#
# This file contains a MIPS assembly language program that uses only the 
# following instructions:
#
#   ori  rt, rs, imm 	- Puts the bitwise OR of register rs and the
#			  immediate into register rt
#   add  rd, rs, rt	- Puts the sum of registers rs and rt into register rd.
#   syscall		- Register $v0 contains the number of the system
#			  call provided by SPIM (when $v0 contains 10,
#			  this is an exit statement).
#
# It calculates 40 + 17.
#
# It is intended to help CSSE 232 students familiarize themselves with MIPS.

	.globl main		# Make main globl so you can refer to it by name.

	.text			# Text section of the program (as opposed to data).

main:				# Program starts at main.
	ori	$t2, $0, 40	# Register $t2 gets 40
	ori	$t3, $0, 17	# Register $t3 gets 17
	add	$t3, $t2, $t3	# Register $t3 gets 40 + 17

	ori	$0, $0, 40	# Stores 40 in register $0...
	ori	$t4, $0, 0	# ... or does it?

	ori	$v0, $0, 10	# Prepare to exit
	syscall			#   ... Exit.

