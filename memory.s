main:
	movi r2, 2064
	
	movi r3, 5
	
	stw r3, 0(r2) #Colocando dado de r3 na posição de memoria 0x00000810
	ldw r4, 0(r2) #Pegando dado na posição de memoria 0x00000810 e colocando em r4