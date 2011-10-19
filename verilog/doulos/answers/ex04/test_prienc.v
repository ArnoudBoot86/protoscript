// Comprehensive Verilog version 7 ANSWERS exercise 4

// Test fixture for priority encoder

`timescale 1ns / 1ns

module test_prienc;

  // DUT connections
  //
  reg  [3:0] a;      // Binary count for stimulus
  wire [1:0] f;      // DUT output

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

  // Device under test - 4-to-2 priority encoder
  //
  prienc  pe (f, a);

  // Monitoring
  //
  initial
  begin
    $timeformat(-9, 1, "ns", 7);
    $display ("   a = binary count");
    $display ("   f = DUT output");
    $display ("|=======|====|==|");
    $display ("| time  | a  |f |");
    $display ("|       |3210|10|");
    $display ("|=======|====|==|");
    $monitor (" %t %b %b", $time, a, f);
  end

endmodule
