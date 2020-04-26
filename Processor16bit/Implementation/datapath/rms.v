`timescale 1ns / 1ps

module rms(
	 input clk,
    input [15:0] IR,
    input [15:0] ImR,
    input [15:0] w2_1,
	 input [15:0] w2_2,
    input AltB,
    input writeCR, // controls mux_1_bit
    input [1:0] Regsrc, // controls mux_2_bit
    input RegR1,
    input RegR2,
    input RegW1,
    input RegW2,
    input restore,
    input [239:0] fcIn,
	 input [15:0] ioIn,
    input cmpne,
    input cmpeq,
	 output [15:0] ioOut,
    output [3:0] op,
    output [239:0] fcOut,
    output [15:0] A,
    output [15:0] B,
    output cmp_result
    );
	 
	 wire [15:0] writeCR_mux_wire, regsrc_mux_wire;
	 wire [14:0] zero_15 = 0;
	 wire [9:0] zero_10 = 0;
	 wire [15:0] const_cr = 57;
	 
regfile16b64 regfile(
	.a1(writeCR_mux_wire),
	.a2({zero_10, IR[5:0]}),
	.w1({zero_15, AltB}),
	.w2(regsrc_mux_wire),
	.fcIn(fcIn),
	.ioIn(ioIn),
	.w1Control(RegW1),
	.w2Control(RegW2),
	.r1Control(RegR1),
	.r2Control(RegR2),
	.restore(restore),
	.clk(clk),
	.r1(A),
	.r2(B),
	.ioOut(ioOut),
	.fcOut(fcOut)
	);
	
mux_1_bit reg_a1_src (
	.A({zero_10, IR[11:6]}),
	.B(const_cr),
	.S(writeCR),
	.R(writeCR_mux_wire)
	);

mux_2_bit reg_w2_src (
  .A(ImR),
  .B(w2_1),
  .C(w2_2),
  .D(A),
  .S(Regsrc),
  .R(regsrc_mux_wire)
);

comparator comp(
  .A(A),
  .B(B),
  .cmpeq(cmpeq),
  .cmpne(cmpne),
  .R(cmp_result)
  );

	assign op = IR[15:12];
	
endmodule
