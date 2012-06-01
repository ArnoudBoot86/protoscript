// Comprehensive Verilog version 7 ANSWERS exercise 5
// If You Have Time

// Priority encoder (2) - solution with error output

`timescale 1ns / 1ns

module prienc_with_error (output reg [1:0] f, input [3:0] a, output reg error);

  always @(a)
  begin

    // Default assignment covers the most likely situations,
    // and ensures that no latches will be created
    error = 0;

    if ( a[3] )
    begin
      f = 3;
      // Any other bits set?
      if ( a[2:0] ) error = 1;
    end
    else if ( a[2] )
    begin
      f = 2;
      if ( a[1:0] ) error = 1;
    end
    else if ( a[1] )
    begin
      f = 1;
      if ( a[0] ) error = 1;
    end
    else
    begin
      f = 0;
      if ( !a[0] ) error = 1;
    end

  end // always @(a)

endmodule


// Alternative solution for "if you have time"

/*
module prienc_with_error (output reg [1:0] f, input [3:0] a, output reg error);

  always @(a)
  begin
    error = 0;
    if ( a == 4'b1000 )
      f = 3;
    else if ( a == 4'b0100 )
      f = 2;
    else if ( a == 4'b0010 )
      f = 1;
    else if ( a == 4'b0001 )
      f = 0;
    else
    begin
      if ( a == 4'b0000 )
        f = 0;
      else
        f = 2'bx;
      error = 1;
    end
  end

endmodule
*/
