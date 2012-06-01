// Comprehensive Verilog version 7 exercise 9

// Test Fixture for FSM Exercise

`define FALSE 0
`define TRUE 1

`timescale 1 ns / 1 ns

module fsmtf;

  reg Crystal, nSysReset;
  reg [1:2] Buttons;
  wire WatchRunning, WatchReset;
  reg OK;

  parameter Period = 10;

  fsm F (Crystal, nSysReset, Buttons, WatchRunning, WatchReset);
  //fsm2 F (Crystal, nSysReset, Buttons, WatchRunning, WatchReset);
  //fsm3 F (Crystal, nSysReset, Buttons, WatchRunning, WatchReset);
  //fsm4 F (Crystal, nSysReset, Buttons, WatchRunning, WatchReset);

  initial
  begin
    Crystal = 0;
    while ( $time < 200 )
      #(Period/2) Crystal = !Crystal;
    if ( OK === `TRUE )
      $display ( "~~~~~~ COMPLETED WITHOUT ERRORS ~~~~~~" );
    else
      $display ( "~~~~~~ COMPLETED WITH ERRORS ~~~~~~" );
  end

  // Error monitoring and reporting
  //
  initial $timeformat ( -9, 0, "ns", 0);
  always @OK if (OK === `FALSE)
    $display ( "ERROR: Test fixture detected an error at time %t", $time );

  // Main stimulus generator and output checker
  //
  initial
  begin : Stimulus
    integer I;

    OK = `TRUE;
    nSysReset = 1;
    #1 nSysReset = 0;
    Buttons = 2'b00;

    #2 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    nSysReset = 1;

    for ( I = 1; I <= 17; I = I+1 )
      #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
           OK = `FALSE;

    Buttons = 2'b10; // Start
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    #5 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;

    #4 Buttons = 2'b00; // Running
    #1 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;

    #4 Buttons = 2'b10; // Stop
    #1 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    #4 Buttons = 2'b00; // Stopped
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    #4 Buttons = 2'b01; // Reset
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b01 )
         OK = `FALSE;

    #4 Buttons = 2'b00; // Zero
    #1 if ( {WatchRunning, WatchReset} !== 2'b01 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    #4 Buttons = 2'b10; // Start (from Zero)
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;

    #4 Buttons = 2'b00; // Running
    #1 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;

    #4 Buttons = 2'b10; // Stop
    #1 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    #4 Buttons = 2'b00; // Stopped
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    #4 Buttons = 2'b10; // Start (from Stopped)
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;

    #4 Buttons = 2'b00; // Running
    #1 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;

    #4 Buttons = 2'b10; // Stop
    #1 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    #4 Buttons = 2'b00; // Stopped
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    #4 Buttons = 2'b01; // Reset
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b01 )
         OK = `FALSE;

    #4 Buttons = 2'b00; // Zero
    #1 if ( {WatchRunning, WatchReset} !== 2'b01 )
         OK = `FALSE;
    #5 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    // Test asynchronous reset (gives an error if reset is synchronous)

    #5 Buttons = 2'b10; // Start
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;
    #4 if ( {WatchRunning, WatchReset} !== 2'b10 )
         OK = `FALSE;

    #3 nSysReset = 0;
    #1 if ( {WatchRunning, WatchReset} !== 2'b00 )
         OK = `FALSE;

    nSysReset = 1;

  end


  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  // NOTE TO DOULOS COURSE LEADERS:                                           //
  // This section of code was introduced in version 7.1 of the                //
  // course.  It is believed to be reliable, but Verilog                      //
  // nondeterminism and differences among simulators mean that                //
  // it may yet harbour some hidden bugs.  If it causes trouble,              //
  // please delete it and report the problem.                                 //
  //                                                                          //
  // (1) Check for misuse of blocking assignments in synchronous logic.       //
  // Two successive #0 delays mean this check will still work even            //
  // if someone tries to cheat with a single #0 delay in their code.          //
  // Abandon check before first clock - something funny happens               //
  // in simulators with optimisation turned on.                               //
  //                                                                          //
  wire [1:0] Q = {WatchRunning, WatchReset};                                  //
  always @(posedge Crystal or negedge nSysReset) begin : synchTracker         //
    reg [1:0] oldQ;                                                           //
    outputTracker.tEdge = $time;  // needed for synchronicity check           //
    #0 #0 if ((Q !== oldQ) && ($time > 4)) begin                              //
      $display(                                                               //
        "\n   ************************************************************",  //
        "\n   **************** DOULOS CODING STYLE CHECK *****************",  //
        "\n   ************************************************************",  //
        "\n   *                                                          *",  //
        "\n   *  It seems that you have used blocking assignment (=) to  *",  //
        "\n   *  update a variable (reg) that is an output of a clocked  *",  //
        "\n   *  always block.  You should invariably use nonblocking    *",  //
        "\n   *  assignment (<=) for this purpose.  Please correct this  *",  //
        "\n   *  mistake before proceeding any further.                  *",  //
        "\n   *                                                          *",  //
        "\n   *  If you are sure that you have not made this error,      *",  //
        "\n   *  please ask your course leader to investigate.           *",  //
        "\n   *                                                          *",  //
        "\n   ************************************************************"); //
      $stop; $finish;                                                         //
    end                                                                       //
  end                                                                         //
  //                                                                          //
  // (2) Check that all output changes are synchronous and zero-delay.        //
  //                                                                          //
  always @Q begin : outputTracker                                             //
    time tChange, tEdge;                                                      //
    synchTracker.oldQ <= #1 Q; // needed for blocking assignment check        //
    tChange = $time;                                                          //
    #1 if ((tChange > 0) && (tChange !== tEdge)) begin                        //
      $display(                                                               //
        "\n   ************************************************************",  //
        "\n   **************** DOULOS CODING STYLE CHECK *****************",  //
        "\n   ************************************************************",  //
        "\n   *                                                          *",  //
        "\n   *  The test fixture detected an output change that was     *",  //
        "\n   *  not synchronised to the active edge of reset or clock.  *",  //
        "\n   *  This is probably caused by an incorrectly coded         *",  //
        "\n   *  sensitivity list on a clocked always block, or because  *",  //
        "\n   *  you used a #delay when assigning to an output.  Please  *",  //
        "\n   *  correct this mistake before proceeding any further.     *",  //
        "\n   *                                                          *",  //
        "\n   *  If you are sure that you have not made this error,      *",  //
        "\n   *  please ask your course leader to investigate.           *",  //
        "\n   *                                                          *",  //
        "\n   ************************************************************"); //
      $stop; $finish;                                                         //
    end                                                                       //
  end                                                                         //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

endmodule
