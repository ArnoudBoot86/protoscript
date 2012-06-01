// Comprehensive Verilog version 7 ANSWERS exercise 1
// If You Have Time (2)
// Test Fixture for XOR Exercise

module xor2tf;
  reg a, b;
  wire f;

  initial
  begin
    a = 0;
    b = 0;
    #10 a = 1;
    #10 b = 1;
    #10 a = 0;
    #10 b = 0;
  end

  xor2 x (f, a, b);

  initial
    $monitor (a,,b,,f);

endmodule
