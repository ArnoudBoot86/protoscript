// Comprehensive Verilog version 7 ANSWERS exercise 12
//
// File reading/writing exercise

`timescale 1ns/1ns

module ReadHex;

  // This parameter determines the highest-numbered address
  // that you are prepared to read from the Hex file.
  //
  parameter Amax = 100;

  // End-of-file code as returned from $fscanf and $fgetc
  //
  parameter EOF = -1;

  // Array of (Amax) eight-bit bytes to store the data
  // that you have read from the Hex file
  //
  reg [7:0] HexFileContents [0:Amax-1];

  // A similar array to store data from the $readmemb file
  // that you will create as part of the lab
  //
  reg [7:0] MemFileContents [0:Amax-1];

  // A third array to store data from the $readmemb file
  // already provided as reference data
  //
  reg [7:0] RefFileContents [0:Amax-1];


  // Since this is just one single piece of software,
  // it can all go into one single "initial" block.
  //
  initial begin : FileFormatConverter

    // File identifiers
    //
    integer hexFile, memFile;

    // Statistics counters
    //
    integer recordCount, errorCount, warningCount, mismatchCount;

    // Scratch variable used in 'for' loops
    //
    integer i;


    // Open the file "data.hex", which is in Intel Hex format.
    //
    hexFile = $fopen( "data.hex", "r" );
    if (hexFile == 0) begin
      $display ( "FATAL - Failed to open Hex file for input" );
      $stop;
    end

    // Read its contents into the array variable HexFileContents.
    //
    begin : ReadHexFile

      forever begin : ReadHexRecord

        integer count;
        reg [7:0] type, byte_count, cksum;
        reg [15:0] address;
        
        reg [0:42*4-1] buffer;
        integer j, n;
        reg [0:7] b;
		  
        // Look for ":" character starting a Hex record.
        //
        begin : ScanForColon
          integer startChar;
          forever begin
            startChar = $fgetc ( hexFile );
            if (startChar == EOF)
              // we're finished, found end of file
              disable ReadHexFile;
            if (startChar == ":")
              disable ScanForColon;
          end // forever
        end // ScanForColon

        // Scan the first, fixed-format part of the record
        //
        //count = $fscanf ( hexFile, "%2h%4h%2h", byte_count, address, type); // THE ORIGINAL - does not work with ISE 12.1
        count = $fscanf ( hexFile, "%h", buffer);
        byte_count = buffer[0:7];
        address    = buffer[8:23];
        type       = buffer[24:31];
		  
        if (type == 1)
          // It's an end record; we can stop
          disable ReadHexFile;

        // Scan the data part of the record
        //
        $display ( "Note - Loading %0d bytes at address %h", byte_count, address );
        n = 32;
        for ( i = 0; i < byte_count; i = i + 1 )
          // Pick up just one byte and put it in the correct place
        begin
          //count = $fscanf ( hexFile, "%2h", HexFileContents[address + i] ); // THE ORIGINAL - does not work with ISE 12.1
          // for ( j = 0; j < 8; j = j + 1)
          //   b[j] = buffer[n + j];
          b = buffer[n+:8];       
          HexFileContents[address + i] = b;
		    n = n + 8;
        end

        // Scan and ignore the checksum
        //
        count = $fscanf ( hexFile, "%2h", cksum );

      end // ReadHexRecord

    end // ReadHexFile

    $fclose ( hexFile );

    // Create a new file "data.mem".  Write the contents of
    // variable HexFileContents to this file, in a format
    // suitable for reading back in using $readmemb.
    // Remember to close the file when you've finished writing
    // it, because you will soon need to read it again (below).
    //
    memFile = $fopen ( "data.mem" );
    for (i = 0; i < Amax; i = i + 1)
      $fdisplay ( memFile, "%b", HexFileContents[i] );
    $fclose ( memFile );

    // Use $readmemb to read the contents of our file of
    // expected values, "reference.mem", into array variable
    // RefFileContents.  Similarly, read back the contents of
    // your own output file "data.mem" into array variable
    // MemFileContents.
    //
    $readmemb ( "reference.mem", RefFileContents );
    $readmemb ( "data.mem",      MemFileContents );

    // Compare the three arrays byte-by-byte as a check that your
    // file format conversion worked correctly.  Use the "==="
    // or "!==" operator to test for equality, so that X bits
    // are checked correctly.
    //
    mismatchCount = 0;
    for (i = 0; i < Amax; i = i + 1) begin
      if (    (MemFileContents[i] !== HexFileContents[i])
           || (RefFileContents[i] !== HexFileContents[i]) )
      begin
        mismatchCount = mismatchCount + 1;
        $display ( "Mismatch at address 'h%0h: ref='h%h, hex='h%h, mem='h%h",
               i, RefFileContents[i], HexFileContents[i], MemFileContents[i] );
      end
    end
    $display ( "Comparison completed with %0d mismatches", mismatchCount );

  end // FileFormatConverter

endmodule
