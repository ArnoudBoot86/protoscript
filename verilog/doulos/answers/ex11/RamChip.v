// Comprehensive Verilog version 7 ANSWERS exercise 11
//
// Behavioural model of SRAM device

`timescale 1ns/1ns

module RamChip #(
    parameter AddressSize = 1,
    parameter WordSize = 1
  )(
    input [AddressSize-1:0] Address,
    inout [WordSize-1:0] Data,
    input nCS, nWE, nOE
  );

  reg [WordSize-1:0] Mem [0:(1<<AddressSize)-1];


  // Read from the memory when nCS and nOE are active.
  // Float the data bus at all other times.
  //
  assign Data = (!nCS && !nOE) ? Mem[Address] : {WordSize{1'bz}};


  // Write to the memory when nCS and nWE are active
  //
  // Something to consider:  Should this "always" be sensitive
  // to Address and Data as well as the control signals, or
  // is it OK in its present form?
  //
  always @(nCS or nWE)
    if (!nCS && !nWE)
      Mem[Address] = Data;


  // Check for abuse of the memory (simultaneous read and write).
  // Note:  Most off-the-shelf SRAM devices work correctly when
  // you do this; they allow nWE to take precedence over nOE.
  // You should consider how you might recode the Verilog
  // so that the memory behaves in this alternative way.
  //
  always @(nWE or nOE or nCS)
    if (!nWE && !nOE && !nCS)
      $display("Operational error in %m: OE and WE both active");

endmodule
