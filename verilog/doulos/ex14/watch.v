// Comprehensive Verilog version 7 exercise 14
// Template for Stopwatch Exercise

`timescale 1ns / 1ns

module Watch (
    input Crystal, nSysReset,
    input [1:2] Buttons,
    output [5:0] Mins, Secs
  );
