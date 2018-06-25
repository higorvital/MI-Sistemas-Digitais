module	Rx(
			//------------------------------------------------------------------
			//	Clock & Reset Inputs
			//------------------------------------------------------------------
			Clock,
			DATA_IN,
			RTS,
			DATA_OUT,
			CTS,
			ERROPARIDADE
	);


	input 			Clock;
	input           DATA_IN;
	input          	RTS;

	output	[7:0]		DATA_OUT;
	output           	CTS;
	output 				ERROPARIDADE;

	parameter [7:0] modos_de_operacao = 8'b00000000;

	reg data_in1;
	reg erro_paridade;
	reg cts;
	reg rts;
	reg enable = 1'b0;

	reg [2:0] estagio = 3'b000;

	reg [3:0] paridade;

	reg [7:0] data_out1;
	reg [15:0] qtd_pacotes;
	reg [31:0] crc;

	reg [7:0] state;
	reg [7:0] next;
	reg [15:0] velocidade;
	reg [15:0] contador;

	reg [3:0] vetor_dados = 4'b111;
	reg [4:0] vetor_pacotes = 5'b1111;
	reg [5:0] vetor_crc = 6'b11111;

	wire serclock = (contador == velocidade);

	assign data_in1	 = DATA_IN;
	assign cts = CTS;

	assign DATA_OUT = data_out1;
	assign RTS = rts;
	assign ERROPARIDADE = erro_paridade;

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
		if(modos_operacao[4]==1) begin
			cts <=1;
		end else begin
			cts <=0;
		end
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
			contador <=0;
		end
	end

	always @(posedge Clock and (posedge rts or ~modo_operacao[4]))
		case(state)
			START:	
				begin
					if(data_in1==1'b0) begin
						next <= D7;
						enable <= 1;
					end
				end
			D7:		
				begin	
					if(serclock) begin
						if(estagio[2:0]==3'b000) begin
							crc[vetor_crc] <= data_in1;
							vetor_crc <= vetor_crc - 1;
						end else if(estagio[2:0]==3'b001) begin
							qtd_pacotes[vetor_pacotes] <= data_in1;
							vetor_pacotes <= vetor_pacotes - 1;
						end else begin
							data_out1[vetor_dados] <= data_in1;
							vetor_dados <= vetor_dados - 1;
							if(modos_de_operacao[0]==1 && data_in1==1) begin
								paridade <= paridade + 1;
							end
						end
						next <=D6;
					end
				end
			D6:		
				begin	
					if(serclock) begin
						if(estagio[2:0]==3'b000) begin
							crc[vetor_crc] <= data_in1;
							vetor_crc <= vetor_crc - 1;
						end else if(estagio[2:0]==3'b001) begin
							qtd_pacotes[vetor_pacotes] <= data_in1;
							vetor_pacotes <= vetor_pacotes - 1;
						end else begin
							data_out1[vetor_dados] <= data_in1;
							vetor_dados <= vetor_dados - 1;
							if(modos_de_operacao[0]==1 && data_in1==1) begin
								paridade <= paridade + 1;
							end
						end
						next <=D5;
					end
				end
			D5:		
				begin
					if(serclock) begin
						if(estagio[2:0]==3'b000) begin
							crc[vetor_crc] <= data_in1;
							vetor_crc <= vetor_crc - 1;
						end else if(estagio[2:0]==3'b001) begin
							qtd_pacotes[vetor_pacotes] <= data_in1;
							vetor_pacotes <= vetor_pacotes - 1;
						end else begin
							data_out1[vetor_dados] <= data_in1;
							vetor_dados <= vetor_dados - 1;
							if(data_in1==1) begin
								paridade <= paridade + 1;
							end
						end
						next <=D4;
					end
				end
			D4:		
				begin	
					if(serclock) begin
						if(estagio[2:0]==3'b000) begin
							crc[vetor_crc] <= data_in1;
							vetor_crc <= vetor_crc - 1;
						end else if(estagio[2:0]==3'b001) begin
							qtd_pacotes[vetor_pacotes] <= data_in1;
							vetor_pacotes <= vetor_pacotes - 1;
						end else begin
							data_out1[vetor_dados] <= data_in1;
							vetor_dados <= vetor_dados - 1;
							if(modos_de_operacao[0]==1 && data_in1==1) begin
								paridade <= paridade + 1;
							end
						end
						next <=D3;
					end
				end
			D3:		
				begin
					if(serclock) begin
						if(estagio[2:0]==3'b000) begin
							crc[vetor_crc] <= data_in1;
							vetor_crc <= vetor_crc - 1;
						end else if(estagio[2:0]==3'b001) begin
							qtd_pacotes[vetor_pacotes] <= data_in1;
							vetor_pacotes <= vetor_pacotes - 1;
						end else begin
							data_out1[vetor_dados] <= data_in1;
							vetor_dados <= vetor_dados - 1;

							if(modos_de_operacao[0]==1 && data_in1==1) begin
								paridade <= paridade + 1;
							end

							if(modos_de_operacao[3:2]==2'b00) begin
								data_out1[2] <= 1'b0;
								data_out1[1] <= 1'b0;
								data_out1[0] <= 1'b0;
								if(modos_de_operacao[0]==1'b0) begin
									next <=STOPBIT1;
								end else begin
									next <=PARIDADE;
								end
							end else begin
								next <= D2;
							end
						end
					end
				end
			D2:		
				begin
					if(serclock) begin
						if(estagio[2:0]==3'b000) begin
							crc[vetor_crc] <= data_in1;
							vetor_crc <= vetor_crc - 1;
						end else if(estagio[2:0]==3'b001) begin
							qtd_pacotes[vetor_pacotes] <= data_in1;
							vetor_pacotes <= vetor_pacotes - 1;
						end else begin
							data_out1[vetor_dados] <= data_in1;
							vetor_dados <= vetor_dados - 1;

							if(modos_de_operacao[0]==1 && data_in1==1) begin
								paridade <= paridade + 1;
							end
							
							if(modos_de_operacao[3:2]==2'b01) begin
								data_out1[1] <= 1'b0;
								data_out1[0] <= 1'b0;
								if(modos_de_operacao[0]==1'b0) begin
									next <=STOPBIT1;
								end else begin
									next <=PARIDADE;
								end
							end else begin
								next <= D1;
							end
						end
					end
				end
			D1:		
				begin
					if(serclock) begin
						if(estagio[2:0]==3'b000) begin
							crc[vetor_crc] <= data_in1;
							vetor_crc <= vetor_crc - 1;
						end else if(estagio[2:0]==3'b001) begin
							qtd_pacotes[vetor_pacotes] <= data_in1;
							vetor_pacotes <= vetor_pacotes - 1;
						end else begin
							data_out1[vetor_dados] <= data_in1;
							vetor_dados <= vetor_dados - 1;

							if(modos_de_operacao[0]==1 && data_in1==1) begin
								paridade <= paridade + 1;
							end
							
							if(modos_de_operacao[3:2]==2'b10) begin
								data_out1[0] <= 1'b0;
								if(modos_de_operacao[0]==1'b0) begin
									next <=STOPBIT1;
								end else begin
									next <=PARIDADE;
								end
							end else begin
								next <= D0;
							end
						end
					end
				end
			D0:	
				begin	
					if(serclock) begin
						if(estagio[2:0]==3'b000) begin
							crc[vetor_crc] <= data_in1;
							
							if(vetor_crc == 0) begin
								estagio[2:0] <= 3'h001;
							end else begin
								vetor_crc <= vetor_crc - 1;
							end
						end else if(estagio[2:0]==3'b001) begin
							qtd_pacotes[vetor_pacotes] <= data_in1;

							if(vetor_pacotes == 0) begin
								estagio[2:0] <= 3'b010;
							end else begin
								vetor_pacotes <= vetor_pacotes - 1;
							end
						end else begin
							data_out1[vetor_dados] <= data_in1;
							vetor_dados[3:0] <= 3'h7;

							if(modos_de_operacao[0]==1 && data_in1==1) begin
								paridade <= paridade + 1;
							end	
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

					if(modos_de_operacao[1]==1  && (paridade==0 || paridade==2 || paridade==4 || paridade==6 || paridade==8)) begin
						erro_paridade <= 1;
					end else if(modos_de_operacao[1]==0  && (paridade==1 || paridade==3 || paridade==5 || paridade==7 || paridade==9)) begin
						erro_paridade <= 1;
					end

					paridade <= 0;

					next <= STOPBIT1;
				end

			STOPBIT1:
				begin
					if(serclock) begin
						if(modos_de_operacao[5]==1'b0) begin
							next <= STOPBIT2;
						end else begin
							//mandar os 8 bits pra memoria
							next <= START;
							enable <= 0;
							if(estagio[2:0]==3'b010) begin
								estagio <= 3'b011;
							end else if(estagio[2:0]==3'b011) begin
								qtd_pacotes <= qtd_pacotes - 1;
								if(qtd_pacotes==16'b0) begin
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
						enable <= 0;
						if(estagio[2:0]==3'b010) begin
							estagio <= 3'b011;
						end else if(estagio[2:0]==3'b011) begin
							qtd_pacotes <= qtd_pacotes - 1;
							if(qtd_pacotes==16'b0) begin
								next <= FIM;
							end
						end
					end
				end
			FIM:
				begin
					cts <=0;
				end
				//colocar algo na memoria pro crc começar

endmodule
//------------------------------------------------------------------------------
