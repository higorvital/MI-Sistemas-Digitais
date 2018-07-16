module	MultiplicacaoSobel(
			dataa,
			datab,
			result
	);


	input 	[31:0]		dataa;
	input 	[31:0]		datab;

	output 	[31:0] 		result;

	assign result = resultado;

	reg [31:0] resultado;

	always(*)
		if(datab==0) begin
			resultado = 0;
		end else if(datab==1) begin
			resultado = dataa;
		end else if(datab==2) begin
			resultado = dataa << 1;
		end else if(dataa==0) begin
			resultado = 0;
		end else if(dataa==1) begin
			resultado = datab;
		end else if(dataa==2) begin
			resultado = datab << 1;
		end


endmodule
//------------------------------------------------------------------------------
