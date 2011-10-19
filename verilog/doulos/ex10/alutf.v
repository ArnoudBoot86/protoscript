// Comprehensive Verilog version 7 exercise 10
// Test fixture for ALU Exercise

`timescale 1ns/1ns

module alutf;

  reg Clock;
  reg [7:0] A, B;
  reg [3:0] Op;
  wire [7:0] F;
  wire Cout, Equal;

  initial
  begin: clockgen
    Clock = 0;
    forever #5
      Clock = !Clock;
  end

  initial
  begin: stim
    integer I, J, K;
    reg [7:0] lookup [1:8];
    lookup[1] = 8'b00000000;
    lookup[2] = 8'b00000001;
    lookup[3] = 8'b00000011;
    lookup[4] = 8'b00001000;
    lookup[5] = 8'b00001111;
    lookup[6] = 8'b10000000;
    lookup[7] = 8'b11111000;
    lookup[8] = 8'b11111111;

    repeat (2)
    begin
      for (I = 1; I <= 8; I = I + 1)
      begin
        B = lookup[I];
        for (J = 1; J <= 8; J = J + 1)
        begin
         A = lookup[J];
          for (K = 0; K <= 15; K = K + 1)
          begin
            Op = K;
            #10;
          end
        end
      end
      disable clockgen;
    end
  end

  alu ALU (Clock, A, B, Op, F, Cout, Equal);

  initial
  begin: check
    parameter N = 4095;
    reg [1:10] expected [1:N];
    reg [1:10] exp;
    integer I;

    $readmemb("alu.out", expected);

    #6
    for (I = 1; I <= N; I = I + 1)
    begin
      exp = expected[I];
      if (F !== exp[1:8] & exp[1:8] !== 8'bx)
        $display("Failed to produce expected output on F at %d", $stime);
      if (Cout !== exp[9] & exp[9] !== 1'bx)
        $display("Failed to produce expected output on Cout at %d", $stime);
      if (Equal !== exp[10] & exp[10] !== 1'bx)
        $display("Failed to produce expected output on Equal at %d", $stime);
      #5;
    end
    $display("Finished checking output");
  end

endmodule

