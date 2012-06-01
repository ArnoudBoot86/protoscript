// Comprehensive Verilog version 7 exercise 11
//
// Skeleton test bench for Part 1 (no tasks)

`timescale 1ns/1ns

module RamChipTF;

  
  // use parameters to define constants for timing, word size etc etc
  // *********** ADD YOUR CODE HERE *************
  parameter WordSize = 8, 
            AddressSize = 8;

  wire [WordSize-1:0] data;
  reg [WordSize-1:0] tmpdata;
  reg [AddressSize-1:0] address;
  reg ncs, noe, nwe;
  // Connections to memory model
  //
  // *********** ADD YOUR CODE HERE *************
  RamChip #(AddressSize,WordSize) dut (.Address(address),
               .Data(data),
					.nCS(ncs),
               .nOE(noe),
					.nWE(nwe));


  // Instance of memory model
  //
  // *********** ADD YOUR CODE HERE *************


  // Procedural code to perform tests as specified in
  // Part 1 of the workbook
  //
  // *********** ADD YOUR CODE HERE *************
  // Write 10101010 to address 0
  initial begin #10
      $display("Writing 10101010 to address 0");
      address = 1'b0;
		tmpdata = 1'b0;
		ncs = 1'b1;
		nwe = 1'b1;
		noe = 1'b1;
		#10
		tmpdata = 'b10101010;
		ncs = 1'b0;
		#10
		nwe = 1'b0;
		#10
		nwe = 1'b1;
		#10
		ncs = 1'b1;
		tmpdata = 'bZ;
		address = 'b0;
		#10
		$display("Reading data from address 0");
		ncs = 1'b0;
		address = 1'b0;
		#10
		noe = 1'b0;
		#10
		noe = 1'b1;
		#10
		ncs = 1'b1;
  end
  
  assign data = tmpdata;
  
  endmodule
