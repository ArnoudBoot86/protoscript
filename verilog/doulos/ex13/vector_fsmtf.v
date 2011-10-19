// Comprehensive Verilog version 7 exercise 13
// Test Fixture for Vector-file Test Fixture Exercise

`timescale 1ns / 1ns

module vector_fsmtf;

  // Connections to DUT
  reg Crystal, nSysReset;
  reg [1:2] Buttons;
  wire WatchRunning, WatchReset;


  // Test fixture control StopClock:
  //   starts false; but when test driver wants to
  //   stop the simulation, it should set StopClock=1
  //
  reg StopClock;


  // Clock
  //
  parameter Period = 10;
  //
  initial begin : ClockOscillator
    StopClock = 0;
    Crystal = 0;
    while ( !StopClock )
      #(Period/2) Crystal = !Crystal;
  end


  // Instance of device under test (DUT)
  //
  fsm F (Crystal, nSysReset, Buttons, WatchRunning, WatchReset);


  // *********** ADD YOUR CODE HERE *************
  //
  // * declare and initialise any necessary global variables
  // * open the vector file
  // * read a vector from the file, setting Finished=1 if end-of-file
  // * check output values from DUT against expected values from vector file
  // * report errors, keep count of how many vectors were applied successfully
  // * co-ordinate all this activity so that each vector in turn is
  //   applied to the DUT and checked, taking care to use sensible timing
  //   relative to the active clock edge
  //
  // Use tasks to modularise your code for each of these jobs, except
  // possibly the overall co-ordination.


endmodule
