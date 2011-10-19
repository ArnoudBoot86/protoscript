// Comprehensive Verilog version 7 ANSWERS exercise 3
// If You Have Time

// Test fixture for 3-to-4-line thermometer-code decoder

module thermocode_tf;

  // Variables to connect to DUT inputs
  //
  reg  [2:0] T_a;
  reg        T_active_low;

  // Nets to connect to DUT outputs
  //
  wire [3:0] T_y;
  wire       T_valid;

  // DUT instance
  //
  thermocode DUT ( .a(T_a), .active_low(T_active_low), .y(T_y), .valid(T_valid) );

  // Test stimulus generator
  //
  initial begin
    // First round of testing - active-high outputs
    T_active_low = 1'b0;
    T_a = 3'b000;
    #10
    T_a = 3'b001;
    #10
    T_a = 3'b010;
    #10
    T_a = 3'b011;
    #10
    T_a = 3'b100;
    #10
    T_a = 3'b101;
    #10
    T_a = 3'b110;
    #10
    T_a = 3'b111;
    #10
    // Second round of testing - active-low outputs
    T_active_low = 1'b1;
    T_a = 3'b000;
    #10
    T_a = 3'b001;
    #10
    T_a = 3'b010;
    #10
    T_a = 3'b011;
    #10
    T_a = 3'b100;
    #10
    T_a = 3'b101;
    #10
    T_a = 3'b110;
    #10
    T_a = 3'b111;
    #10;
    // That's All Folks
  end // test stimulus

  // Monitoring
  //
  initial
    $monitor(T_a[2], T_a[1], T_a[0],, T_active_low,,
             T_y[3], T_y[2], T_y[1], T_y[0],, T_valid);

endmodule
