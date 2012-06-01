module logic_tb();

  reg in0, in1, in2, in3;
  wire logic_and, logic_nand, logic_or, logic_xor;

  initial
  begin
    in0 = 0; in1 = 0; in2 = 0; in3 = 0; #10;
    in0 = 0; in1 = 0; in2 = 0; in3 = 1; #10;
    in0 = 0; in1 = 0; in2 = 1; in3 = 0; #10;
    in0 = 0; in1 = 0; in2 = 1; in3 = 1; #10;
    in0 = 0; in1 = 1; in2 = 0; in3 = 0; #10;
    in0 = 0; in1 = 1; in2 = 0; in3 = 1; #10;
    in0 = 0; in1 = 1; in2 = 1; in3 = 0; #10;
    in0 = 0; in1 = 1; in2 = 1; in3 = 1; #10;
    in0 = 1; in1 = 0; in2 = 0; in3 = 0; #10;
    in0 = 1; in1 = 0; in2 = 0; in3 = 1; #10;
    in0 = 1; in1 = 0; in2 = 1; in3 = 0; #10;
    in0 = 1; in1 = 0; in2 = 1; in3 = 1; #10;
    in0 = 1; in1 = 1; in2 = 0; in3 = 0; #10;
    in0 = 1; in1 = 1; in2 = 0; in3 = 1; #10;
    in0 = 1; in1 = 1; in2 = 1; in3 = 0; #10;
    in0 = 1; in1 = 1; in2 = 1; in3 = 1; #10;
    $finish;
  end

  logic m(
    .in0 (in0),
    .in1 (in1),
    .in2 (in2),
    .in3 (in3),
    .out0(logic_and),
    .out1(logic_or),
    .out2(logic_nand),
    .out3(logic_xor)
  );

endmodule //logic_tb
