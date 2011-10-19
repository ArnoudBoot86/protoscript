// Comprehensive Verilog version 7 exercise 3

// 2-to-4-line decoder with programmable output polarity


module decoder ( input [1:0] a, input active_low, output [3:0] y );

  // FILL IN YOUR CODE HERE
	wire and1, and2, and3, and4; // AND gate outputs
	
	assign and1 = ~a[0] & ~a[1];
	assign and2 = a[0] & ~a[1];
	assign and3 = ~a[0] & a[1];
	assign and4 = a[0] & a[1];
	xor(y[0],and1,active_low);
	xor(y[1],and2,active_low);
	xor(y[2],and3,active_low);
	xor(y[3],and4,active_low);
	
endmodule
