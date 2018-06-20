
module	Rx(
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

	parameter [7:0] modos_de_operacao = 8'b00000000;

	reg [7:0] data_out1;
	reg [7:0] state;
	reg [7:0] next;
	reg data_in1;
	reg [15:0] qtd_pacotes;
	reg [1:0] init = 2'b00;

	assign DATA_IN = data_in1;

	reg [15:0] velocidade;
	reg [15:0] contador;

	parameter [7:0] START = 8'h00,
					D0 = 8'h01,
	 				D1 = 8'h02,
	 				D2 = 8'h03,
	 				D3 = 8'h04,
	 				D4 = 8'h05,
	 				D5 = 8'h06,
	 				D6 = 8'h07,
	 				D7 = 8'h08,
	 				PARIDADE = 8'h09,
	 				STOPBIT1 = 8'h0a,
	 				STOPTBIT2 = 8'h0b,
	 				FIM = 8'hff;

	initial begin
		contador <= 16'b0;
		state=>START;
		if(modos_de_operacao[7:6]==2'b00) begin
			velocidade = 50000000/4800;
		end else if(modos_de_operacao[7:6]==2'b01) begin
			velocidade = 50000000/9600;
		end else if(modos_de_operacao[7:6]==2'b10) begin
			velocidade = 50000000/19200;
		end else if(modos_de_operacao[7:6]==2'b11) begin
			velocidade = 50000000/57600;
		end 
	end


	assign LCD_DATA = data_out;

	always @(posedge Clock) begin
		state <= next;
		if(contador==velocidade) begin
			contador = 0;
		end else begin
			contador <= contador + 1;
		end
	end

	wire serclock = (contador == 0);

	always @(posedge Clock)
		case(state)
			START:	
				begin
					if(serclock) begin
						if(data_in1==1'b0) begin
							next <= D0;
						end
					end
				end
			D0:		
				begin	
					if(serclock) begin
						if(init[1:0]==2'b00) begin
							qtd_pacotes[0] <= data_in1;
						end else if(init[1:0]==2'b01) begin
							qtd_pacotes[8] <= data_in1;
						end else begin
							data_out1[0] <= data_in1;
						end
						next <=D1;
					end
				end
			D1:		
				begin	
					if(serclock) begin
						if(init[1:0]==2'b00) begin
							qtd_pacotes[1] <= data_in1;
						end else if(init[1:0]==2'b01) begin
							qtd_pacotes[9] <= data_in1;						
						end else begin
							data_out1[1] <= data_in1;
						end
						next <=D2;
					end
				end
			D2:		
				begin
					if(serclock) begin
						if(init[1:0]==2'b00) begin
							qtd_pacotes[2] <= data_in1;
						end else if(init[1:0]==2'b01) begin
							qtd_pacotes[10] <= data_in1;						
						end else begin
							data_out1[2] <= data_in1;
						end
						next <=D3;
					end
				end
			D3:		
				begin	
					if(serclock) begin
						if(init[1:0]==2'b00) begin
							qtd_pacotes[3] <= data_in1;
						end else if(init[1:0]==2'b01) begin
							qtd_pacotes[11] <= data_in1;						
						end else begin
							data_out1[3] <= data_in1;
						end
						next <=D4;
					end
				end
			D4:		
				begin
					if(serclock) begin
						if(init[1:0]==2'b00) begin
							qtd_pacotes[4] <= data_in1;
							next <=D5;
						end else if(init[1:0]==2'b01) begin
							qtd_pacotes[12] <= data_in1;						
							next <=D5;
						end else begin
							data_out1[4] <= data_in1;

							if(modos_de_operacao[3:2]==2'b00) begin
								data_out1[5] <= 1'b0;
								data_out1[6] <= 1'b0;
								data_out1[7] <= 1'b0;
								if(modos_de_operacao[0]==1'b0) begin
									next <=STOPBIT1;
								end else begin
									next <=PARIDADE;
								end
							end else begin
								next <= D5;
							end
						end
					end
				end
			D5:		
				begin
					if(serclock) begin
						if(init[1:0]==2'b00) begin
							qtd_pacotes[5] <= data_in1;
							next <=D6;
						end else if(init[1:0]==2'b01) begin
							qtd_pacotes[13] <= data_in1;						
							next <=D6;
						end else begin
							data_out1[5] <= data_in1;
							
							if(modos_de_operacao[3:2]==2'b01) begin
								data_out1[6] <= 1'b0;
								data_out1[7] <= 1'b0;
								if(modos_de_operacao[0]==1'b0) begin
									next <=STOPBIT1;
								end else begin
									next <=PARIDADE;
								end
							end else begin
								next <= D6;
							end
						end
					end
				end
			D6:		
				begin
					if(serclock) begin
						if(init[1:0]==2'b00) begin
							qtd_pacotes[6] <= data_in1;
							next <=D7;
						end else if(init[1:0]==2'b01) begin
							qtd_pacotes[14] <= data_in1;						
							next <=D7;
						end else begin
							data_out1[6] <= data_in1;
							
							if(modos_de_operacao[3:2]==2'b10) begin
								data_out1[7] <= 1'b0;
								if(modos_de_operacao[0]==1'b0) begin
									next <=STOPBIT1;
								end else begin
									next <=PARIDADE;
								end
							end else begin
								next <= D7;
							end
						end
					end
				end
			D7:	
				begin	
					if(serclock) begin
						if(init[1:0]==2'b00) begin
							qtd_pacotes[7] <= data_in1;
							init <= 2'b01;
						end else if(init[1:0]==2'b01) begin
							qtd_pacotes[15] <= data_in1;
							init <= 2'b10;
						end else begin
							data_out1[7] <= data_in1;	
						end
						
						if(modos_de_operacao[0]==1'b0) begin
							next <=STOPBIT1;
						end else begin
							next <=PARIDADE;
						end
					end
				end
			PARIDADE:	

			STOPBIT1:		
				begin
					if(serclock) begin
						if(modos_de_operacao[5]==1'b0) begin
							next <= STOPBIT2;
						end else begin
							//mandar os 8 bits pra memoria
							next <= START;
							if(init[1:0]==2'b10) begin
								init <= 2'b11;
							end else if(init[1:0]==2'b11) begin
								qtd_pacotes <= qtd_pacotes - 1;
								if(qtd_pacotes==8'b0) begin
									next <= FIM;
								end
							end
						end
					end
				end
			STOPBIT2:
				begin			
					if(serclock) begin
						//mandar os 8 bits pra memoria
						next<=START;
						if(init[1:0]==2'b10) begin
							init <= 2'b11;
						end else if(init[1:0]==2'b11) begin
							qtd_pacotes <= qtd_pacotes - 1;
							if(qtd_pacotes==8'b0) begin
								next <= FIM;
							end
						end
					end
				end
			FIM:
				//colocar algo na memoria pro crc começar

endmodule
//------------------------------------------------------------------------------
