.globl main

.data
spacer:		.word	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
testmsg1:	.asciiz	"Max is at end of array"
testmsg2:	.asciiz	"Non-max array contents correct"
testmsg_temp:	.asciiz	"Array contents correct"
failmsg:	.asciiz	" [FAIL]\n"
passmsg:	.asciiz	" [PASS]\n"

.text
main:
	#2 word frame
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)

### Using malloc to backup array would be a more robust way to test...
#	#malloc space for backup
#	la	$a0, N
#	lw	$a0, 0($a0)
#	sll	$a0, $a0, 2
#	la	$v0, 9
#	syscall
#	
#	#backup array
#	la	$t1, A
#	li	$t0, 0
#copyloop:
#	beq	$t0, $a0, copydone
#	add	$t4, $t1, $t0
#	lw	$t4, 0($t4)
#	add	$t5, $v0, $t0
#	sw	$t4, 0($t5)
#	addi	$t0, $t0, 4
#	j	copyloop
#copydone:
	
	jal	p5
	
#	#get last
#	#get max

	la	$a0, testmsg_temp
	li	$v0, 4
	syscall
	
	# simple easy array test
	testarray:
	la	$t0, A
	add	$t1, $0, $0

	lw	$t1, 0($t0)
	addi	$t1, $t1, -32
	bne	$t1, $0, testfail
	lw	$t1, 4($t0)
	addi	$t1, $t1, -16
	bne	$t1, $0, testfail
	lw	$t1, 8($t0)
	addi	$t1, $t1, -64
	bne	$t1, $0, testfail
	lw	$t1, 12($t0)
	addi	$t1, $t1, -48
	bne	$t1, $0, testfail
	lw	$t1, 16($t0)
	addi	$t1, $t1, -80
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
	#restore values and exit
	lw	$ra, 4($sp)
	addi	$sp, $sp, 8
	li	$v0, 10
	syscall
