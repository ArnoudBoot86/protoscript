// Comprehensive Verilog version 7 ANSWERS exercise 15
// Solution to shift-and-add multiplier exercise

`timescale 1ns / 1ns

module mult(
    input clk, reset,
    input [7:0] a, b,
    output reg [15:0] f,
    output wire busy
  );

	reg [7:0] ia;
	reg [2:0] cnt;
	reg cout;

	always @(posedge clk)
	begin
		if (reset)
		begin
			ia = a;
			if (b[0])
				f = {1'b0, a, b[7:1]};
			else
				f = {9'b0, b[7:1]};
			cnt = 7;
		end
		else if (busy)
		begin
			if (f[0])
				{cout,f[15:8]} = f[15:8] + ia;
			else
				cout = 0;
                        f = {cout,f} >> 1;
			cnt = cnt - 1;
		end
	end

	assign busy = (cnt != 0);
endmodule
