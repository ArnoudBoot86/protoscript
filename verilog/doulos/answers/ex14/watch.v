// Comprehensive Verilog version 7 ANSWERS exercise 14
// Solution to StopWatch Exercise

`timescale 1ns / 1ns

module Watch (
    input Crystal, nSysReset,
    input [1:2] Buttons,
    output reg [5:0] Mins, Secs
  );

  wire Running, Reset;

  fsm Controller (.Crystal(Crystal),
                  .nSysReset(nSysReset),
                  .Buttons(Buttons),
                  .WatchRunning(Running),
                  .WatchReset(Reset));

  // This always block increments and resets the minute and second counters...
  always @(posedge Crystal or negedge nSysReset)
  begin : Counters

    reg [3:0] Count;
    parameter Tmax = 59;

    if (!nSysReset)
    begin
      Count = 4'b0000;
      Secs <= 6'b000000;
      Mins <= 6'b000000;
    end
    else
      if (Running)
        if (Count < 9)
          // Count serves to divide the crystal clock down into seconds
          Count = Count + 1;
        else
        begin
          Count = 0;
          if (Secs < Tmax)
            Secs <= Secs + 1;
          else
          begin
            Secs <= 0;
            if (Mins < Tmax)
              Mins <= Mins + 1;
            else
              Mins <= 0;
          end
        end
      else if (Reset)
      begin
        Count = 0;
        Secs <= 0;
        Mins <= 0;
      end
  end

endmodule
