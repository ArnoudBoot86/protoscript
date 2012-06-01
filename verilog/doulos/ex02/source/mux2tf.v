// Comprehensive Verilog version 7 exercise 1
// Test fixture "mux2tf" for 2-to-1 multiplexer

// THIS CODE CONTAINS ERRORS THAT DELEGATES SHOULD FIX

module mux2tf;

  // Signals to connect to the "mux2" module being tested
  //
  reg sel;
  reg a, b;
  wire f;

  // There are 27 interesting combinations of the three
  // inputs a, b, sel - each can be 0, 1 or X.
  // To get an X on to any of these signals we must
  // use the value 1'bX - more details in the next section!

                                  // sel
                                  // |a
                                  // ||b
	initial                         // ~~~
		begin                              // XXX  (initial value)
		#10; 
			sel = 0; // 000
			a = 0; 
			b = 0;	
		#10; 
			sel = 1;                  // 100
    #10 sel = 1'bX;               // X00
    #10 sel = 0; b = 1;           // 001
    #10 sel = 1;                  // 101
    #10 sel = 1'bX;               // X01
    #10 sel = 0; b = 1'bX;        // 00X
    #10 sel = 1;                  // 10X
    #10 sel = 1'bX;               // X0X
    #10 sel = 0; a = 1; b = 0;    // 010
    #10 sel = 1;                  // 110
    #10 sel = 1'bX;                // X10
    #10 sel = 0; b = 1;           // 011
    #10 sel = 1;                  // 111
    #10 sel = 1'bX;               // X11
    #10 sel = 0; b = 1'bX;        // 01X
    #10 sel = 1;                  // 11X
    #10 sel = 1'bX;               // X1X
    #10 sel = 0; a = 1'bX; b = 0; // 0X0
    #10 sel = 1;                  // 1X0
    #10 sel = 1'bX;               // XX0
    #10 sel = 0; b = 1;           // 0X1
    #10 sel = 1;                  // 1X1
    #10 sel = 1'bX;               // XX1
    #10 sel = 0; b = 1'bX;        // 0XX
    #10 sel = 1;                  // 1XX
    #10 sel = 1'bX;               // XXX
	end

  // Instance of the module under test
  //
  mux2 m (.a(a), .b(b), .f(f), .SEL(sel));

  // Monitoring code to generate output
  //
  initial begin
  $monitor($time,,sel,,a,b,,f);
  end


endmodule
