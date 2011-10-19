// Comprehensive Verilog version 7 ANSWERS exercise 8

// Solution to shifter exercise

/*
// Verilog 1995 legacy style

module shifter (Clk, EN, WR, RD, SI, SO, Data);

  parameter Length = 1;

  input Clk, EN, WR, RD, SI;
  output SO;
  inout [Length-1:0] Data;

  reg SO;
*/

module shifter #(
    parameter Length = 1
  )(
    input Clk, EN, WR, RD, SI,
    output reg SO,
    inout [Length-1:0] Data
  );

  reg [Length-1:0] Reg;

  assign Data = RD ? Reg : {Length{1'bz}};

  always @(posedge Clk)
    if (EN)
    begin
      {Reg, SO} <= {SI, Reg};   // Equivalent to: SO <= Reg[0];
                                //                Reg <= Reg >> 1;
                                //                Reg[Length-1] <= SI;
    end
    else if (WR)
      Reg <= Data;

  always @(posedge Clk)
    if (WR & EN)
      $display (
        "Error in module %m: Wr and En both active at time %0d",
        $time);

endmodule

