// Comprehensive Verilog version 7 ANSWERS exercise 1
// If You Have Time (2)

// 2-input NAND gate

// Note: module can't be named "nand" as this clashes
// with the name of a built-in Verilog primitive

module nand2 (output f, input a, b);
  assign f = ~(a & b);
endmodule
