// Comprehensive Verilog version 7 exercise 4

// 4-to-2 priority encoder

`timescale 1ns / 1ns

module prienc (output reg [1:0] f, input [3:0] a);

  // ADD YOUR CODE HERE
  always @* begin
		if (a[3])
		    f = 2'b11;
		else if (a[2])
		    f = 2'b10;
		else if (a[1])
		    f = 2'b01;
		else
		    f = 2'b00;
  end
		
endmodule
