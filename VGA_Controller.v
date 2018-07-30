module VGA_Controller(
    input clock_50MHz,
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS
);

    wire inDisplayArea;
    wire [9:0] CounterX;
    reg clock = 0;
    wire hsync;
    wire vsync;
    reg [1:0] contador = 0;
    reg [3:0] r;
    reg [3:0] g;
    reg [3:0] b;

    assign VGA_HS = hsync;
    assign VGA_VS = vsync;
    assign VGA_R = r;
    assign VGA_G = g;
    assign VGA_B = b;


    always @(posedge clock_50MHz) begin
          clock = ~clock;
    end

    hvsync_generator hvsync(
        .clk(clock),
        .vga_h_sync(hsync),
        .vga_v_sync(vsync),
        .CounterX(CounterX),
        //.CounterY(CounterY),
        .inDisplayArea(inDisplayArea)
    );

    always @(posedge clock)
    begin
        if (inDisplayArea) begin
            r <= 4'b0011;
            g <= 4'b0100;
            b <= 4'b1111;
        end else begin // if it's not to display, go dark
            r <= 4'b0000;
            g <= 4'b0000;
            b <= 4'b0000;
        end
    end

endmodule
