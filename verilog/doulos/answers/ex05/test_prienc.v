// Comprehensive Verilog version 7 ANSWERS exercise 5

`timescale 1ns / 1ns

// Test bench for priority encoder, with comparison
// of results from two different versions

module test_prienc;

  // DUT connections
  //
  reg  [3:0] a;             // Binary count for stimulus
  wire [1:0] f_new, f_old;  // DUT outputs
  wire [1:0] f_error;       // Comparison result

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

  // Devices under test - two versions of 4-to-2 priority encoder
  //
  prienc     new ( .f(f_new), .a(a) );
  prienc_old old ( .f(f_old), .a(a) );

  // Check for differences between old and new outputs
  xor ( f_error[1], f_new[1], f_old[1] );
  xor ( f_error[0], f_new[0], f_old[0] );

  // Monitoring
  //
  initial
  begin
    $timeformat(-9, 1, "ns", 7);
    $display ("|=======|====|=====|=====|=======|");
    $display ("| time  | a  |f_old|f_new|f_error|");
    $display ("|       |3210|  10 |  10 |   10  |");
    $display ("|=======|====|=====|=====|=======|");
    $monitor (" %t %b   %b    %b     %b ",
                 $time,    a,f_old,f_new,f_error);
  end

endmodule
