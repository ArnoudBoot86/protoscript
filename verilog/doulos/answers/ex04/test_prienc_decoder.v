// Comprehensive Verilog version 7 ANSWERS exercise 4
// If You Have Time

// Test fixture for priority encoder, with Gray code stimulus
// sequence and with a decoder on the output to make it easier
// to compare output against input.

`timescale 1ns / 1ns

module test_prienc_decoder;

  // DUT connections
  //
  reg  [3:0] a;      // Binary count for stimulus
  wire [1:0] f;      // Output from encoder (device under test)
  wire [3:0] b;      // Gray-coded stimulus
  wire [3:0] g;      // Comparison output from decoder

  // Overall test control
  //
  initial begin
    // Initialise the stimulus counter
    a = 4'b0000;
    // Arrange for the test to stop at an appropriate time
    #160 $stop; $finish;
  end

  // Stimulus generator: simple binary upcount on a
  //
  always #10
    a = a + 1;

  // Gray code converter - takes binary code on a[] and
  // converts it to Gray code on b[]
  //
  xor (b[0], a[0], a[1]);
  xor (b[1], a[1], a[2]);
  xor (b[2], a[2], a[3]);
  assign b[3] = a[3];

  // Device under test - 4-to-2 priority encoder
  //
  prienc  pe (f, b);

  // Decoder (taken from Exercise 3) converts DUT output
  // back to one-hot for easy comparison with input
  //
  decoder de ( .a(f), .active_low(1'b0), .y(g) );

  // Monitoring
  //
  initial
  begin
    $timeformat(-9, 1, "ns", 7);
    $display ("   a = binary count");
    $display ("   b = Gray-coded stimulus");
    $display ("   f = DUT output");
    $display ("   g = decoded DUT output");
    $display ("|=======|====|====|==|====|");
    $display ("| time  | a  | b  |f | g  |");
    $display ("|       |3210|3210|10|3210|");
    $display ("|=======|====|====|==|====|");
    $monitor (" %t %b %b %b %b", $time, a, b, f, g);
  end

endmodule
