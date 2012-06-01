// Comprehensive Verilog version 7 exercise 7

// Test fixture for up-down counter exercise

`timescale 1ns/1ns

module updownCounterTF;

  // DUT connections
  //
  reg Clock, Reset, Enable, Load, Up1Dn0;
  reg [7:0] Data;
  wire [7:0] Q;

  // Internal signal to flag any errors
  //
  reg OK;

  // DUT instance
  //
  updownCounter G1 (Clock, Reset, Enable, Load, Up1Dn0, Data, Q);

  // Track the OK signal - if it ever goes false, issue
  // a message to alert the user
  //
  always @OK
    if (OK == 1'b0)
      $display(" ***** First error detected at time %t! *****", $time);

  // Display all interesting signals
  //
  initial begin
    $timeformat(-9, 0, " ns", 7);
    $display ("                                                Data        Q      ");
    $display ("   time   OK  Clock Reset Enable Load Up1Dn0  76543210   76543210  ");
    $display ("|~~~~~~~~|~~~|~~~~~|~~~~~|~~~~~~|~~~~|~~~~~~|~~~~~~~~~~|~~~~~~~~~~|");
    $monitor (" %t   %b    %b     %b     %b     %b     %b     %b   %b",
                $time,    OK,Clock,Reset,Enable,Load,Up1Dn0,   Data,       Q);
  end

  // Clock generator
  //
  always
  begin
    #5 Clock = 1;
    #5 Clock = 0;
  end

  // Stimulus generator
  //
  initial
  begin
    Enable = 0;
    Load = 0;
    Up1Dn0 = 1;
    Reset = 1;
    #10; // Should be reset
    Reset = 0;
    #10; // Should do nothing - not enabled
    Enable = 1;
    #20; // Should count up to 2
    Up1Dn0 = 0;
    #40; // Should count down to 254
    Up1Dn0 = 1;
    #40; // Should count up to 2
    Reset = 1;
    #10; // Should be reset, overriding enable
    Reset = 0;
    #30; // Should count up to 3
    Enable = 0;
    #10; // Should do nothing - not enabled
    Data = 8'b01111111;
    Load = 1;
    #10; // Should do nothing - not enabled
    Load = 0;
    Enable = 1;
    #10; // Should count from 3 to 4
    Load = 1;
    #10; // Should load 127
    Load = 0;
    #20; // Should count from 127 to 129
    Enable = 0;
    #10; // Should do nothing - not enabled
    Up1Dn0 = 0;
    #10; // Should do nothing - not enabled
    Enable = 1;
    #20; // Should count down from 129 to 127
    Data = 8'b11110000;
    Load = 1;
    #10; // Should load
    Reset = 1;
    #10; // Should be reset, overriding load
    Load = 0;
    Up1Dn0 = 1;
    #10; // Should stay at 0 - still reset
    Reset = 0;
    #2560; // Should count from 0 round to 0
    Enable = 0;
    if (OK)
      $display("Test finished OK");
    else
      $display("Test finished with errors");
    $finish;
  end

  // Output checker
  //
  initial
  begin
    OK = 1;
    #9;
    if (Q !== 8'b00000000)
      OK = 0;

    #10;
    if (Q !== 8'b00000000)
      OK = 0;

    #20;
    if (Q !== 8'b00000010)
      OK = 0;

    #40;
    if (Q !== 8'b11111110)
      OK = 0;

    #40;
    if (Q !== 8'b00000010)
      OK = 0;

    #10;
    if (Q !== 8'b00000000)
      OK = 0;

    #30;
    if (Q !== 8'b00000011)
      OK = 0;

    #10;
    if (Q !== 8'b00000011)
      OK = 0;

    #10;
    if (Q !== 8'b00000011)
      OK = 0;

    #10;
    if (Q !== 8'b00000100)
      OK = 0;

    #10;
    if (Q !== 8'b01111111)
      OK = 0;

    #20;
    if (Q !== 8'b10000001)
      OK = 0;

    #10;
    if (Q !== 8'b10000001)
      OK = 0;

    #10;
    if (Q !== 8'b10000001)
      OK = 0;

    #20;
    if (Q !== 8'b01111111)
      OK = 0;

    #10;
    if (Q !== 8'b11110000)
      OK = 0;

    #10;
    if (Q !== 8'b00000000)
      OK = 0;

    #10;
    if (Q !== 8'b00000000)
      OK = 0;

    #2560;
    if (Q !== 8'b00000000)
      OK = 0;
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
  //                                                                          //
  always @(posedge Clock or posedge Reset) begin : synchTracker               //
    reg [7:0] oldQ;                                                           //
    outputTracker.tEdge = $time;  // needed for synchronicity check           //
    #0 #0 if (Q !== oldQ) begin                                               //
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
