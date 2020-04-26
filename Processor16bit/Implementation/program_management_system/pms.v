`timescale 1ns / 1ps

module pms(
	 input clk,
	 input restore,
	 input reset,
    input writePC,
    input writeRA,
    input PCsrc,
    input ImRPC,
    input Memsrc,
    input MemW1,
    input MemW2,
    input MemR1,
    input MemR2,
    input conditionalBop,
	 input [15:0] RArestore,
    input [15:0] a2_1,
    input [15:0] write2,
    output [15:0] IR,
    output [15:0] ImR,
    output [15:0] Memout,
	 output [15:0] RA
    );
	 
	 wire [15:0] PCwire, PC_1wire, ImRwire;
	 
pcs prog_count_sys (
	 .clk(clk),
	 .restore(restore),
	 .reset(reset),
    .writePC(writePC),
    .writeRA(writeRA),
    .PCsrc(PCsrc),
    .ImRPC(ImRPC),
    .conditionalBop(conditionalBop),
	 .RArestore(RArestore),
    .ImR(ImRwire),
    .PC(PCwire),
    .PC_1(PC_1wire),
	 .RA(RA)
	);
	
mms mem_mgmt_sys (
	 .clk(clk),
    .w1(MemW1),
    .w2(MemW2),
	 .r1(MemR1),
    .r2(MemR2),
	 .Memsrc(Memsrc),
    .a1(PCwire),
    .a2_0(PC_1wire),
    .a2_1(a2_1),
    .write2(write2),
    .IR(IR),
    .ImR(ImRwire),
    .Memout(Memout)
	);
	
	assign ImR = ImRwire;


endmodule
