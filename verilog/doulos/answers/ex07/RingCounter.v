// Comprehensive Verilog version 7 ANSWERS exercise 7
// Solution to Ring Counter Exercise

module RingCounter (
    input Clock, Reset, Enable, Load, Up1Dn0,
    input [7:0] Data,
    output reg [7:0] Q
  );

  always @(posedge Clock or posedge Reset)
    if (Reset)
      Q <= 8'b1;
    else
      if (Enable)

        if (Load)
          Q <= Data;
        else  // not Load
          if (Up1Dn0) begin
            Q[7:1] <= Q[6:0];
            if (Q[6:0] == 7'b0)
              Q[0] <= 1'b1;
            else
              Q[0] <= 1'b0;
          end else begin  // not Up1Dn0
            Q[6:0] <= Q[7:1];
            if (Q[7:1] == 7'b0)
              Q[7] <= 1'b1;
            else
              Q[7] <= 1'b0;
          end

endmodule
