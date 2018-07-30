.global MAIN

MAIN:
	movia r4, 0x2010
	movia r6, 0x0001
	
GET_CHAR:
	subi sp, sp, 8
	stw r5, 0(sp)
	ldwio r2, 0(r4)
	andi r5, r2, 0x8000
	bne r5, r0, RETURN_CHAR
	br GET_CHAR
RETURN_CHAR:
	andi r5, r2, 0x00ff
	stw r2, 0(r6)
	addi r6, r6, 4
	ldw r5, 0(sp)
	addi sp, sp, 8
	ret
