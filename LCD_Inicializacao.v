module	LCD_Inicializacao(
			//------------------------------------------------------------------
			//	Clock & Reset Inputs
			//------------------------------------------------------------------
			Clock,
			LCD_BLINK,
			LCD_INCREMENTO,
			START,
			LCD_RS,
			LCD_EN,
			LCD_RW,
			LCD_DATA
	);

	input 			Clock;
	input			LCD_BLINK;
	input			LCD_INCREMENTO;
	input 			START;

	output			LCD_RS;
	output			LCD_EN;
	output			LCD_RW;
	output	[7:0]		LCD_DATA;

	reg			LCD_RS1;
	reg			LCD_EN1;
	reg			LCD_RW1;
	reg			blink;
	reg			incremento;

	reg 		start;

	reg [7:0] data_out;
	reg [7:0] state;
	reg [7:0] next;
	reg [7:0] next1;

	assign blink = LCD_BLINK;
	assign incremento = LCD_INCREMENTO;
	assign start = START;

	assign LCD_RS = LCD_RS1;
	assign LCD_EN = LCD_EN1;
	assign LCD_RW = LCD_RW1;
	assign LCD_DATA = data_out;


	parameter [7:0] I0 = 8'h00,
	 				I1 = 8'h01,
	 				I2 = 8'h02,
	 				I3 = 8'h03,
	 				I4 = 8'h04,
	 				FIM = 8'hff;

	initial begin
		next <= I0;
	end

	reg [20:0] count;

	always @(posedge Clock) begin
		state <= next;
	end


	always @((posedge Clock or state) and posedge start)
		case(state)
			I0:	
				begin
						count = 2000000
						next1 <=I1;
						next <= CONTADOR;
				end
			I1: 
				begin
						LCD_RS1 = 1'b0;
						LCD_RW1 = 1'b0;
 						data_out <= 8'b001111xx;
						LCD_EN1 = 1'b1;
						LCD_EN1 = 1'b0;
						count = 5000;
						next1 <=I2;
						next <= CONTADOR;
				end
			I2: 
				begin
						LCD_RS1 = 1'b0;
						LCD_RW1 = 1'b0;
						if(blink) begin
							data_out <= 8'b00001111;
						end else begin
							data_out <= 8'b00001110;
						end
						LCD_EN1 = 1'b1;
						LCD_EN1 = 1'b0;
						count = 5000;
						next1 <=I3;
						next <= CONTADOR;
				end
			I3: 
				begin	
						LCD_RS1 = 1'b0;
						LCD_RW1 = 1'b0;
						data_out <= 8'b00000001;
						LCD_EN1 = 1'b1;
						LCD_EN1 = 1'b0;
						count = 200000;
						next1 <=I4;
						next <= CONTADOR;
				end
			I4: 
				begin	
						LCD_RS1 = 1'b0;
						LCD_RW1 = 1'b0;
						if(incremento) begin
							data_out <= 8'b00000111;
						end else begin
							data_out <= 8'b00000101;
						end
						LCD_EN1 = 1'b1;
						LCD_EN1 = 1'b0;
						next <=FIM;
				end
			CONTADOR: 
				if(count!=0) begin
					count <= count - 1;
					next <= CONTADOR;
				end else
					next <= next1;
			FIM:

endmodule
//------------------------------------------------------------------------------
