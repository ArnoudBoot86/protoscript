// Comprehensive Verilog version 7 exercise 10

// Template for ALU Exercise

`timescale 1ns/1ns

module alu (
    input Clock,
    input signed [7:0] A, B,
    input [3:0] Op,
    output reg signed [7:0] F,
    output reg Cout, Equal
  );
  reg signed [7:0] tempf;


  // Handle synchronous part
  always @(posedge Clock) begin
      F <= tempf;
  end

  // Handle asynchronous part
  always @* begin : async
      if (A == B)
		    Equal = 1'b1;
		else
		    Equal = 1'b0;
		case (Op)
		    4'b0 : {Cout, tempf} = A + B;
			 4'b1 : {Cout, tempf} = A - B;
			 4'b10 : {Cout, tempf} = B - A;
			 4'b0100 : {Cout, tempf} = {A[7], A};
			 4'b0101 : {Cout, tempf} = {B[7], B};
			 4'b0110 : {Cout, tempf} =  -A;
			 4'b0111 : {Cout, tempf} =  -B;
			 4'b1000 : {Cout, tempf} = {A[7],A[6:0],1'b0}; // Left shift
			 4'b1001 : {Cout, tempf} = {1'b0,1'b0,A[7:1]}; // Right shift
			 4'b1010 : {Cout, tempf} = {A[7:0],A[7]}; // Rotate left
			 4'b1011 : {Cout, tempf} = {1'b0,A[0],A[7:1]}; // Rotate right
			 4'b1110 : {Cout, tempf} = 0;
			 4'b1111 : {Cout, tempf} = -1;
			 default : {Cout, tempf} = 0; // Default sets output to zero
		endcase
  end

endmodule

