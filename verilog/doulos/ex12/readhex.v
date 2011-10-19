// Comprehensive Verilog version 7 exercise 12
//
// File reading/writing exercise

`timescale 1ns/1ns

module ReadHex;

  // This parameter determines the highest-numbered address
  // that you are prepared to read from the Hex file.
  //
  parameter Amax = 100;

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
  reg [7:0] MyFileContents [0:Amax-1];
  integer count;
  integer index = 0;
  integer towrite = 0;
  integer ifile_desc = 0;
  integer ofile_desc;
  integer rfile_desc; // The readmem reference file
  reg ok = 0; // 1 for ok, 0 for not ok
  integer dumchar;

  // Since this is just one single piece of software,
  // it can all go into one single "initial" block.
  //
  initial begin : FileFormatConverter
    // Open the file "data.hex", which is in Intel Hex format.
    // Read its contents into the array variable HexFileContents.
    //
    // *********** ADD YOUR CODE HERE *************
	 ifile_desc = $fopen("data.hex","r");
	 if ( !ifile_desc ) begin
	     $display("Error: data.hex cannot be opened.");
		  $finish;
	 end
	 
	 // Scan for the start code
	 begin : findcolon
	     forever begin
           dumchar = $fgetc( ifile_desc );
           if (dumchar == -1) disable findcolon; // end of file
           if (dumchar == ":") disable findcolon;			  
		  end		  
	 end
	 // Now we found the start code and the file pointer points
	 // immediately after it.
	 
	 begin : readlines
	     integer byte_count;
		  integer address;
		  integer type;
		  integer checksum;
	     forever begin
			  count = $fscanf( ifile_desc, "%2h%4h%2h", byte_count,
					address, type);
			  if (count == -1) disable readlines;
			  for ( index = 0; index < byte_count; index = index + 1)
					count = $fscanf( ifile_desc, "%2h", HexFileContents[address+index]);
			  count = $fscanf( ifile_desc, "%2h", checksum);
		  end
	 end
	 $finish;
    // Create a new file "data.mem".  Write the contents of
    // array variable HexFileContents to this file, in a
    // format suitable for reading back in using $readmemb.
    // Remember to close the file when you've finished writing
    // it, because you will soon need to read it again (below).
    //
    // *********** ADD YOUR CODE HERE *************
	 ofile_desc = $fopen("data.mem","w");
	 index = 0;
	 forever begin : writelines
	     if ( index != towrite ) begin
		      $fwrite( ofile_desc,HexFileContents[index] );
				index = index + 1;
				$display("%d",index);
		  end
		  else begin
		      $fclose( ofile_desc );
		      disable writelines;
		  end
	 end

    // Use $readmemb to read the contents of our file of
    // expected values, "reference.mem", into array variable
    // RefFileContents.  Similarly, read back the contents of
    // your own output file "data.mem" into array variable
    // MemFileContents.
    //
    // *********** ADD YOUR CODE HERE *************
	 rfile_desc = $fopen("reference.mem","r");
	 if ( !rfile_desc ) begin
	     $display("Error: reference.mem cannot be opened.");
		  $finish;
	 end
	 $readmemb("reference.mem",RefFileContents); // Hope this works
	 $readmemb("data.mem",MyFileContents);
    
	 // Compare the three arrays byte-by-byte as a check that your
    // file format conversion worked correctly.  Use the "==="
    // or "!==" operator to test for equality, so that X bits
    // are checked correctly.
    //
    // *********** ADD YOUR CODE HERE *************
	 for (index = 0; index < Amax; index = index + 1) begin
	     if ((RefFileContents[index] === HexFileContents[index]) &&
		     (RefFileContents[index] === MyFileContents[index])) begin
		      $display("Reference and file contents are ok");
				ok = 1;
		  end  
	 end

  end // FileFormatConverter

endmodule
