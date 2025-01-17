/////////////////////////////
// NCL sandbox
// four oscillation two rail pipeline
// Karl Fant July 2015
/////////////////////////////

`timescale 10ps / 1ps


module pipeline2;

 /* Make an init that pulses once. */
  reg init = 1;
  initial begin
     # 20 init = 0;
     # 1000 $stop;
  end
initial
 begin
    $dumpfile("pipeline2.vcd");
    $dumpvars(0,pipeline2);
 end

///// Testbench
/////////////////////////////
///// Circuit Under Test

wire [1:0] A, B, C, D, E;
wire ACOMP, BCOMP, CCOMP, DCOMP, ECOMP;

// 2 rail 4 oscillation pipeline
THnotN  A0(A[0], ACOMP, init); // auto produce A input
assign A[1] = 0;  // auto produce constant rail

Pipecomponent u1(B[1:0], BCOMP, A[1:0], ACOMP, init);
Pipecomponent u2(C[1:0], CCOMP, B[1:0], BCOMP, init);
Pipecomponent u3(D[1:0], DCOMP, C[1:0], CCOMP, init);
Pipecomponent u4(E[1:0], ECOMP, D[1:0], DCOMP, init);

TH12 u5 (ECOMP, E[0], E[1]);  // auto consume E output
endmodule

module Pipecomponent(output [1:0] Z, input ZCOMP, input [1:0] A, output ACOMP, input init);
wire enable;
THnotN  u0(enable, ZCOMP, init);
TH22  u1(Z[0], A[0], enable);
TH22  u2(Z[1], A[1], enable);
TH12 u5 (ACOMP, Z[0], Z[1]);
endmodule

