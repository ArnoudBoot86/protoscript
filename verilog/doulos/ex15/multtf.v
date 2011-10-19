// Comprehensive Verilog version 7 exercise 15
// Test Fixture for shift-and-add multiplier exercise

`timescale 1ns / 1ns

module test;

wire  busy;
reg  clk, reset;
wire [15:0]  f;
reg [7:0]  a;
reg [7:0]  b;

mult top(clk, reset, a[7:0], b[7:0], f[15:0], busy); 

initial
begin
	clk = 0;
	forever
		#5 clk = ~clk;
end

initial
begin 
	a = 8'b00000000; b = 8'b00000000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000000; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b00000000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000001; b = 8'b00000001; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000010; b = 8'b00000010; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000100; b = 8'b00000100; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00001000; b = 8'b00001000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00010000; b = 8'b00010000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00100000; b = 8'b00100000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b01000000; b = 8'b01000000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b10000000; b = 8'b10000000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000001; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b00000001; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000010; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b00000010; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000100; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b00000100; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00001000; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b00001000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00010000; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b00010000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00100000; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b00100000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b01000000; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b01000000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b10000000; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b10000000; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000011; b = 8'b00000011; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000111; b = 8'b00000111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00001111; b = 8'b00001111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00011111; b = 8'b00011111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00111111; b = 8'b00111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b01111111; b = 8'b01111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b11111111; b = 8'b11111111; reset = 1;
	#20 reset = 0;
	#120 a = 8'b00000000; b = 8'b00000000; reset = 1;
	#20 reset = 0;
	#120 $finish;
	end

	always @(negedge clk)
		$display ("ck%b st%b a%b b%b -> f%b, a%d b%d -> f%d busy%b",
			clk, reset, a, b, f, a, b, f, busy);

endmodule 

