main:
	movhi r2, %hi(3254779904)
	
	movi r3, 32767
	addi r3, r3, 32767
	addi r3, r3, 1
	andi r3, r3, %lo(2390753280)
	
	or r3, r3, r2 #Mensagem de 32 bits completa
	
	movi r4, 32 #Qtd de vezes que o loop deve ser realizado
	movi r5, 0 #Contador
	
	movi r6, 1 #Numero de bits que devem ser deslocados a cada iteração
	
	movhi r7, %hi(2390753280) #Polinomio de 9 bits

	loop:
		beq r4, r5, end #Contador chegar a 32, para
		addi r5, r5, 1 #Incrementando contador
		blt r3, r0, calculo #Se a mensagem for negativa, fazer a xor
		volta1:	
		rol r3, r3, r6 #Desloca um bit	
		br loop
calculo:
	xor r3, r3, r7
	br volta1
end:
	movi r4, 24 #Qtd de vezes que o loop deve ser realizado
	movi r5, 0 #Contador
		
	loop2:
		beq r4, r5, end2 #Contador chegar a 24, para
		addi r5, r5, 1 #Incrementando contador
		ror r3, r3, r6 #Desloca um bit
		br loop2
end2:
