// Comprehensive Verilog version 7 ANSWERS exercise 11
//
// Test bench for Part 1 (no tasks)

`timescale 1ns/1ns

module RamChipTF;

  parameter AddressSize = 4;
  parameter WordSize    = 16;

  parameter Tsetup      = 5;
  parameter Thold       = 3;
  parameter Tpulse      = 2;
  parameter Tbetween    = 5;     // Delay between consecutive cycles

  // Connections to memory model
  //
  reg  [AddressSize-1:0] Address;
  wire [WordSize-1:0]    Data;
  reg                    nCS, nWE, nOE;

  // Signal Data is connected to an inout port, and must be a net.
  // In order to drive it from within procedural code, we need an
  // auxiliary variable to hold the value our test fixture is
  // trying to drive on to Data.  We then copy Datareg on to Data
  // using a continuous assign.
  //
  reg  [WordSize-1:0]    Datareg;
  //
  assign Data = Datareg;


  // Instance of memory model
  //
  RamChip #(AddressSize, WordSize) Chip (Address, Data, nCS, nWE, nOE);


  initial
  begin

    // Write 'haaaa to address 0

            Address = 0;
            Datareg = 16'haaaa;
            nWE = 1;
            nOE = 1;
            nCS = 0;
    #Tsetup nWE = 0;
    #Tpulse nWE = 1;
    #Thold  Datareg = {WordSize{1'bZ}};
            nCS = 1;

    #Tbetween;

    // Write 'h5555 to address 1

            Address = 1;
            Datareg = 16'h5555;
            nWE = 1;
            nOE = 1;
            nCS = 0;
    #Tsetup nWE = 0;
    #Tpulse nWE = 1;
    #Thold  Datareg = {WordSize{1'bZ}};
            nCS = 1;

    #Tbetween;

    // Read from address 0

            Address = 0;
            Datareg = {WordSize{1'bZ}};
            nWE = 1;
            nOE = 1;
            nCS = 0;
    #Tsetup nOE = 0;
    #Tpulse if ( Data !== 16'haaaa )
              $display ("Failed to read correct data from address 0");
            nOE = 1;
    #Thold nCS = 1;

    #Tbetween;

    // Read from address 1

            Address = 1;
            Datareg = {WordSize{1'bZ}};
            nWE = 1;
            nOE = 1;
            nCS = 0;
    #Tsetup nOE = 0;
    #Tpulse if ( Data !== 16'h5555 )
              $display ("Failed to read correct data from address 0");
            nOE = 1;
    #Thold nCS = 1;
  end

endmodule
