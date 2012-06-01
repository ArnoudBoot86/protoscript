// Comprehensive Verilog version 7 exercise 1
// 2-to-1 multiplexer design "mux2"

// THIS CODE CONTAINS ERRORS THAT DELEGATES SHOULD FIX

module mux2 (input SEL, a, b, output f);

  assign sel_n = ~ SEL;

  assign f = (a & sel_n) | (b & SEL);

endmodule
