// Comprehensive Verilog version 7 exercise 6
// Template for MinMax circuit

`timescale 1ns / 1ns

module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output reg [3:0] Z
  );

  // *********** ADD YOUR CODE HERE *************
  always @* begin
      case (Min0Max1)
		    1'b1 : begin
			     if (X > Y)
				      Z = X;
				  else
				      Z = Y; 
			 end
			 1'b0 : begin
			     if (X > Y)
				      Z = Y;
				  else
				      Z = X;
			 end
		endcase
  end

endmodule
