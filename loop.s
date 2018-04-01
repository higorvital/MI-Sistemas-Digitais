main:
	movi r1, 5
	movi r2, 0
loop:
	bgt r2, r1, end
	addi r2, r2, 1
	br loop
<<<<<<< HEAD:while1.s
end:
=======
end:
>>>>>>> d9612e42ba23e6d56f63ca6bcca0e2924d8241e5:loop.s
