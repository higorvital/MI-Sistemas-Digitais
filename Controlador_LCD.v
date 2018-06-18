`timescale 1ns/100ps

module	Controlador_LCD(
			//------------------------------------------------------------------
			//	Clock & Reset Inputs
			//------------------------------------------------------------------
			LCD_RS,
			LCD_EN,
			LCD_RW,
			LCD_DATA
	);

	output			LCD_RS;
	output			LCD_EN;
	output			LCD_RW;
	output	[7:0]		LCD_DATA;

	parameter [31:0] crc = 32'h00000000;
	parameter teste_erro = 1'b0;

	reg			LCD_RS1;
	reg			LCD_EN1;
	reg			LCD_RW1;


	assign LCD_RS = LCD_RS1;
	assign LCD_EN = LCD_EN1;
	assign LCD_RW = LCD_RW1;

	reg [7:0] data_out;
	reg [7:0] state;


	parameter [7:0] I0 = 8'h00,
	 				I1 = 8'h01,
	 				I2 = 8'h02,
	 				I3 = 8'h03,
	 				I4 = 8'h04,
	 				I5 = 8'h05,
	 				I6 = 8'h06,
	 				I7 = 8'h07,
	 				I8 = 8'h08,
	 				D0 = 8'h0a,
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
	 				FIM = 8'hff;

	initial begin
		state=>I0;
	end

	assign LCD_DATA = data_out;

	int i = 0;

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


	always @(state)
		case(state)
			I0:			//tempo de 100us
						#100000;
						state <=I1;

			I1: 		LCD_RS1 = 1'b0;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00110000;
						//tempo de 4.1us
						#4100;
						state <=I2;

			I2: 		LCD_RS1 = 1'b0;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00110000;
						//tempo de 100us
						#100000;
						state <=I7;


			I3: 		LCD_RS1 = 1'b0;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00110000;
						//tempo de 100us
						#100000;
						state <=I4;

			I4: 		LCD_RS1 = 1'b0;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00111000;
						//tempo de 53us
						#53000;
						state <=I6;

			I5: 		LCD_RS1 = 1'b0;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00001000;
						//tempo de 53us
						#53000;
						state <=I6;

			I6: 		LCD_RS1 = 1'b0;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00000001;
						//tempo de 3ms
						state <=I7;

			I7: 		LCD_RS1 = 1'b0;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00000110;
						#53000;
						state <=I8;

			I8: 		LCD_RS1 = 1'b0;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00001100;
						//tempo de 53us
						#53000;
						state <=D0;

			D0:		i = 0;		
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
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
						#53000;
						state <=D1;
					end
			D1:		i = 4;		
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
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
						#53000;
						state <=D2;
					end
			D2:		i = 8;		
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
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
						#53000;
						state <=D3;
					end
			D3:		i = 12;		
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
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
						#53000;
						state <=D4;
					end
			D4:		i = 16;		
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
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
						#53000;
						state <=D5;
					end
			D5:		i = 20;		
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
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
						#53000;
						state <=D6;
					end
			D6:		i = 24;		
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
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
						#53000;
						state <=D7;
					end
			D7:		i = 28;		
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
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
						#53000;
						state <=T0;
					end
			T0:     
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= foo[0];
						#53000;
						state <=T1;

					end
			T1:     
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						data_out <= foo[1];
						#53000;
						state <=T2;

					end
			T2:     
					begin
						LCD_RS1 = 1'b1;
						LCD_EN1 = 1'b1;
						LCD_RW1 = 1'b0;
						begin
							if(teste_erro==1'b0) begin
								data_out <= foo[2];
							end else if(teste_erro==1'b1) begin
								data_out <= foo[3];
							end
						end
						#53000;
						state <=FIM;
					end
			FIM:


endmodule
//------------------------------------------------------------------------------
