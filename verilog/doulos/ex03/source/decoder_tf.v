// Comprehensive Verilog version 7 exercise 3

// Test fixture for 2-to-4-line decoder

module decoder_tf;
	
  // Variables to connect to DUT inputs
  //
  // ~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
  reg [1:0] a;
  reg active_low;

  // Nets to connect to DUT outputs
  //
  // ~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
  wire [3:0] y;

  // DUT instance
  //
  // ~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
  decoder dut(.a(a),.y(y),.active_low(active_low));

  // Test stimulus generator
  //
  initial begin
    // ~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
	 #10 a[1] = 0; a[0] = 0; active_low = 0;
	 #20 a[1] = 0; a[0] = 1; active_low = 0;
	 
  end // test stimulus

  // Monitoring
  //
  initial begin
    // ~~~~~~~~~~~~~ ADD YOUR CODE HERE ~~~~~~~~~~~~~~~~
    $monitor($time,,a[1],,a[0],,active_low,,y[3],,y[2],,y[1],,y[0]);
  end

endmodule
