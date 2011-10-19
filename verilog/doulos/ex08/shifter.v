// Comprehensive Verilog version 7 exercise 8
// Template for shifter exercise

/*
// Verilog 1995 legacy style

module shifter (Clk, EN, WR, RD, SI, SO, Data);

  parameter Length = 1;

  input Clk, EN, WR, RD, SI;
  output SO;
  inout [Length-1:0] Data;
*/

module shifter #(
    parameter Length = 1
  )(
    input Clk, EN, WR, RD, SI,
    output reg SO,
    inout [Length-1:0] Data
  );
  reg [Length-1:0] temp;
  // *********** ADD YOUR CODE HERE *************
  always @(posedge Clk) begin : blk
      if (WR)
		    temp <= Data;
		else if (EN) begin

			 temp <= temp >> 1;
			 temp[Length-1] <= SI; 
			 SO <= temp[0];
		end
  end
  
  
  assign Data = RD ? temp : {Length{1'bZ}};

endmodule
