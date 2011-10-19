// Comprehensive Verilog version 7 ANSWERS exercise 4
// If You Have Time

// 2-to-4-line decoder with programmable output polarity

// Copied from exercise 3 and modified to have a timescale

`timescale 1ns/1ns

module decoder ( input [1:0] a, input active_low, output [3:0] y );

  wire [3:0] internal_y;

  assign internal_y[3] =  a[1] &  a[0];  // 11
  assign internal_y[2] =  a[1] & ~a[0];  // 10
  assign internal_y[1] = ~a[1] &  a[0];  // 01
  assign internal_y[0] = ~a[1] & ~a[0];  // 00

  // Active-low functionality

  // could be implemented as continuous-assign...
  //
  assign y[3] = internal_y[3] ^ active_low;

  // ...or by instantiating XOR primitives...
  //
  xor  (y[2], internal_y[2], active_low),
       (y[1], internal_y[1], active_low),
       (y[0], internal_y[0], active_low);

endmodule
