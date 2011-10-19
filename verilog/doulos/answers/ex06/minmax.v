// Comprehensive Verilog version 7 ANSWERS exercise 6

// MinMax calculator

`timescale 1 ns / 1 ns

// This file contains many different possible solutions,
// including those for the "If You Have Time" extensions.
// All but the first are commented-out.


// Solution 1: Straightforward interpretation of the specification
//
module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output reg [3:0] Z
  );

  always @(Min0Max1 or X or Y)  // or "always @*" in Verilog-2001
    if (Min0Max1)
      if (X > Y)
        Z = X;
      else
        Z = Y;
    else
      if (X > Y)
        Z = Y;
      else
        Z = X;

endmodule

/* ******** ALTERNATIVE SOLUTIONS ********


// Solution 2: Choices re-ordered to use only one comparator,
//
module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output reg [3:0] Z
  );

  always @(Min0Max1 or X or Y)
    if (X > Y)
      if (Min0Max1)
        Z = X;
      else
        Z = Y;
    else
      if (Min0Max1)
        Z = Y;
      else
        Z = X;

endmodule


// Solution 3: same logic as solution 2,
// but coded using a case statement
//
module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output reg [3:0] Z
  );

  always @(Min0Max1 or X or Y)
    case (X > Y)
    1: case (Min0Max1)
       1: Z = X;
       0: Z = Y;
       endcase
    0: case (Min0Max1)
       1: Z = Y;
       0: Z = X;
       endcase
    endcase

endmodule


// Solution 4: All controls presented to just one
// case statement
//
module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output reg [3:0] Z
  );

  always @(Min0Max1 or X or Y)
    case ({X > Y,Min0Max1})
    2'b11: Z = X;
    2'b10: Z = Y;
    2'b01: Z = Y;
    2'b00: Z = X;
    endcase

endmodule


// Solution 5: Like solution 1, but
// comparison result factored-out using
// an intermediate signal called GT
//
module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output reg [3:0] Z
  );

  reg GT;

  always @(Min0Max1 or X or Y)
  begin
    GT = X > Y;
    if (Min0Max1)
      if (GT)
        Z = X;
      else
        Z = Y;
    else
      if (GT)
        Z = Y;
      else
        Z = X;
  end

endmodule


// Solution 6:  like solution 5, but factored-out
// even further to simplify the choice of output
//
module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output [3:0] Z
  );

  wire GT  = X > Y;
  wire SEL = GT ^ Min0Max1;
  assign Z = SEL ? Y : X;

endmodule


// Solution 7: The shortest possible code!
//
module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output [3:0] Z
  );

  assign Z = Min0Max1 ^ (X > Y) ? Y : X;

endmodule


// Solution 8: Comparator using for loop
//
module MinMax (
    input Min0Max1,
    input [3:0] X, Y,
    output reg [3:0] Z
  );

  reg XgtY;
  integer I;

  // Comparator
  always @(X or Y)
  begin : compare_loop
    XgtY = 0;
    for ( I = 3; I >= 0; I = I - 1 )
    begin
      if ( X[I] == 1 && Y[I] == 0 )
      begin
        XgtY = 1;
        disable compare_loop;
      end
      else if ( X[I] == 0 && Y[I] == 1 )
      begin
        XgtY = 0;
        disable compare_loop;
      end
    end
  end

  // Glue logic
  wire Sel = XgtY ^ Min0Max1;

  // Mux
  always @(Sel or X or Y)
    case (Sel)
      1'b0 : Z = X;
      1'b1 : Z = Y;
    endcase

endmodule

*/
