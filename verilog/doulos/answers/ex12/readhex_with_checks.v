// Comprehensive Verilog version 7 ANSWERS exercise 12
//
// File reading/writing exercise - enhanced version
// (If You Have Time) with better error checking in the
// Hex file reader

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

      recordCount = 0;
      errorCount = 0;
      warningCount = 0;

      forever begin : ReadHexRecord

        integer count, startChar;
        reg [7:0] type, byte_count, cksum;
        reg [15:0] address;

        reg [0:42*4-1] buffer;
        integer j, n;
        reg [0:7] b;

        // Scan through the file (including blank lines)
        // until we find a ":" character starting a Hex record
        //
        begin : FindColon
          forever begin
            startChar = $fgetc ( hexFile );
            if (startChar == EOF) begin // we're finished
              $display ( "WARNING - EOF found before end record" );
              warningCount = warningCount + 1;
              disable ReadHexFile;
            end else if (startChar == ":") // found a Hex record
              disable FindColon;
          end
        end // FindColon

        // Scan the first, fixed-format part of the record
        //
        recordCount = recordCount + 1;
        //count = $fscanf ( hexFile, "%2h%4h%2h", byte_count, address, type);
        count = $fscanf ( hexFile, "%h", buffer);
       if (count == EOF) begin
          $display ( "ERROR - Unexpected EOF in start of hex record" );
          errorCount = errorCount + 1;
          disable ReadHexFile;
        end //else if (count != 3) begin  // ISE 12.1 won't allow this check as we have to
		      // read in the complete buffer, not just the header.
          //$display ( "WARNING - Bad format in start of hex record" );
          //warningCount = warningCount + 1;
          //disable ReadHexRecord;
        //end

        byte_count = buffer[0:7];
        address    = buffer[8:23];
        type       = buffer[24:31];

        if (type == 1) begin
          $display ( "Note - End record found" );
          disable ReadHexFile;
        end
        if (type != 0) begin
          $display ( "WARNING - Unsupported record type 'h%h skipped", type );
          warningCount = warningCount + 1;
          disable ReadHexRecord;  // Go back to scanning for ":"
        end


        // Scan the data part of the record
        //
        $display ( "Note - Loading %0d bytes at address %h", byte_count, address );
        n = 32;
        for ( i = 0; i < byte_count; i = i + 1 ) begin
          //count = $fscanf ( hexFile, "%2h", HexFileContents[address + i] ); // THE ORIGINAL - does not work with ISE 12.1
          b = buffer[n+:8];       
          HexFileContents[address + i] = b;
          n = n + 8;
          //if (count == EOF) begin
          //  $display ( "ERROR - Unexpected EOF in data field of hex record" );
          //  errorCount = errorCount + 1;
          //  disable ReadHexFile;
          //end else if (count != 1) begin
          //  $display ( "WARNING - Bad format in data field of hex record" );
          //  warningCount = warningCount + 1;
          //  disable ReadHexRecord;
          //end
        end

        // Scan and ignore the checksum
        //
        count = $fscanf ( hexFile, "%2h", cksum );
        if (count == EOF) begin
          $display ( "ERROR - Unexpected EOF in check field of hex record" );
          errorCount = errorCount + 1;
          disable ReadHexFile;
        end else if (count != 1) begin
          $display ( "WARNING - Bad format in check field of hex record" );
          warningCount = warningCount + 1;
          disable ReadHexRecord;
        end

      end // ReadHexRecord

    end // ReadHexFile

    $fclose ( hexFile );

    $display ( "Read hex file done: %0d records ", recordCount,
               "with %0d warnings ", warningCount,
               "and %0d errors", errorCount );
    if (errorCount > 0) $stop;


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
