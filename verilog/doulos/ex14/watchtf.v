// Comprehensive Verilog version 7 exercise 14
// Test fixture for Stopwatch Exercise

`define FALSE 0
`define TRUE 1

`timescale 1ms / 1ns

module WatchTF;

  reg [1:2] Buttons;
  wire [5:0] Mins, Secs;
  reg Crystal, nSysReset;

  reg OK;

  initial
  begin : Crystalgen
    while ( $time < 90000 ) // 1 min + 30 sec
    begin
          Crystal = 0;
      #50 Crystal = 1;
      #50;
      // The very slow crystal speed makes debugging easier!
    end
  end

  // This task checks Mins and Secs at 100ms intervals for 1s. It makes
  // the initial statement more readable.

  task CheckForASec;
    input [5:0] MinsExpected;
    input [5:0] SecsExpected;

    integer I;

    for ( I = 1; I <= 10; I = I+1 )
      #100 if ( Mins !== MinsExpected || Secs !== SecsExpected )
        OK = `FALSE;

  endtask

  initial
  begin : StimulusCheck

    integer I;

    OK = `TRUE;
    nSysReset = 0;
    Buttons = 2'b00;

    // Asynchronous Reset

    #1 nSysReset = 1;
    if (Mins !== 6'b000000 || Secs !== 6'b000000)
      OK = `FALSE;

    // Can't use task CheckForASec here as the timing is different
    #50
    for ( I = 1; I <= 9; I = I+1 )
    begin
      if (Mins !== 6'b000000 || Secs !== 6'b000000)
        OK = `FALSE;
      #100;
    end

    #49 Buttons = 2'b10; // Start counting

    CheckForASec (6'd0, 6'd0);

    Buttons = 2'b00;

    CheckForASec (6'd0, 6'd1);
    CheckForASec (6'd0, 6'd2);
    CheckForASec (6'd0, 6'd3);
    CheckForASec (6'd0, 6'd4);
    CheckForASec (6'd0, 6'd5);
    CheckForASec (6'd0, 6'd6);
    CheckForASec (6'd0, 6'd7);
    CheckForASec (6'd0, 6'd8);

    // Can't use task CheckForASec here as the timing is different
    for ( I = 1; I <= 3; I = I+1 )
      #100 if ( Mins !== 6'd0 || Secs !== 6'd9 )
        OK = `FALSE;

    Buttons = 2'b10; // Stop counting after 9.3 Sec

    CheckForASec (6'd0, 6'd9);

    Buttons = 2'b00;

    // Can't use task CheckForASec here as the timing is different
    for ( I = 1; I <= 17; I = I+1 )
      #100 if ( Mins !== 6'd0 || Secs !== 6'd9 )
        OK = `FALSE;

    Buttons = 2'b01; // Reset

    #100
    for ( I = 1; I <= 9; I = I+1 )
      #100 if ( Mins !== 6'd0 || Secs !== 6'd0 )
        OK = `FALSE;

    Buttons = 2'b00;

    CheckForASec (6'd0, 6'd0);

    Buttons = 2'b10; // Start

    CheckForASec (6'd0, 6'd0);

    Buttons = 2'b00;

    CheckForASec (6'd0, 6'd1);
    CheckForASec (6'd0, 6'd2);

    #(56 * 1000) // 56s

    CheckForASec (6'd0, 6'd59);
    CheckForASec (6'd1, 6'd0);
    CheckForASec (6'd1, 6'd1);
    CheckForASec (6'd1, 6'd2);
    CheckForASec (6'd1, 6'd3);
    CheckForASec (6'd1, 6'd4);
    CheckForASec (6'd1, 6'd5);

    // Can't use task CheckForASec here as the timing is different
    for ( I = 1; I <= 5; I = I+1 )
      #100 if ( Mins !== 6'd1 || Secs !== 6'd6 )
        OK = `FALSE;

    Buttons = 2'b10; // Stop counting after 1 Min 6.5 Sec

    CheckForASec (6'd1, 6'd6);

    Buttons = 2'b00;

    CheckForASec (6'd1, 6'd6);

    Buttons = 2'b01; // Reset

    // Can't use task CheckForASec here as the timing is different
    #100
    for ( I = 1; I <= 9; I = I+1 )
      #100 if ( Mins !== 6'd0 || Secs !== 6'd0 )
        OK = `FALSE;

    Buttons = 2'b00;
  end

  Watch UUT (Crystal, nSysReset, Buttons, Mins, Secs);

endmodule
