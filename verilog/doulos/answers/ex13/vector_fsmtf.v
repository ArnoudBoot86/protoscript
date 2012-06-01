// Comprehensive Verilog version 7 ANSWERS exercise 13
// Test Fixture for Vector-file Test Fixture Exercise

`timescale 1 ns / 1 ns

module vector_fsmtf;

  // Connections to DUT
  //
  reg Crystal, nSysReset;
  reg [1:2] Buttons;
  wire WatchRunning, WatchReset;


  // Test fixture control StopClock:
  //   starts false; but when test driver wants to
  //   stop the simulation, it should set StopClock=1
  //
  reg StopClock;


  // ~~~~~~~~~~~~~~~ DECLARATIONS FOR THE TEST SOFTWARE ~~~~~~~~~~~
  //
  integer fd;            // file descriptor
  integer numVectors;    // count the vectors we apply
  integer numErrors;     // count how many times the DUT output mismatches
  integer numLines;      // count lines in the vector file (just for debug)

  // Variables to hold values taken from a line in the vector file
  //
  reg vec_nSysReset;
  reg [1:2] vec_Buttons;
  reg [1:0] exp_Outputs; // {WatchRunning, WatchReset}

  reg Finished;


  // ~~~~~~~~~~~~~~~~~~~~~ CLCCK GENERATOR ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //
  parameter Period = 10;
  //
  initial begin : ClockOscillator
    StopClock = 0;
    Crystal = 0;
    while ( !StopClock )
      #(Period/2) Crystal = !Crystal;
  end


  // ~~~~~~~~~~~~~~~~~~~~~~~ DUT INSTANCE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //
  fsm F (Crystal, nSysReset, Buttons, WatchRunning, WatchReset);


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TASKS ~~~~~~~~~~~~~~~~~~~~~~~~

  // * open the vector file
  task OpenFile;
    begin
      fd = $fopen("vectors.txt", "r");
      if (!fd) begin
        // Couldn't open the file
        $display("FAILURE: Could not open file vectors.txt");
        Finished = 1;
      end
    end
  endtask // OpenFile


  // * read a vector from the file, setting Finished=1 if end-of-file.
  //   Keep reading lines from the file until we get a vector.
  //
  task ReadVector;

    integer count;
    reg [7:0] command;
    reg [0:1000] line;

    begin : ScanForVector

      forever begin : ScanOneLine
        // Disabling ScanOneLine will abandon processing of the
        // current line from the file, so that this "forever" loop
        // will then proceed to processing the next line

        count = $fgets ( line, fd );
        if (count == 0) begin // failed to read a line
          // End-of-file or some other problem - set Finished and exit
          Finished = 1;
          disable ScanForVector;
        end  // failed to read a line

        // We got a line of text.  Count it and start to process it:

        numLines = numLines + 1;

        count = $sscanf ( line, " %c", command );  // NOTE space before %c
        if (count != 1) // It's a blank line!
          disable ScanOneLine;

        // We got an initial character; test it

        if (command != "V") // It's not a vector! Just ignore it.
          disable ScanOneLine;

        // We know it's a line beginning with "V".
        // Try to get the data.  Read the command again -
        // that's easier than trying to skip over it.

        count = $sscanf( line, " %c%b%b%b", // NOTE space before %c
                                  command,  // we don't care about this one
                                    vec_nSysReset,
                                      vec_Buttons,
                                        exp_Outputs );

        if (count != 4) begin // Bad vector data
          // something went wrong
          $display ( "WARNING: Skipping bad vector format in line %0d", numLines );
          disable ScanOneLine;
        end

        // It was valid data, so we can exit with Finished still zero -
        // vector values have already been loaded, by the $sscanf above.
        // You could easily add a diagnostic here to display the vector.
        //
        $display ( "NOTE: Got a vector on line %0d", numLines );
        disable ScanForVector;

      end // ScanOneLine

    end // ScanForVector

  endtask // ReadVector


  // * check output values from DUT against expected values from vector file
  task CheckResults;
    begin
      if ( {WatchRunning, WatchReset} !== exp_Outputs ) begin
        numErrors = numErrors + 1;
        $display("ERROR: got %b, expected %b",
                     {WatchRunning, WatchReset}, exp_Outputs);
      end
      numVectors = numVectors + 1;
    end
  endtask // CheckResults


  // * report errors, keep count of how many vectors were applied successfully
  //
  task PrintSummary;
    begin
      $display ( "Vector file contained %0d lines of text.", numLines );
      $display ( "Vectors successfully applied: %0d", numVectors );
      $display ( "ERRORS                      : %0d", numErrors );
    end
  endtask // PrintSummary


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MAIN PROGRAM ~~~~~~~~~~~~~~~~~~~~~~~~

  // * co-ordinate all this activity so that each vector in turn is
  //   applied to the DUT and checked, taking care to use sensible timing
  //   relative to the active clock edge
  //
  initial begin : VectorTester

    numVectors = 0;
    numErrors = 0;
    numLines = 0;
    Finished = 0;
    OpenFile;

    // Apply lots of vectors
    while ( !Finished ) begin
      // Get to inactive clock edge
      @(negedge Crystal)
      ReadVector;
      if (!Finished) begin // Run one vector
        // Get to just before the active clock edge
        #(Period/4)
        // Apply vectors
        Buttons = vec_Buttons;
        nSysReset = vec_nSysReset;
        // Get some way past the active clock edge
        #(Period/2)
        // Check outputs against expected values
        CheckResults;
      end // Run one vector
    end // while (!Finished)

    StopClock = 1;
    PrintSummary;

  end // VectorTester

endmodule
