module logic (
    input in0,
    input in1,
    input in2,
    input in3,
    output out0,
    output out1,
    output out2,
    output out3
  );
  
  assign out0 = in0 & in1 & in2 & in3;
  assign out1 = in0 | in1 | in2 | in3;
  assign out2 = !(in0 & in1 & in2 & in3);
  assign out3 = in0 ^ in1 ^ in2 ^ in3;
  
endmodule  //logic
