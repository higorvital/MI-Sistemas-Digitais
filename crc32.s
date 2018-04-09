main:
	movia r3, 0b10101010101010101010101010101010 #Registrador onde será feito o calculo
	movia r5, 0b10101010101010101010101010101010 #Registrador que contém o resto da mensagem

	movi r8, 2 #Quantidade de registradores
		
	movi r4, 32 #Qtd de bits de cada registrador
	
	movia r7, 0b10000001010000010100000110101011 #Polinomio de 32 bits

	loop:
		beq r4, r0, resetar #Contador chegar a 0, reseta ou para
		volta1:
		subi r4, r4, 1 #Decrementando contador
		blt r3, r0, calculo #Se a mensagem for negativa, fazer a xor
		slli r3, r3, 1 #Desloca um bit registrador principal
		bge r5, r0, volta2
		ori r3, r3, 1
		volta2:	
		slli r5, r5, 1 #Desloca um bit registrador auxiliar
		volta3: #Ponto de retorno do calculo da xor
		br loop
resetar:
	movi r4, 32 
	subi r8, r8, 1 #Diminui a qtd de registradores restantes
	beq r8, r0, end #Se n tem mais registradores, para
	br volta1
calculo:
	slli r3, r3, 1 #Desloca um bit	registrador principal
	bge r5, r0, volta4
	ori r3, r3, 1
	volta4:
	slli r5, r5, 1 #Desloca um bit registrador auxiliar
	xor r3, r3, r7
	br volta3
end:
