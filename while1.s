main:
	movi r1, 5
	movi r2, 0
loop:
	addi r2, r2, 1
	bgt r1, r2, loop