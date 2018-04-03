main:
	movia r2, 0x00000810
	
	movi r3, 5
	
	stw r3, 0(r2)
	ldw r4, 0(r2)
