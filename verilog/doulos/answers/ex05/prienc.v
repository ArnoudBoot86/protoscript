// Comprehensive Verilog version 7 ANSWERS exercise 5

// Priority encoder using if...else if

`timescale 1ns / 1ns

module prienc (output reg [1:0] f, input [3:0] a);

  always @(a)
    if ( a[3] )
      f = 2'd3;
    else if ( a[2] )
      f = 2'd2;
    else if ( a[1] )
      f = 2'd1;
    else
      f = 2'd0;

endmodule
