// Comprehensive Verilog version 7 exercise 11
//
// Skeleton task declarations for RamChip test fixture part 2


// Note - the contents of this file will not compile without errors
// if pasted into the test fixture RamChipTF, unless valid statements
// are added where indicated.  This is because Verilog does not
// allow a begin...end block containing no statements!


// task WriteCycle should set up address, data and control
// signals to perform a write cycle to the memory using
// address and data values as specified by the task arguments.
//
task WriteCycle(
    input [AddressSize-1:0] AddrValue,
    input [WordSize-1:0] DataValue
  );
  begin
  // *********** ADD YOUR CODE HERE *************
  end
endtask


// task ReadCycle should set up the control signals, and the address
// to perform a read operation. When the RamChip puts the appropriate
// value on the data bus, ReadCycle should copy that value into
// DataValue.  The task can then pass this information back to the
// calling code.  The test code that called this task can then use
// this returned value and check it against the expected data value.
//
// Example usage of ReadCycle task...
//   ReadCycle(10, ActualData); // get value at address 10
//   ...                        // check ActualData is 10
//
task ReadCycle(
    input [AddressSize-1:0] AddrValue,
    output [WordSize-1:0] DataValue
  );
  begin
  // *********** ADD YOUR CODE HERE *************
  end
endtask

