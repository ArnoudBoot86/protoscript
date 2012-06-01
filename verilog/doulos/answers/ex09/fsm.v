// Comprehensive Verilog version 7 ANSWERS exercise 9

// Solution to FSM exercise

// This file contains several solutions to the exercise,
// illustrating the various possible architectures
// outlined in the preceding classroom session.
// The various solutions have slightly different module
// names, so that they can all be compiled together
// without conflict.


// (1) Separate output decoding.

`timescale 1ns / 1ns

module fsm (
    input Crystal, nSysReset,
    input [1:2] Buttons,
    output WatchRunning, WatchReset
  );

  parameter
    Zero          = 0,
    Start         = 1,
    Running       = 2,
    Stop          = 3,
    Stopped       = 4,
    Reset         = 5;

  reg [2:0] State;

  always @(posedge Crystal or negedge nSysReset)
    if (!nSysReset)
      State <= Zero;
    else
      case (State)
      Zero:
        if (Buttons[1])      State <= Start;
      Start:
        if (!Buttons)        State <= Running;
      Running:
        if (Buttons[1])      State <= Stop;
      Stop:
        if (!Buttons)        State <= Stopped;
      Stopped:
        if (Buttons[1])      State <= Start;
        else if (Buttons[2]) State <= Reset;
      Reset:
        if (!Buttons)        State <= Zero;
      default:
                             State <= 3'bx;
      endcase

  assign
    WatchRunning =
      (State == Start) ||
      (State == Running),

    WatchReset =
      (State == Reset);

endmodule



// (2) Separate flip-flops from combinational logic

`timescale 1ns / 1ns

module fsm2 (
    input Crystal, nSysReset,
    input [1:2] Buttons,
    output reg WatchRunning, WatchReset
  );

  parameter
    Zero          = 0,
    Start         = 1,
    Running       = 2,
    Stop          = 3,
    Stopped       = 4,
    Reset         = 5;

  reg [2:0] State, NextState;

  always @(posedge Crystal or negedge nSysReset)
    if (!nSysReset)
      State <= Zero;
    else
      State <= NextState;

  always @(State or Buttons)
  begin

    NextState = State;

    WatchRunning = 0;
    WatchReset = 0;

    case (State)
      Zero:
        if (Buttons[1])      NextState = Start;
      Start:
        begin
          WatchRunning = 1;
          if (!Buttons)      NextState = Running;
        end
      Running:
        begin
          WatchRunning = 1;
          if (Buttons[1])    NextState = Stop;
        end
      Stop:
        if (!Buttons)        NextState = Stopped;
      Stopped:
        if (Buttons[1])      NextState = Start;
        else if (Buttons[2]) NextState = Reset;
      Reset:
        begin
          WatchReset = 1;
          if (!Buttons)      NextState = Zero;
        end
      default:
                             NextState = 3'bx;
    endcase
  end

endmodule


// (3) No output logic

`timescale 1ns / 1ns

module fsm3 (
    input Crystal, nSysReset,
    input [1:2] Buttons,
    output WatchRunning, WatchReset
  );

  parameter
   Zero     = 4'b0000,
   Start    = 4'b1000,
   Running  = 4'b1001,
   Stop     = 4'b0001,
   Stopped  = 4'b0010,
   Reset    = 4'b0100;

  reg [3:0] State;

  always @(posedge Crystal or negedge nSysReset)
    if (!nSysReset)
      State <= Zero;
    else
      case (State)
        Zero :
          if (Buttons[1])          State <= Start;
        Start :
          if (!Buttons)            State <= Running;
        Running :
          if (Buttons[1])          State <= Stop;
        Stop :
          if (!Buttons)            State <= Stopped;
        Stopped :
          if (Buttons[1])          State <= Start;
          else if (Buttons[2])     State <= Reset;
        Reset :
          if (!Buttons)            State <= Zero;
        default :
                                   State <= 4'bxxxx;
      endcase

  assign WatchRunning = State[3];
  assign WatchReset   = State[2];

endmodule


// (4) Explicit one-hot encoding

`timescale 1ns / 1ns

module fsm4 (
    input Crystal, nSysReset,
    input [1:2] Buttons,
    output WatchRunning, WatchReset
  );

  parameter
   Zero     = 0,
   Start    = 1,
   Running  = 2,
   Stop     = 3,
   Stopped  = 4,
   Reset    = 5;

  reg [5:0] State;

  always @(posedge Crystal or negedge nSysReset)
    if (!nSysReset)
    begin
      State <= 6'b0;
      State[Zero] <= 1'b1;
    end
    else
    begin
      State <= 6'b0;
      case (1'b1) // synopsys parallel_case
        State[Zero] :
          if (Buttons[1])          State[Start] <= 1'b1;
          else State[Zero] <= 1'b1;
        State[Start] :
          if (!Buttons)            State[Running] <= 1'b1;
          else State[Start] <= 1'b1;
        State[Running] :
          if (Buttons[1])          State[Stop] <= 1'b1;
          else State[Running] <= 1'b1;
        State[Stop] :
          if (!Buttons)            State[Stopped] <= 1'b1;
          else State[Stop] <= 1'b1;
        State[Stopped] :
          if (Buttons[1])          State[Start] <= 1'b1;
          else if (Buttons[2])     State[Reset] <= 1'b1;
          else State[Stopped] <= 1'b1;
        State[Reset] :
          if (!Buttons)            State[Zero] <= 1'b1;
          else State[Reset] <= 1'b1;
        default :
                                   State <= 6'bx;
      endcase
    end

  assign WatchRunning = State[Running] || State[Start];
  assign WatchReset   = State[Reset];

endmodule
