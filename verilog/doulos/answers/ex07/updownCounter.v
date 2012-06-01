// Comprehensive Verilog version 7 ANSWERS exercise 7

// Up/down counter

`timescale 1ns/1ns

module updownCounter (
    input Clock, Reset, Enable, Load, Up1Dn0,
    input  [7:0] Data,
    output reg [7:0] Q
  );

  always @(posedge Clock or posedge Reset)
    if (Reset)
      Q <= 0;
    else
      if (Enable)
        if (Load)
          Q <= Data;
        else
          if (Up1Dn0)
            Q <= Q + 1;
          else
            Q <= Q - 1;

endmodule
