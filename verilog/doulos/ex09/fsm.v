// Comprehensive Verilog version 7 exercise 9

// Template for FSM Exercise

`timescale 1ns/1ns

module fsm (
    input Crystal, nSysReset,
    input [1:2] Buttons,
    output reg WatchRunning, WatchReset
  );
  
    localparam [8:0] zero = 8'b1,
	                  start = 8'b10,
							running = 8'b100,
							stop = 8'b1000,
							stopped = 8'b10000,
							reset = 8'b100000;
	 reg [8:0] state;
	 
	 always @(posedge Crystal, negedge nSysReset) begin
	     if (nSysReset == 0) begin
		      state <= zero;
		      WatchRunning <= 0;
				WatchReset <= 0;
		  end
		  else
	     case (state)
		      zero : if (Buttons[1] == 1) begin
				           state <= start;
							  WatchRunning <= 1;
							  WatchReset <= 0;
						 end
						 else if (Buttons[1] == 0) begin
						     WatchRunning <= 0;
							  WatchReset <= 0;
						 end
				start : if (Buttons == 2'b00) begin
				            state <= running;
							   WatchRunning <= 1;
							   WatchReset <= 0;
						  end
				running : if (Buttons[1] == 1) begin
				              state <= stop;
								  WatchRunning <= 0;
							     WatchReset <= 0;
							 end
				stop : if (Buttons == 2'b00) begin
				           state <= stopped;
							  WatchRunning <= 0;
							  WatchReset <= 0;
						 end
				stopped : if (Buttons == 2'b01) begin
				              state <= reset;
				              WatchRunning <= 0;
							     WatchReset <= 1;
							 end
							 else if (Buttons[1] == 1) begin
							     state <= start;
								  WatchRunning <= 1;
							     WatchReset <= 0;
							 end
				reset : if (Buttons == 2'b00) begin
				            state <= zero;
								WatchRunning <= 0;
							   WatchReset <= 0;
						  end
		  endcase
	 end
	 
	                  


endmodule

