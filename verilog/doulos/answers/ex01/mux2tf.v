// Comprehensive Verilog version 7 ANSWERS exercise 1
// Test fixture "mux2tf" for 2-to-1 multiplexer

// Corrections to the code are marked with comments
// like this   //*

module mux2tf;

  // Signals to connect to the "mux2" module being tested
  //
  reg sel;
  reg a, b;
  //* reg f;
  wire f;  //* Output of a module instance must be
           //* connected to a wire, not to a reg

  // There are 27 interesting combinations of the three
  // inputs a, b, sel - each can be 0, 1 or X.
  // To get an X on to any of these signals we must
  // use the value 1'bX - more details in the next section!

                                  // sel
                                  // |a
                                  // ||b
  initial begin //* Missing begin // ~~~
                                  // XXX  (initial value)
    #10 sel = 0; a = 0; b = 0;    // 000  //* Commas should be semicolons
    #10 sel = 1;                  // 100
    #10 sel = 1'bX;               // X00
    #10 sel = 0; b = 1;           // 001
    #10 sel = 1;                  // 101
    #10 sel = 1'bX;               // X01
    #10 sel = 0; b = 1'bX;        // 00X
    #10 sel = 1;                  // 10X
    #10 sel = 1'bX;               // X0X  //* Fixed backtick on 1`bX
    #10 sel = 0; a = 1; b = 0;    // 010
    #10 sel = 1;                  // 110
    #10 sel = 1'bX;               // X10  //* Missing semicolon
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

  end  //* Missing end

  // Instance of the module under test
  //
  //* Missing instance name!
  //* mux2 DUT (a, b, f, sel);  //* Port ordering incorrect -
  //* use named mapping or correct order
  //* mux2 DUT (sel, a, b, f);  //* this would be OK
  mux2 DUT ( .a(a), .b(b), .f(f), .sel(sel) );  //* this is better

  // Monitoring code to generate output
  //
  initial  //* Missing initial
    $monitor($time,,sel,,a,b,,f);

//* end  //* should be "endmodule"
endmodule
