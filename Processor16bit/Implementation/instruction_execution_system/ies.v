`timescale 1ns / 1ps

module ies(
    input clk,
    input backup,
    input restore,
    input writeCR,
    input [1:0] Regsrc,
    input cmpeq,
    input cmpne,
    input RegR1,
    input RegR2,
    input RegW1,
    input RegW2,
    input ALUsrc,
    input [2:0] ALUop,
    input [15:0] RAIn,
    input [15:0] IR,
    input [15:0] ImR,
    input [15:0] w2_1,
    input [15:0] ioIn,
	 output [3:0] op,
    output [15:0] ioOut,
    output [15:0] B,
    output [15:0] ALUout,
    output cmp_result,
    output [15:0] RAOut
    );
	 
	 wire AltB_wire;
	 
	 wire [15:0] ALUsrc_0, A_wire;

dms data_mgmt_sys (
    .clk(clk),
    .backup(backup),
    .restore(restore),
	 .cmpeq(cmpeq),
	 .cmpne(cmpne),
    .RegW1(RegW1),
    .RegW2(RegW2),
    .RegR1(RegR1),
    .RegR2(RegR2),
    .writeCR(writeCR),
	 .w1(AltB_wire),
    .Regsrc(Regsrc),
    .ioIn(ioIn),
	 .RAIn(RAIn),
    .IR(IR),
    .ImR(ImR),
    .w2_1(w2_1),
    .w2_2(ALUout),
    .op(op),
	 .RAOut(RAOut),
    .ImROut(ALUsrc_0),
    .ioOut(ioOut),
    .A(A_wire),
    .B(B),
	 .cmp_result(cmp_result)
	);
	
arithmetic_logic_system meth (
    .A(A_wire),
    .B(B),
    .Imm(ALUsrc_0),
    .ALUsrc(ALUsrc),
    .ALUop(ALUop),
	 .clk(clk),
    .AltB(AltB_wire),
    .ALUout(ALUout)
	);



endmodule
