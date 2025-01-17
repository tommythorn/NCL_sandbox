/////////////////////////////
// NCL sandbox
// four stage single rail pipeline
// Karl Fant July 2015
/////////////////////////////

`timescale 10ps / 1ps

module pipeline1;

wire  A, B, C, D, E;
wire ACOMP, BCOMP, CCOMP, DCOMP, ECOMP;
reg init = 0;
  /* Make an init that pulses once. */
 initial begin
     # 0 init = 1;
     # 20 init = 0;
     # 1000 $stop;
  end
initial
 begin
    $dumpfile("pipeline1.vcd");
    $dumpvars(0,pipeline1);
 end

///// Testbench
/////////////////////////////
///// Circuit Under Test

THnotN  A0(A, ACOMP, init); // auto produce A input

// 4 stage pipeline
Pipecomponent u1(B, BCOMP, A, ACOMP, init);
Pipecomponent u2(C, CCOMP, B, BCOMP, init);
Pipecomponent u3(D, DCOMP, C, CCOMP, init);
Pipecomponent u4(E, ECOMP, D, DCOMP, init);

assign ECOMP = E;  // auto consume E output
endmodule

module Pipecomponent(output Z, input ZCOMP, input A, output ACOMP, input init);
wire  enable;
THnotN  u0(enable, ZCOMP, init);
TH22  u1(Z, A, enable);
assign ACOMP = Z;
endmodule
