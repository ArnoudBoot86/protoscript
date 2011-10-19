// Comprehensive Verilog version 7 ANSWERS exercise 1
// 2-to-1 multiplexer design "mux2"

// Corrections to the code are marked with comments
// like this   //*

module mux2 (input sel, a, b, output f);

  wire sel_n;     //* internal wires need to be declared

  assign sel_n = ~ sel;

  assign f = (a & sel_n) | (b & sel);
                      //*  |
                      //*  | missing left parenthesis before 'b'

endmodule

/*
// Alternative solution

`default_nettype none

module mux2 (input wire sel, a, b, output wire f);

  wire sel_n;     //* internal wires need to be declared

  assign sel_n = ~ sel;

  assign f = (a & sel_n) | (b & sel);
                      //*  |
                      //*  | missing left parenthesis before 'b'

endmodule
*/
