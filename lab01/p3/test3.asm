	.globl runtests
	.data
spacer:	.word	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,00,0,0,0,0,0,0,0,0,0,0,0
spacerM:	.ascii	"testsection"
testA:	.word   1, 1, 2, 3, 3, 3, 5, 3, 7, 11, 11, 11, 13, 31, 17, 71, 19, 91, 23, 25, 29, 30, 31, 32, 37, 40, 41, 42, 43, 40, 40, 100, 121, 122
compareAmsg:	.asciiz	"Array 'A' values are unmodified "
compareHmsg:	.asciiz	"Variable 'h' value is unmodified "
compareTmsg:	.asciiz	"Variable 'total' value is correct "
compareLmsg:	.asciiz	"'total' placed after 'A' and 'h' "
newline:	.asciiz	"\n"
failmsg:	.asciiz	"[FAIL]\n"
passmsg:	.asciiz	"[PASS]\n"
		.text
        
runtests:

###	Check array A values
	la	$t0, A
	la	$t1, testA
	li	$t2, 15
	sll	$t2, $t2, 2
	li	$t3, 0			#prep test settings
	la	$a0, compareAmsg
	li	$v0, 4
	syscall				#print test name
compareAloop:
	sll	$t5, $t3, 1
	add	$t4, $t0, $t3
	add	$t5, $t1, $t5
	lw	$t4, 0($t4)
	lw	$t5, 0($t5)		#get A[i] and testA[i]
	addi	$t3, $t3, 4		#increment array index
	addi	$t6, $0, 48		#prep skip index
	beq	$t3, $t6, compareAloop	#skip one element that might have changed
	bne	$t4, $t5, printfailmsg
	bne	$t2, $t3, compareAloop	#test rest of array
	la	$a0, passmsg
	li	$v0, 4
	syscall				#print pass message


###	Check h value
	la	$a0, compareHmsg
	li	$v0, 4
	syscall				#print test name
	la	$t0, h
	la	$t1, testA
	lw	$t0, 0($t0)
	lw	$t1, 120($t1)		#load h and testh
	bne	$t0, $t1, printfailmsg	#fail if not equal
	la	$a0, passmsg
	li	$v0, 4
	syscall				#print pass message

###	Check total value
	la	$a0, compareTmsg
	li	$v0, 4
	syscall				#print test name
	la	$t0, total
	la	$t1, testA
	lw	$t0, 0($t0)
	lw	$t1, 128($t1)		#load total and testtotal
	bne	$t0, $t1, printfailmsg	#fail if not equal
	la	$a0, passmsg
	li	$v0, 4
	syscall

###	Check memory layout
	la	$t0, A
	la	$t1, testA
	li	$t2, 17
	sll	$t2, $t2, 2
	li	$t3, 0			#prep test settings
	la	$a0, compareLmsg
	li	$v0, 4
	syscall				#print test name
compareLloop:
	sll	$t5, $t3, 1
	add	$t4, $t0, $t3
	add	$t5, $t1, $t5
	lw	$t4, 0($t4)
	lw	$t5, 0($t5)		#get A[i] and testA[i]
	addi	$t3, $t3, 4		#increment array index
	addi	$t6, $0, 48		#prep skip index
	beq	$t3, $t6, compareLloop	#skip one element that might have changed
	bne	$t4, $t5, printfailmsg
	bne	$t2, $t3, compareLloop	#test rest of array
	la	$a0, passmsg
	li	$v0, 4
	syscall				#print pass message


	j testdone
	
printfailmsg:	#print failure messages
	la	$a0, failmsg
	li	$v0, 4
	syscall
	j	testdone

testdone:
	jr	$ra