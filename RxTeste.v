module	RxTeste(
			//------------------------------------------------------------------
			//	Clock & Reset Inputs
			//------------------------------------------------------------------
			Clock,
			DATA_IN,
			DATA_OUT,
			CTS,
			RTS
	);


	input 			Clock;
	input           DATA_IN;
	output	[7:0]		DATA_OUT;
	input          CTS;
	output           RTS;

	parameter [7:0] modos_de_operacao = 8'b10110101;

	reg [7:0] data_out1;
	reg [7:0] state;
	reg [7:0] next;
	reg data_in1;
	reg [15:0] qtd_pacotes;
	reg [1:0] init = 2'b00;
	reg start = 0;
	reg [3:0] paridade;
	reg erro_paridade;

	assign DATA_IN = data_in1;

	reg [15:0] velocidade;
	reg [15:0] contador;

	parameter [7:0] START = 8'h00,
					D7 = 8'h01,
	 				D6 = 8'h02,
	 				D5 = 8'h03,
	 				D4 = 8'h04,
	 				D3 = 8'h05,
	 				D2 = 8'h06,
	 				D1 = 8'h07,
	 				D0 = 8'h08,
	 				PARIDADE = 8'h09,
	 				STOPBIT1 = 8'h0a,
	 				STOPTBIT2 = 8'h0b,
	 				FIM = 8'hff;

	initial begin
		contador <= 16'b0;
		state=>START;
		next => START;
		if(modos_de_operacao[7:6]==2'b00) begin
			velocidade = 10416;
		end else if(modos_de_operacao[7:6]==2'b01) begin
			velocidade = 5208;
		end else if(modos_de_operacao[7:6]==2'b10) begin
			velocidade = 2604;
		end else if(modos_de_operacao[7:6]==2'b11) begin
			velocidade = 868;
		end 
	end


	assign LCD_DATA = data_out;

	always @(posedge Clock) begin
		if(start) begin
			state <= next;
			if(contador==velocidade) begin
				contador = 0;
			end else begin
				contador <= contador + 1;
			end
		end else
			contador <=0;
		end
	end

	wire serclock = (contador == velocidade);

	always @(posedge Clock)
		case(state)
			START:	
				begin
					if(data_in1==1'b0) begin
						next <= D7;
						start <= 1'b1;
					end
				end
			D7:		
				begin	
					if(serclock) begin
						data_out1[7] <= data_in1;
						if(modos_de_operacao[0]==1 && data_in1==1) begin
							paridade <= paridade + 1;
						end
						next <=D6;
					end
				end
			D6:		
				begin	
					if(serclock) begin
						data_out1[6] <= data_in1;
						if(modos_de_operacao[0]==1 && data_in1==1) begin
							paridade <= paridade + 1;
						end
						next <=D5;
					end
				end
			D5:		
				begin
					if(serclock) begin
						data_out1[5] <= data_in1;
						if(data_in1==1) begin
							paridade <= paridade + 1;
						end
						next <=D4;
					end
				end
			D4:		
				begin	
					if(serclock) begin
						data_out1[4] <= data_in1;
						if(modos_de_operacao[0]==1 && data_in1==1) begin
							paridade <= paridade + 1;
						end
						next <=D3;
					end
				end
			D3:		
				begin
					if(serclock) begin
						data_out1[3] <= data_in1;
						if(modos_de_operacao[0]==1 && data_in1==1) begin
							paridade <= paridade + 1;
						end
						next <=D2;
					end
				end
			D2:		
				begin
					if(serclock) begin
						data_out1[2] <= data_in1;
						if(modos_de_operacao[0]==1 && data_in1==1) begin
							paridade <= paridade + 1;
						end
						next <=D1;
					end
				end
			D1:		
				begin
					if(serclock) begin
						data_out1[1] <= data_in1;
						if(modos_de_operacao[0]==1 && data_in1==1) begin
							paridade <= paridade + 1;
						end
						next <= D0;
					end
				end
			D0:	
				begin	
					if(serclock) begin
						data_out1[0] <= data_in1;
						if(modos_de_operacao[0]==1 && data_in1==1) begin
							paridade <= paridade + 1;
						end	

						if(modos_de_operacao[0]==1'b0) begin
							next <=STOPBIT1;
						end else begin
							next <=PARIDADE;
						end
					end
				end
			PARIDADE:	
				if(serclock) begin
					if(data_in1==1) being
						paridade <= paridade + 1;
					end

					if(modos_de_operacao[1]==0  && (paridade==0 || paridade==2 || paridade==4 || paridade==6 || paridade==8)) begin
						erro_paridade = 0;
					end else if(modos_de_operacao[1]==0  && (paridade==1 || paridade==3 || paridade==5 || paridade==7 || paridade==9)) begin
						erro_paridade = 0;
					end else begin
						erro_paridade = 1;
					end
					next <= STOPBIT1;
				end

			STOPBIT1:		
				begin
					if(serclock) begin
						if(modos_de_operacao[5]==1'b0) begin
							next <= STOPBIT2;
						end else begin
							next <= FIM;
						end
					end
				end
			STOPBIT2:
				begin			
					if(serclock) begin
						next <= FIM;
					end
				end
			FIM:
				//colocar algo na memoria pro crc começar

endmodule
//------------------------------------------------------------------------------
