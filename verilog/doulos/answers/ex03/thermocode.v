// Comprehensive Verilog version 7 ANSWERS exercise 3

// 3-to-4-line thermometer code decoder with programmable output polarity


module thermocode (

  input  [2:0] a,
  input        active_low,
  output [3:0] y,
  output       valid );

  wire [3:0] internal_y;

  assign internal_y[3] =  a[2] &  a[1] &  a[0];  // 111
  assign internal_y[2] = ~a[2] &  a[1] &  a[0];  // 011
  assign internal_y[1] = ~a[2] & ~a[1] &  a[0];  // 001
  assign internal_y[0] = ~a[2] & ~a[1] & ~a[0];  // 000

  assign valid = internal_y[3] | internal_y[2] | internal_y[1] | internal_y[0];

  // Active-low functionality
  //
  assign y[3] = internal_y[3] ^ active_low;
  assign y[2] = internal_y[2] ^ active_low;
  assign y[1] = internal_y[1] ^ active_low;
  assign y[0] = internal_y[0] ^ active_low;

endmodule
