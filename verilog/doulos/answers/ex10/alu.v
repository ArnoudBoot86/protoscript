// Comprehensive Verilog version 7 ANSWERS exercise 10

// This file contains three possible solutions to the exercise.
// To simulate or synthesize, un-comment one of these.

`timescale 1ns/1ns

// Solution (1) to ALU Exercise -
// explicit sign extension of A, B

///*
module alu (
    input Clock,
    input [7:0] A, B,
    input [3:0] Op,
    output reg [7:0] F,
    output Cout, Equal
  );

  reg [8:0] Tmp;

  `include "alucodes.v"

  always @(A or B or Op)
  begin : Clogic
    reg [8:0] A9, B9;

    A9 = {A[7],A};
    B9 = {B[7],B};

    case (Op)
      AplusB:   Tmp = A9 + B9;
      AminusB:  Tmp = A9 - B9;
      BminusA:  Tmp = B9 - A9;
      OnlyA:    Tmp = A9;
      OnlyB:    Tmp = B9;
      minusA:   Tmp = -A9;
      minusB:   Tmp = -B9;
      sllA:     Tmp = A << 1;
      slrA:     Tmp = A >> 1;
      rllA:     Tmp = {A, A[7]};
      rlrA:     Tmp = {A[0], A[7:1]};
      AllZeros: Tmp = 9'b0;
      AllOnes:  Tmp = 9'b111111111;
      default:  Tmp = 9'bx;
    endcase
  end

  always @(posedge Clock)
      F <= Tmp[7:0];

  assign Equal = (A == B);
  assign Cout = Tmp[8];

endmodule
//*/

// Solution (2) to ALU Exercise -
// Verilog-2001 solution using signed register arithmetic

/*
module alu (
  input Clock,
  input signed [7:0] A, B,
  input [3:0] Op,
  output reg [7:0] F,
  output Cout, Equal
);

  reg signed [8:0] Tmp;

  `include "alucodes.v"

  always @*
  begin : Clogic

    case (Op)
      AplusB:   Tmp = A + B;
      AminusB:  Tmp = A - B;
      BminusA:  Tmp = B - A;
      OnlyA:    Tmp = A;
      OnlyB:    Tmp = B;
      minusA:   Tmp = -A;
      minusB:   Tmp = -B;
      sllA:     Tmp = A << 1;
      slrA:     Tmp = A[7:0] >> 1;
      rllA:     Tmp = {A, A[7]};
      rlrA:     Tmp = {A[0], A[7:1]};
      AllZeros: Tmp = 9'b0;
      AllOnes:  Tmp = -1;
      default:  Tmp = 9'bx;
    endcase
  end

  always @(posedge Clock)
      F <= Tmp[7:0];

  assign Equal = (A == B);
  assign Cout = Tmp[8];

endmodule
*/
 
// Solution (3) to ALU Exercise - 
// Optimized solution - guaranteed to create only one adder

/*
// Verilog 1995 legacy syntax

module alu (Clock, A, B, Op, F, Cout, Equal);
  input Clock;
  input [7:0] A, B;
  input [3:0] Op;
  output [7:0] F;
  output Cout, Equal;

  reg [7:0] F;
  reg [8:0] L, R;
  reg Cin;

  wire [8:0] Sum;
  wire Dummy;

  `include "alucodes.v"

  always @(A or B or Op)
  begin : Clogic
    reg [8:0] A9, B9;

    A9 = {A[7],A};
    B9 = {B[7],B};

    case (Op)
      AplusB:   begin L = A9;             R = B9;   Cin = 0; end
      AminusB:  begin L = A9;             R = ~B9;  Cin = 1; end
      BminusA:  begin L = ~A9;            R = B9;   Cin = 1; end
      OnlyA:    begin L = A9;             R = 0;    Cin = 0; end
      OnlyB:    begin L = 0;              R = B9;   Cin = 0; end
      minusA:   begin L = ~A9;            R = 0;    Cin = 1; end
      minusB:   begin L = 0;              R = ~B9;  Cin = 1; end
      sllA:     begin L = A << 1;         R = 0;    Cin = 0; end
      slrA:     begin L = A >> 1;         R = 0;    Cin = 0; end
      rllA:     begin L = {A, A[7]};      R = 0;    Cin = 0; end
      rlrA:     begin L = {A[0], A[7:1]}; R = 0;    Cin = 0; end
      AllZeros: begin L = 0;              R = 0;    Cin = 0; end
      AllOnes:  begin L = ~0;             R = 0;    Cin = 0; end
      default:  begin L = 9'bx;           R = 9'bx; Cin = 1'bx; end
    endcase
  end

  assign {Sum, Dummy} = {L, 1'b1} + {R, Cin};

  always @(posedge Clock)
      F <= Sum[7:0];

  assign Equal = (A == B);
  assign Cout = Sum[8];

endmodule
*/
