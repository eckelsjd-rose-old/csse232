`timescale 1ns / 1ps

module mms(
	 input clk,
    input w1,
    input w2,
    input r1,
    input r2,
	 input Memsrc,
    input [15:0] a1,
    input [15:0] a2_0,
    input [15:0] a2_1,
    input [15:0] write2,
    output [15:0] IR,
    output [15:0] ImR,
    output [15:0] Memout
    );
	 
	 wire [15:0] a2, readOut2;
	 
mux_1_bit a2_src (
	.A(a2_0),
	.B(a2_1),
	.S(Memsrc),
	.R(a2)
	);
	
amemory16x1k memory (
	.W1(16'b000000000000000),
	.W2(write2),
	.R1(IR),
	.R2(readOut2),
	.A1(a1),
	.A2(a2),
	.Write1(w1),
	.Write2(w2),
	.Read1(r1),
	.Read2(r2),
	.clk(clk)
	);
	
	assign Memout = readOut2;
	assign ImR = readOut2;
	
	
	 



endmodule
