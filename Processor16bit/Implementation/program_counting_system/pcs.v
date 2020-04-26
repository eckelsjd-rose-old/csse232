`timescale 1ns / 1ps


module pcs(
	 input clk,
	 input restore,
	 input reset,
    input writePC,
    input writeRA,
    input PCsrc,
    input ImRPC,
    input conditionalBop,
	 input [15:0] RArestore,
    input [15:0] ImR,
    output [15:0] PC,
    output [15:0] PC_1,
	 output [15:0] RA
    );
	 
	 wire[15:0] PC_1wire, PCsrcWire, RAwire, PCsrcOpt0, PCsrcOpt1;
	 reg[15:0] PCreg, RAreg, add1;
	 
adder_16_bit pcAdder(
	.A(PCreg),
	.B(add1),
	.R(PC_1wire)
	);
	
mux_1_bit RAsrcMux (
	.A(PC_1wire),
	.B(RArestore),
	.S(restore),
	.R(RAwire)
	);

mux_2_bit PCsrcMux(
	.A(PCsrcOpt0),
	.B(RAreg),
	.C(16'b0000000000000000),
	.D(16'b0000000000000000),
	.S({reset, PCsrc}),
	.R(PCsrcWire)
	);
	
mux_1_bit ImRMux(
	.A(PC_1wire),
	.B(ImR),
	.S(ImRPC | conditionalBop),
	.R(PCsrcOpt0)
	);
	
	assign PC = PCreg;
	assign PC_1 = PC_1wire;
	assign RA = RAreg;
	
	initial begin
		PCreg = 0;
		RAreg = 0;
		add1 = 1;
	end
	
	always @(posedge clk) begin
		if (writePC | conditionalBop) PCreg = PCsrcWire;
		if (writeRA) RAreg = RAwire;
		
	end
		


endmodule
