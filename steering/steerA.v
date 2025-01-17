`timescale 10ps / 1ps

module steerA(output [1:0] Ss, input SCOMP, output [1:0] Ts, input TCOMP, output [1:0] Us, input UCOMP, output [1:0] Vs, input VCOMP, input [1:0] A, output ACOMP, input [3:0] steerin, output steerinCOMP, output [3:0] steerout, input steeroutCOMP, input init);

// 4 way steer component 
wire Sdone, Tdone, Udone, Vdone, Senable, Tenable, Uenable, Venable, StrCOMP, AACOMP;

THnotN  tbb2(Senable, SCOMP, init);
TH33  stu14(Ss[0], A[0], steerin[0], Senable);
TH33  stu24(Ss[1], A[1], steerin[0], Senable);
TH12  stu51(Sdone, Ss[0], Ss[1]);

THnotN  tbb3(Tenable, TCOMP, init);
TH33  stu15(Ts[0], A[0], steerin[1], Tenable);
TH33  stu25(Ts[1], A[1], steerin[1], Tenable);
TH12  stu61(Tdone, Ts[0], Ts[1]);

THnotN  tbb4(Uenable, UCOMP, init);
TH33  stu16(Us[0], A[0], steerin[2], Uenable);
TH33  stu26(Us[1], A[1], steerin[2], Uenable);
TH12  stu71(Udone, Us[0], Us[1]);

THnotN  tbb5(Venable, VCOMP, init);
TH33  stu17(Vs[0], A[0], steerin[3], Venable);
TH33  stu27(Vs[1], A[1], steerin[3], Venable);
TH12  stu81(Vdone, Vs[0], Vs[1]);

// pipeline the steer down the flow path
THnotN  tbb6(steerenable, steeroutCOMP, init);
TH22  stu35(steerout[0], steerin[0], steerenable);
TH22  stu36(steerout[1], steerin[1], steerenable);
TH22  stu37(steerout[2], steerin[2], steerenable);
TH22  stu38(steerout[3], steerin[3], steerenable);
TH14  stu31(AACOMP, Sdone, Tdone, Udone, Vdone);
TH14  stu32(StrCOMP, steerout[0], steerout[1], steerout[2], steerout[3]);
TH22  stu33 (steerinCOMP, AACOMP, StrCOMP);
assign ACOMP = steerinCOMP;
endmodule
