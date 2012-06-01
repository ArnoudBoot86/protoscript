// Comprehensive Verilog version 7 exercise 6

// Test fixture for MinMax exercise

`timescale 1 ns / 1 ns

module MinMaxtf;

  // Connections to DUT
  //
  // *********** ADD YOUR CODE HERE *************
  reg [0:3] xin;
  reg [0:3] yin;
  reg minmax;
  wire [0:3] zout;

  // DUT instance
  //
  // *********** ADD YOUR CODE HERE *************
  MinMax dut(.X(xin),.Y(yin),.Min0Max1(minmax),.Z(zout));

  // Code to initialise inputs and cycle through
  // all possible values
  //
  // *********** ADD YOUR CODE HERE *************


  // Monitoring and test termination control
  //
  initial
  begin : blk
    // *********** ADD YOUR CODE HERE *************
	 integer count, incount;
	 minmax = 0;
	 for (count = 0; count < 16; count = count + 1) begin
	     #10;
	     xin = count;
		  for (incount = 0; incount < 16; incount = incount + 1) begin
		      #10;
		      yin = incount;
		  end
	 end
	 
	 $display ("Got here");
	 minmax = 1;
	 for (count = 0; count < 16; count = count + 1) begin
	     #10;
	     xin = count;
		  for (incount = 0; incount < 16; incount = incount + 1) begin
		      #10;
		      yin = incount;
		  end
	 end
  end
  
  initial begin 
		#0;
		$timeformat(-9,1,"ns",7);
		$display("Time MinMax X Y Output");
      $monitor("%t",$time,,"%b",minmax,"%d",xin,,"%d",yin,,"%d",zout);
  end

endmodule
