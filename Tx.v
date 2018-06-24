module	Tx(
			//------------------------------------------------------------------
			//	Clock & Reset Inputs
			//------------------------------------------------------------------
			Clock,
			CTS,
			START,
			DATA_OUT,
			RTS
	);


	input 			Clock;
	input 			CTS;
	input 			START;

	output			DATA_OUT;
	output      	RTS;

	parameter [7:0] modos_de_operacao = 8'b10110101;

	reg start;
	reg erro_paridade;
	reg data_out1;
	reg rts;
	reg enable = 1'b0;
	reg [3:0] paridade;
	reg [7:0] data = 8'h1;
	reg [7:0] state;
	reg [7:0] next;
	reg [15:0] qtd_pacotes = 16'h1;

	assign DATA_OUT = data_out1;
	assign START = start;
	assign RTS = rts;

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
		state => START;
		next => START;
		rts <=1;
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
		if(enable) begin
			state <= next;
			if(contador==velocidade) begin
				contador = 0;
			end else begin
				contador <= contador + 1;
			end
		end else begin
			state <=next;
			enable[1:0] <= 2'b11;
			contador <=0;
		end
	end

	wire serclock = (contador == velocidade);

	always @(posedge Clock and posedge cts)
		case(state)
			START:	
				begin
					if(start) begin
						data_out1 <= 1'b0;
						next <= D7;
						enable <= 1;
					end
				end
			D7:		
				begin	
					if(serclock) begin
						data_out1 <= data[7];
						if(modos_de_operacao[0]==1 && data[7]) begin
							paridade <= paridade + 1;
						end
						next <=D6;
					end
				end
			D6:		
				begin	
					if(serclock) begin
						data_out1 <= data[6];
						if(modos_de_operacao[0]==1 && data[6]) begin
							paridade <= paridade + 1;
						end
						next <=D5;
					end
				end
			D5:		
				begin
					if(serclock) begin
						data_out1 <= data[5];
						if(modos_de_operacao[0]==1 && data[6]) begin
							paridade <= paridade + 1;
						end
						next <=D4;
					end
				end
			D4:		
				begin	
					if(serclock) begin
						data_out1 <= data[4];
						if(modos_de_operacao[0]==1 && data[4]) begin
							paridade <= paridade + 1;
						end
						next <=D3;
					end
				end
			D3:		
				begin
					if(serclock) begin
						data_out1 <= data[3];
						if(modos_de_operacao[0]==1 && data[3]) begin
							paridade <= paridade + 1;
						end
						next <=D2;
					end
				end
			D2:		
				begin
					if(serclock) begin
						data_out1 <= data[2];
						if(modos_de_operacao[0]==1 && data[2]) begin
							paridade <= paridade + 1;
						end
						next <=D1;
					end
				end
			D1:		
				begin
					if(serclock) begin
						data_out1 <= data[1];
						if(modos_de_operacao[0]==1 && data[1]) begin
							paridade <= paridade + 1;
						end
						next <= D0;
					end
				end
			D0:	
				begin	
					if(serclock) begin
						data_out1 <= data[0];
						if(modos_de_operacao[0]==1 && data[0]) begin
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

					if(modos_de_operacao[1]==1  && (paridade==0 || paridade==2 || paridade==4 || paridade==6 || paridade==8)) begin
						data_out1 <= 1;
					end else if(modos_de_operacao[1]==0  && (paridade==0 || paridade==2 || paridade==4 || paridade==6 || paridade==8)) begin
						data_out1 <= 0;
					end else if(modos_de_operacao[1]==0  && (paridade==1 || paridade==3 || paridade==5 || paridade==7 || paridade==9)) begin
						data_out1 <= 1;
					end else begin
						data_out1 <= 0;
					end

					paridade <= 0;

					next <= STOPBIT1;
				end
			STOPBIT1:		
				begin
					if(serclock) begin
						data_out1 <=1;
						if(modos_de_operacao[5]==1'b0) begin
							next <= STOPBIT2;
						end else begin
							qtd_pacotes <= qtd_pacotes - 1;
							enable <= 0;
							if(qtd_pacotes==16'h0) begin
								next <=FIM;
							end else begin
								next <= START;
								//ler os próximos dados da memoria e colocar em data[]
							end
						end
					end
				end
			STOPBIT2:
				begin
					if(serclock) begin
						data_out1 <=1;
						qtd_pacotes <= qtd_pacotes - 1;
						enable <= 0;
						if(qtd_pacotes==16'h0) begin
							next <=FIM;
						end else begin
							next <= START;
							//ler os próximos dados da memoria e colocar em data[]
						end
					end
				end
			FIM:
				begin
					rts <=0;
				end

endmodule
//------------------------------------------------------------------------------
