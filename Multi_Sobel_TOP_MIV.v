module Multi_Sobel_TOP_MIV
	(
		dataa,
		datab,
		result
	);

	////////////////////////	Clock Input	 	////////////////////////
	input 	[31:0]		dataa;
	input 	[31:0]		datab;

	output 	[31:0] 		result;

	assign result = resultado;

	MultiplicacaoSobel	Mult	(	
						.dataa(			dataa),
						.datab(			datab),
						.result(		resultado));




endmodule
