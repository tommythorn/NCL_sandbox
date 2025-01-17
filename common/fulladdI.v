`timescale 10ps / 1ps

module fulladdI(output [1:0] sum, input sumCOMP, output [1:0] carryout, input carryCOMP, input [1:0] A, output ACOMP, input [1:0] B, output BCOMP, input [1:0] carryin, output carryinCOMP, input init);

// the textbook fullfadder 
// with data carry playahead but
// without null carry play ahead
wire Senable, Cenable;
wire [1:0] Ts, Tc;
THnotN  tbb3(Senable, sumCOMP, init);
TH55W22  u8(sum[0], Senable, carryout[1], carryin[0], B[0], A[0]);
TH55W22  u9(sum[1], Senable, carryout[0], carryin[1], B[1], A[1]);
THnotN  tbb4(Cenable, carryCOMP, init);
TH44W2  u18(carryout[0], Cenable, carryin[0], B[0], A[0]);
TH44W2  u19(carryout[1], Cenable, carryin[1], B[1], A[1]);
// sum link
//TH22  ob4 (sum[0], Ts[0], Senable);
//TH22  ob5 (sum[1], Ts[1], Senable);
// carry link
//TH22  ob6 (carryout[0], Tc[0], Cenable);
//TH22  ob7 (carryout[1], Tc[1], Cenable);
// closure
THCOMP u21 (ACOMP, sum[1], sum[0], carryout[1], carryout[0]);  
assign BCOMP = ACOMP;
assign carryinCOMP = ACOMP;
endmodule
