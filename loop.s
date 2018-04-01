main:
	movi r1, 5
	movi r2, 0
loop:
	bgt r2, r1, end
	addi r2, r2, 1
	br loop
end: