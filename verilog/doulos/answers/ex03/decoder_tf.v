// Comprehensive Verilog version 7 ANSWERS exercise 3

// Test fixture for 2-to-4-line decoder

module decoder_tf;

  // Variables to connect to DUT inputs
  //
  reg  [1:0] T_a;
  reg        T_active_low;

  // Nets to connect to DUT outputs
  //
  wire [3:0] T_y;

  // DUT instance
  //
  decoder DUT ( .a(T_a), .active_low(T_active_low), .y(T_y) );

  // Test stimulus generator
  //
  initial begin
    // First round of testing - active-high outputs
    T_active_low = 1'b0;
    T_a = 2'b00;
    #10
    T_a = 2'b01;
    #10
    T_a = 2'b10;
    #10
    T_a = 2'b11;
    #10
    // Second round of testing - active-low outputs
    T_active_low = 1'b1;
    T_a = 2'b00;
    #10
    T_a = 2'b01;
    #10
    T_a = 2'b10;
    #10
    T_a = 2'b11;
    #10;
    // That's All Folks
  end // test stimulus

  // Monitoring
  //
  initial
    $monitor(T_a[1], T_a[0],, T_active_low,, T_y[3], T_y[2], T_y[1], T_y[0]);

endmodule
