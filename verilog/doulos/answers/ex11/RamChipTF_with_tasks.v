// Comprehensive Verilog version 7 ANSWERS exercise 11
//
// Test bench for Part 2 (using tasks)

`timescale 1ns/1ns

module RamChipTF_with_tasks;

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


  // Task to perform a single write cycle
  task WriteCycle(
      input [AddressSize-1:0] AddrValue,
      input [WordSize-1:0] DataValue
    );
  begin
    Address = AddrValue;
    Datareg = DataValue;
    nCS = 0;
    #Tsetup nWE = 0;
    #Tpulse nWE = 1;
    #Thold  Datareg = {WordSize{1'bZ}};
    nCS = 1;
  end
  endtask // WriteCycle


  // Task to perform a single read cycle
  task ReadCycle(
      input [AddressSize-1:0] AddrValue,
      output [WordSize-1:0] DataValue
    );
  begin
    Address = AddrValue;
    Datareg = {WordSize{1'bZ}};
    nCS = 0;
    #Tsetup nOE = 0;
    #(Tpulse/2)  DataValue = Data;
    #(Tpulse/2)  nOE = 1;
    #Thold nCS = 1;
  end
  endtask // ReadCycle


  // This rather unpleasant trick allows us to check the
  // RamChip model's test for "illegal simultaneous read and write".
  // We simply run both the ReadCycle and WriteCycle tasks
  // simultaneously at time 0.  After we've done that, the test
  // can proceed as normal.
  //
  initial
    WriteCycle(0, 0);


  // Test sequence
  //
  initial
  begin : test
    integer I, V;

    $timeformat(-9, 0, "ns", 7);

    nWE = 1;
    nOE = 1;

    // Read cycle at time 0 will overlap with the write
    // cycle created by the previous "initial" block.
    //
    ReadCycle(0, V);

    // Sweep through all locations writing the address value as data.
    //
    for (I = 0; I < (1 << AddressSize); I = I + 1)
      #Tbetween WriteCycle(I, I);

    // Sweep through all locations reading the data back and checking
    // that it matches the address.
    //
    for (I = 0; I < (1 << AddressSize); I = I + 1)
    begin
      #Tbetween ReadCycle(I, V);
      if (I !== V)
        $display("Error at time %t: address='H%h, expected 'H%h, got 'H%h",
                              $time,           I,             I,        V );
    end

  end // test

endmodule
