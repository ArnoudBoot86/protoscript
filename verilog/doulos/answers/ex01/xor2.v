// Comprehensive Verilog version 7 ANSWERS exercise 1
// If You Have Time (2)

// XOR gate built from four NANDs

module xor2 (output f, input a, b);
  nand2 g1 (n1, a, b);
  nand2 g2 (n2, a, n1);
  nand2 g3 (n3, b, n1);
  nand2 g4 (f, n2, n3);
endmodule
