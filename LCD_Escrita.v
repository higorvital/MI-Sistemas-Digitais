		module	LCD_Escrita(
				//------------------------------------------------------------------
				//	Clock & Reset Inputs
				//------------------------------------------------------------------
				Clock,
				START,
				LCD_RS,
				LCD_EN,
				LCD_RW,
				LCD_DATA
		);

		input 			Clock;
		input 			START;

		output			LCD_RS;
		output			LCD_EN;
		output			LCD_RW;
		output	[7:0]		LCD_DATA;

		parameter [31:0] crc = 32'h00000000;
		parameter teste_erro = 1'b0;

		reg			LCD_RS1;
		reg			LCD_EN1;
		reg			LCD_RW1;
		reg 		start;

		assign start = START;

		assign LCD_RS = LCD_RS1;
		assign LCD_EN = LCD_EN1;
		assign LCD_RW = LCD_RW1;
		assign LCD_DATA = data_out;


		reg [7:0] data_out;
		reg [7:0] state;
		reg [7:0] next;


		parameter [7:0] D0 = 8'h0a,
		 				D1 = 8'h0b,
		 				D2 = 8'h0c,
		 				D3 = 8'h0d,
		 				D4 = 8'h0e,
		 				D5 = 8'h0f,
		 				D6 = 8'h10,
		 				D7 = 8'h11,
		 				T0 = 8'h12,
		 				T1 = 8'h13,
		 				T2 = 8'h14,
		 				ESPACO = 8'hfe,
		 				FIM = 8'hff;

		reg [4:0] i = 5'b0;

		initial begin
			i = 0;
			next <= D0;
		end

		always @(posedge Clock) begin
			state <= next;
		end


		wire [7:0] foo [0:15];
		wire [7:0] foo2 [0:4];

		assign foo[0]  = "0";
		assign foo[1]  = "1";
		assign foo[2]  = "2";
		assign foo[3]  = "3";
		assign foo[4]  = "4";
		assign foo[5]  = "5";
		assign foo[6]  = "6";
		assign foo[7]  = "7";
		assign foo[8]  = "8";
		assign foo[9]  = "9";
		assign foo[10] = "A";
		assign foo[11] = "B";
		assign foo[12] = "C";
		assign foo[13] = "D";
		assign foo[14] = "E";
		assign foo[15] = "F";
		assign foo2[0] = ":";
		assign foo2[1] = "-";
		assign foo2[2] = "(";
		assign foo2[3] = ")";
		assign foo2[4] = " ";


		always @(state and posedge start)
			case(state)
				D0:	
					begin	
						i = 0;		
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
						
							if(crc[i+3:i]==4'h0) begin
								data_out <=foo[0];
							end else if(crc[i+3:i]==4'h1) begin
								data_out <=foo[1];
							end else if(crc[i+3:i]==4'h2) begin
								data_out <=foo[2];
							end else if(crc[i+3:i]==4'h3) begin
								data_out <=foo[3];
							end else if(crc[i+3:i]==4'h4) begin
								data_out <=foo[4];
							end else if(crc[i+3:i]==4'h5) begin
								data_out <=foo[5];
							end else if(crc[i+3:i]==4'h6) begin
								data_out <=foo[6];
							end else if(crc[i+3:i]==4'h7) begin
								data_out <=foo[7];
							end else if(crc[i+3:i]==4'h8) begin
								data_out <=foo[8];
							end else if(crc[i+3:i]==4'h9) begin
								data_out <=foo[9];
							end else if(crc[i+3:i]==4'ha) begin
								data_out <=foo[10];
							end else if(crc[i+3:i]==4'hb) begin
								data_out <=foo[11];
							end else if(crc[i+3:i]==4'hc) begin
								data_out <=foo[12];
							end else if(crc[i+3:i]==4'hd) begin
								data_out <=foo[13];
							end else if(crc[i+3:i]==4'he) begin
								data_out <=foo[14];
							end else if(crc[i+3:i]==4'hf) begin
								data_out <=foo[15];
							end 
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next <=D1;
						end
					end
				D1:	
					begin	
						i = 4;		
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
						
							if(crc[i+3:i]==4'h0) begin
								data_out <=foo[0];
							end else if(crc[i+3:i]==4'h1) begin
								data_out <=foo[1];
							end else if(crc[i+3:i]==4'h2) begin
								data_out <=foo[2];
							end else if(crc[i+3:i]==4'h3) begin
								data_out <=foo[3];
							end else if(crc[i+3:i]==4'h4) begin
								data_out <=foo[4];
							end else if(crc[i+3:i]==4'h5) begin
								data_out <=foo[5];
							end else if(crc[i+3:i]==4'h6) begin
								data_out <=foo[6];
							end else if(crc[i+3:i]==4'h7) begin
								data_out <=foo[7];
							end else if(crc[i+3:i]==4'h8) begin
								data_out <=foo[8];
							end else if(crc[i+3:i]==4'h9) begin
								data_out <=foo[9];
							end else if(crc[i+3:i]==4'ha) begin
								data_out <=foo[10];
							end else if(crc[i+3:i]==4'hb) begin
								data_out <=foo[11];
							end else if(crc[i+3:i]==4'hc) begin
								data_out <=foo[12];
							end else if(crc[i+3:i]==4'hd) begin
								data_out <=foo[13];
							end else if(crc[i+3:i]==4'he) begin
								data_out <=foo[14];
							end else if(crc[i+3:i]==4'hf) begin
								data_out <=foo[15];
							end 
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next <=D2;
						end
					end
				D2:	
					begin	
						i = 8;		
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
						
							if(crc[i+3:i]==4'h0) begin
								data_out <=foo[0];
							end else if(crc[i+3:i]==4'h1) begin
								data_out <=foo[1];
							end else if(crc[i+3:i]==4'h2) begin
								data_out <=foo[2];
							end else if(crc[i+3:i]==4'h3) begin
								data_out <=foo[3];
							end else if(crc[i+3:i]==4'h4) begin
								data_out <=foo[4];
							end else if(crc[i+3:i]==4'h5) begin
								data_out <=foo[5];
							end else if(crc[i+3:i]==4'h6) begin
								data_out <=foo[6];
							end else if(crc[i+3:i]==4'h7) begin
								data_out <=foo[7];
							end else if(crc[i+3:i]==4'h8) begin
								data_out <=foo[8];
							end else if(crc[i+3:i]==4'h9) begin
								data_out <=foo[9];
							end else if(crc[i+3:i]==4'ha) begin
								data_out <=foo[10];
							end else if(crc[i+3:i]==4'hb) begin
								data_out <=foo[11];
							end else if(crc[i+3:i]==4'hc) begin
								data_out <=foo[12];
							end else if(crc[i+3:i]==4'hd) begin
								data_out <=foo[13];
							end else if(crc[i+3:i]==4'he) begin
								data_out <=foo[14];
							end else if(crc[i+3:i]==4'hf) begin
								data_out <=foo[15];
							end 
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next <=D3;
						end
					end
				D3:	
					begin	
						i = 12;		
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
						
							if(crc[i+3:i]==4'h0) begin
								data_out <=foo[0];
							end else if(crc[i+3:i]==4'h1) begin
								data_out <=foo[1];
							end else if(crc[i+3:i]==4'h2) begin
								data_out <=foo[2];
							end else if(crc[i+3:i]==4'h3) begin
								data_out <=foo[3];
							end else if(crc[i+3:i]==4'h4) begin
								data_out <=foo[4];
							end else if(crc[i+3:i]==4'h5) begin
								data_out <=foo[5];
							end else if(crc[i+3:i]==4'h6) begin
								data_out <=foo[6];
							end else if(crc[i+3:i]==4'h7) begin
								data_out <=foo[7];
							end else if(crc[i+3:i]==4'h8) begin
								data_out <=foo[8];
							end else if(crc[i+3:i]==4'h9) begin
								data_out <=foo[9];
							end else if(crc[i+3:i]==4'ha) begin
								data_out <=foo[10];
							end else if(crc[i+3:i]==4'hb) begin
								data_out <=foo[11];
							end else if(crc[i+3:i]==4'hc) begin
								data_out <=foo[12];
							end else if(crc[i+3:i]==4'hd) begin
								data_out <=foo[13];
							end else if(crc[i+3:i]==4'he) begin
								data_out <=foo[14];
							end else if(crc[i+3:i]==4'hf) begin
								data_out <=foo[15];
							end 
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next<=D4;
						end
					end
				D4:	
					begin
						i = 16;		
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
						
							if(crc[i+3:i]==4'h0) begin
								data_out <=foo[0];
							end else if(crc[i+3:i]==4'h1) begin
								data_out <=foo[1];
							end else if(crc[i+3:i]==4'h2) begin
								data_out <=foo[2];
							end else if(crc[i+3:i]==4'h3) begin
								data_out <=foo[3];
							end else if(crc[i+3:i]==4'h4) begin
								data_out <=foo[4];
							end else if(crc[i+3:i]==4'h5) begin
								data_out <=foo[5];
							end else if(crc[i+3:i]==4'h6) begin
								data_out <=foo[6];
							end else if(crc[i+3:i]==4'h7) begin
								data_out <=foo[7];
							end else if(crc[i+3:i]==4'h8) begin
								data_out <=foo[8];
							end else if(crc[i+3:i]==4'h9) begin
								data_out <=foo[9];
							end else if(crc[i+3:i]==4'ha) begin
								data_out <=foo[10];
							end else if(crc[i+3:i]==4'hb) begin
								data_out <=foo[11];
							end else if(crc[i+3:i]==4'hc) begin
								data_out <=foo[12];
							end else if(crc[i+3:i]==4'hd) begin
								data_out <=foo[13];
							end else if(crc[i+3:i]==4'he) begin
								data_out <=foo[14];
							end else if(crc[i+3:i]==4'hf) begin
								data_out <=foo[15];
							end 
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next<=D5;
						end
					end
				D5:	
					begin	
						i = 20;		
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
						
							if(crc[i+3:i]==4'h0) begin
								data_out <=foo[0];
							end else if(crc[i+3:i]==4'h1) begin
								data_out <=foo[1];
							end else if(crc[i+3:i]==4'h2) begin
								data_out <=foo[2];
							end else if(crc[i+3:i]==4'h3) begin
								data_out <=foo[3];
							end else if(crc[i+3:i]==4'h4) begin
								data_out <=foo[4];
							end else if(crc[i+3:i]==4'h5) begin
								data_out <=foo[5];
							end else if(crc[i+3:i]==4'h6) begin
								data_out <=foo[6];
							end else if(crc[i+3:i]==4'h7) begin
								data_out <=foo[7];
							end else if(crc[i+3:i]==4'h8) begin
								data_out <=foo[8];
							end else if(crc[i+3:i]==4'h9) begin
								data_out <=foo[9];
							end else if(crc[i+3:i]==4'ha) begin
								data_out <=foo[10];
							end else if(crc[i+3:i]==4'hb) begin
								data_out <=foo[11];
							end else if(crc[i+3:i]==4'hc) begin
								data_out <=foo[12];
							end else if(crc[i+3:i]==4'hd) begin
								data_out <=foo[13];
							end else if(crc[i+3:i]==4'he) begin
								data_out <=foo[14];
							end else if(crc[i+3:i]==4'hf) begin
								data_out <=foo[15];
							end 
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next <=D6;
						end
					end
				D6:	
					begin	
						i = 24;		
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
						
							if(crc[i+3:i]==4'h0) begin
								data_out <=foo[0];
							end else if(crc[i+3:i]==4'h1) begin
								data_out <=foo[1];
							end else if(crc[i+3:i]==4'h2) begin
								data_out <=foo[2];
							end else if(crc[i+3:i]==4'h3) begin
								data_out <=foo[3];
							end else if(crc[i+3:i]==4'h4) begin
								data_out <=foo[4];
							end else if(crc[i+3:i]==4'h5) begin
								data_out <=foo[5];
							end else if(crc[i+3:i]==4'h6) begin
								data_out <=foo[6];
							end else if(crc[i+3:i]==4'h7) begin
								data_out <=foo[7];
							end else if(crc[i+3:i]==4'h8) begin
								data_out <=foo[8];
							end else if(crc[i+3:i]==4'h9) begin
								data_out <=foo[9];
							end else if(crc[i+3:i]==4'ha) begin
								data_out <=foo[10];
							end else if(crc[i+3:i]==4'hb) begin
								data_out <=foo[11];
							end else if(crc[i+3:i]==4'hc) begin
								data_out <=foo[12];
							end else if(crc[i+3:i]==4'hd) begin
								data_out <=foo[13];
							end else if(crc[i+3:i]==4'he) begin
								data_out <=foo[14];
							end else if(crc[i+3:i]==4'hf) begin
								data_out <=foo[15];
							end 
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next <=D7;
						end
					end
				D7:	
					begin	
						i = 28;		
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
						
							if(crc[i+3:i]==4'h0) begin
								data_out <=foo[0];
							end else if(crc[i+3:i]==4'h1) begin
								data_out <=foo[1];
							end else if(crc[i+3:i]==4'h2) begin
								data_out <=foo[2];
							end else if(crc[i+3:i]==4'h3) begin
								data_out <=foo[3];
							end else if(crc[i+3:i]==4'h4) begin
								data_out <=foo[4];
							end else if(crc[i+3:i]==4'h5) begin
								data_out <=foo[5];
							end else if(crc[i+3:i]==4'h6) begin
								data_out <=foo[6];
							end else if(crc[i+3:i]==4'h7) begin
								data_out <=foo[7];
							end else if(crc[i+3:i]==4'h8) begin
								data_out <=foo[8];
							end else if(crc[i+3:i]==4'h9) begin
								data_out <=foo[9];
							end else if(crc[i+3:i]==4'ha) begin
								data_out <=foo[10];
							end else if(crc[i+3:i]==4'hb) begin
								data_out <=foo[11];
							end else if(crc[i+3:i]==4'hc) begin
								data_out <=foo[12];
							end else if(crc[i+3:i]==4'hd) begin
								data_out <=foo[13];
							end else if(crc[i+3:i]==4'he) begin
								data_out <=foo[14];
							end else if(crc[i+3:i]==4'hf) begin
								data_out <=foo[15];
							end 
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next<=ESPACO;
						end
					end
				T0: 
					begin   
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
							data_out <= foo[0];
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next <=T1;

						end
					end
				T1: 
					begin    
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
							data_out <= foo[1];
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next <=T2;
						end
					end
				T2: 
					begin    
						begin
							LCD_RS1 = 1'b1;
							LCD_RW1 = 1'b0;
							begin
								if(teste_erro==1'b0) begin
									data_out <= foo[2];
								end else if(teste_erro==1'b1) begin
									data_out <= foo[3];
								end
							end
							LCD_EN1 = 1'b1;
							LCD_EN1 = 1'b0;
							next <=FIM;
						end
					end
				ESPACO:
					begin 
						LCD_RS1 = 1'b0;
						LCD_RW1 = 1'b0;
						data_out <= foo2[4];
						LCD_EN1 = 1'b1;
						LCD_EN1 = 1'b0;
						next <=T0;
					end
				FIM:

	endmodule
	//------------------------------------------------------------------------------
