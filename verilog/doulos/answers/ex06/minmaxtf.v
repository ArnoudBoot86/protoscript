// Comprehensive Verilog version 7 ANSWERS exercise 6

// Test fixtures for MinMax exercise

`timescale 1 ns / 1 ns

module MinMaxtf;

  // Connections to DUT
  //
  wire [3:0] Z;
  reg Min0Max1;
  reg [3:0] X, Y;

  // DUT instance
  //
  MinMax m (Min0Max1, X, Y, Z);

  // Initialise all inputs so that
  // we don't see any X values
  //
  initial
  begin
    Min0Max1 = 0;
    X = 0;
    Y = 0;
  end

  // Cycle through all possible values of Y input
  //
  always #10
    Y = Y + 1;

  // Every time we go round a complete set of Y inputs,
  // increment X t the next possible value
  //
  always #(16*10)
    X = X + 1;

  // When we've been round a complete set of {X, Y}
  // values, toggle Min0Max1 and then do the whole
  // sequence all over again
  always #(16*16*10)
    Min0Max1 = Min0Max1 + 1;  // or...   Min0Max1 = ~ Min0Max1;

  // Monitoring and test termination control
  //
  initial
  begin
    $display ("MM X  Y  Z");
    $monitor (Min0Max1,,X,,Y,,Z);
    // Wait until all 512 possible input values have been tried
    #(16*16*2*10);
    $stop;
    $finish;
  end

endmodule


// The following implementations of the test fixture
// offer alternative methods for exercising all possible
// combinations of the device inputs.
/*
module MinMaxtf;

  wire [3:0] Z;
  integer C;

  initial
    C = 0;

  always #10
    C = C + 1;

  initial
  begin
    $display ("MM X  Y  Z");
    $monitor (C[8],,C[7:4],,C[3:0],,Z);
    #(16*16*2*10);
    $stop;
    $finish;
  end

  MinMax m (C[8], C[7:4], C[3:0], Z);

endmodule

module MinMaxtf;

  wire [3:0] Z;
  reg Min0Max1;
  reg [3:0] X, Y;

  initial
    {Min0Max1,X,Y} = 0;

  always #10
    {Min0Max1,X,Y} = {Min0Max1,X,Y} + 1;

  initial
  begin
    $display ("MM X  Y  Z");
    $monitor (Min0Max1,,X,,Y,,Z);
    #(16*16*2*10);
    $stop;
    $finish;
  end

  MinMax m (Min0Max1, X, Y, Z);

endmodule
*/
