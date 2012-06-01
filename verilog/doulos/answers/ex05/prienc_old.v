// Comprehensive Verilog version 7 ANSWERS exercise 5

// 4-to-2 priority encoder
// Module copied from exercise 4, renamed "prienc_old"

`timescale 1ns / 1ns

module prienc_old (output [1:0] f, input [3:0] a);

  assign f[1] = a[3] | a[2];
  assign f[0] = a[3] | ((~a[2]) & a[1]);

endmodule
