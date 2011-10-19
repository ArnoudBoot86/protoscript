// Comprehensive Verilog version 7 exercise 7

// Up/down counter

`timescale 1ns/1ns

module updownCounter (
    input Clock, Reset, Enable, Load, Up1Dn0,
    input  [7:0] Data,
    output reg [7:0] Q
  );

  // *********** ADD YOUR CODE HERE *************
  always @(posedge Clock or posedge Reset) begin : blk
      if (Reset)
		    Q <= 0;
		else begin
		    if (Enable) begin
			     if (Load)
				      Q <= Data;
				  else begin
                  case (Up1Dn0)
                      1'b1: Q <= Q + 1;
                      1'b0: Q <= Q - 1;
                  endcase
				  end
	       end					  
	   end
	end
endmodule

