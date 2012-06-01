// Comprehensive Verilog version 7 exercise 11
//
// Template for behavioural model of SRAM device

`timescale 1ns/1ns

module RamChip #(
    parameter AddressSize = 1,
    parameter WordSize = 1
  )(
    input [AddressSize-1:0] Address,
    inout [WordSize-1:0] Data,
    input nCS, nWE, nOE
  );
 
    // Create memory
	 reg [WordSize-1:0] mem [AddressSize-1:0];
	 reg [WordSize-1:0] tempout;
	 
	 always @* begin 
	     if ( (nWE == 0) && (nCS == 0) ) begin
		      mem[Address] = Data;
		  end
		  if ( (nCS == 0) && (nOE == 0) ) begin
		      tempout = mem[Address];
		  end
		  else tempout = 'bZ;
	 end
	 
	 assign Data = tempout;

endmodule

