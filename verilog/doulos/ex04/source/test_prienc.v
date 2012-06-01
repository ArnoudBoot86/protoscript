// Comprehensive Verilog version 7 exercise 4

// Test fixture for priority encoder

// Add an appropriate timescale directive here

module test_prienc;


  // DUT connections
  //
  // ~~~~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
  reg [3:0] a;
  wire [1:0] f;
    

  // Stimulus generator: simple binary upcount on a,
  // but don't forget the need to initialise it first!
  // Also, think about how to stop the test at an
  // appropriate time.
  //
  // ~~~~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
  initial begin
     a = 0;
     #10 a = a + 1;
	  #10 a = a + 1;
	  #10 a = a + 1;
	  #10 a = a + 1;
	  #10 a = a + 1;
	  #10 a = a + 1;
	  #10 a = a + 1;
	  #10 a = a + 1;
  end

  // Instance of device under test - 4-to-2 priority encoder
  //
  // ~~~~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
  prienc dut(.a(a),.f(f));

  // Monitoring
  //
  // ~~~~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
  initial begin 
		#0;
		$timeformat(-9,1,"ns",7);
		$display("Time Input(a) Output(f)");
      $monitor("%t",$time,,"%b",a,,"%b",f);
  end
endmodule
