.globl main

.data
spacer:		.word	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
testcase:	.word	0, 1, 3, 6, 10, 15
testNmsg:	.asciiz	"Testing value of 'sum' for N="
test0msg:	.asciiz	"Testing N=0. This can cause infinite loops..."
compareHmsg:	.asciiz	" "
failmsg:	.asciiz	" [FAIL]\n"
passmsg:	.asciiz	" [PASS]\n"

.text
main:
	#2 word frame
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	
	#check if both tests are skipped
	la	$t0, testN
	lw	$t0, 0($t0)
	la	$t1, test0
	lw	$t1, 0($t1)
	or	$t1, $t0, $t1
	#if so, run with user N, then finish
	bne	$t1, $0, testenabled
	jal 	p4
	j	doneall
	
testenabled:
	
	#check if testn should be skipped
	la	$t0, testN
	lw	$t0, 0($t0)
	beq	$t0, $0, check0
	
	li	$t0, 5
	sw	$t0, 0($sp)
nloop:
	#print test name
	la	$a0, testNmsg
	li	$v0, 4
	syscall
	
	#print test number
	add	$a0, $t0, $0
	li	$v0, 1
	syscall
	
	#call the test program
	la	$t1, N
	sw	$t0, 0($t1)
	jal	p4
	
	#get the results and the test value
	la	$t1, Sum
	lw	$t1, 0($t1)
	
	#get goal test value
	lw	$t0, 0($sp)
	la	$t2, testcase
	sll	$t3, $t0, 2
	add	$t2, $t3, $t2
	lw	$t2, 0($t2)
	bne	$t2, $t1, failn
	
	#print pass n msg
	la	$a0, passmsg
	li	$v0, 4
	syscall
	j	nextn
failn:
	#print fail n msg
	la	$a0, failmsg
	li	$v0, 4
	syscall
	j	nextn
nextn:
	#check N needs more loops
	addi	$t0, $t0, -1
	sw	$t0, 0($sp)
	bne	$t0, $0, nloop

check0:
	#check if test0 should be skipped
	la	$t0, test0
	lw	$t0, 0($t0)
	beq	$t0, $0, doneall
	
	#print test name
	la	$a0, test0msg
	li	$v0, 4
	syscall
	
	#call test program for test case 0
	la	$t1, N
	sw	$0, 0($t1)
	jal	p4
	
	la	$t1, Sum
	lw	$t1, 0($t1)
	bne	$0, $t1, fail0
	
	#print pass 0 msg
	la	$a0, passmsg
	li	$v0, 4
	syscall
	j	doneall
fail0:
	#print fail 0 msg
	la	$a0, failmsg
	li	$v0, 4
	syscall
	
doneall:
	#restore values and exit
	lw	$ra, 4($sp)
	addi	$sp, $sp, 8
	li	$v0, 10
	syscall
