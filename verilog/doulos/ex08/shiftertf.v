// Comprehensive Verilog version 7 exercise 8
// Test fixture for shifter exercise

module shiftertf;

  // DUT connections
  //
  reg Clk, EN, WR, RD, SI;
  wire SO;
  wire [2:0] Data;


  // Internal register to carry the value we want to drive
  // on to the Data port
  //
  reg [2:0] D;
  //
  // Copy the wanted value of D on to the bidirectional
  // Data bus.  Note that this isn't just a hardware buffer;
  // it copies the value even if it's X or Z.
  // Consequently we can float Data from the test fixture side
  // by writing 3'bz to D, and this assign will then copy the
  // Z value on to Data as required.
  //
  assign Data = D;


  // Internal value for error reporting
  //
  reg [7:0] Error;

  // Whenever this test fixture detects an error, it
  // updates the Error value and triggers this always block.
  // Some of the error checks may change Error more than once
  // at a given moment of simulation time, so this may possibly
  // miss a few errors.  But that's not a serious problem, because
  // you'll re-run the simulation after fixing the first error,
  // and then the test will detect the hidden error.
  //
  always @Error if (Error !== 8'b0)
    $display ("  ***  Error %0d detected at time %t  ***", Error, $time);


  // Clock generator
  //
  always #5
    Clk = !Clk;


  // DUT instance, with the Length parameter set to 3
  //
  shifter #(3) sh (Clk, EN, WR, RD, SI, SO, Data);


  // General setup, stimulus generation and output checking
  //
  initial
  begin
    $timeformat (-9, 0, "ns", 0);
    $display ("Starting...");

    Error = 0;
    
    {RD,WR,EN} = 3'b000;
    Clk = 0;
    SI = 0;
    D = 3'bz;

    // Disabled...
    repeat(4)
    begin
      #10 if (SO   !== 1'bx)   Error = 1;
    end
          if (Data !== 3'bz)   Error = 2;

    // Enable and shift a 0 thru...
    EN = 1;
    #30
    repeat(4)
    begin
      #10 if (SO   !== 1'b0)   Error = 3;
    end
          if (Data !== 3'bz)   Error = 4;

    // Now shift a 1 thru...
    SI = 1;
    #10   if (SO   !== 1'b0)   Error = 5;
    #10   if (SO   !== 1'b0)   Error = 6;
    #10   if (SO   !== 1'b0)   Error = 7;
    repeat(4)
    begin
      #10 if (SO   !== 1'b1)   Error = 8;
    end
          if (Data !== 3'bz)   Error = 9;

    // Disable and parallel load...
    EN = 0;
    WR = 1;
    D = 3'b010;
    #10   if (SO   !== 1'b1)   Error = 10;
          if (Data !== 3'b010) Error = 11;

    // Idle...
    WR = 0;
    D = 3'bz;
    repeat(4)
    begin
      #10 if (SO   !== 1'b1)   Error = 12;
    end
          if (Data !== 3'bz)   Error = 13;

    // Read data...
    RD = 1;
    #1    if (Data !== 3'b010) Error = 14;
    #9    if (SO   !== 1'b1)   Error = 15;

    // Shift out...
    // Check timing wrt Clk...
    EN = 1;
    #4    if (Data !== 3'b010) Error = 16;
    #2    if (SO   !== 1'b0)   Error = 17;
          if (Data !== 3'b101) Error = 18;

    #8    if (Data !== 3'b101) Error = 19;
    #2    if (SO   !== 1'b1)   Error = 20;
          if (Data !== 3'b110) Error = 21;

    #8    if (Data !== 3'b110) Error = 22;
    #2    if (SO   !== 1'b0)   Error = 23;
          if (Data !== 3'b111) Error = 24;

    // Stop reading...
    #4 RD = 0;
    #1    if (Data !== 3'bz)   Error = 25;

    if (Error === 8'b0)
      $display ("Finished with no errors detected");
    else
      $display ("Finished with ERRORS - please check messages above");

    $stop; $finish;

  end

endmodule
