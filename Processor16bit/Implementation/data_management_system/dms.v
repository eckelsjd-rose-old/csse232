`timescale 1ns / 1ps

module dms(
    input clk,
    input backup,
    input restore,
	 input cmpeq,
	 input cmpne,
    input RegW1,
    input RegW2,
    input RegR1,
    input RegR2,
    input writeCR,
	 input w1,
    input [1:0] Regsrc,
    input [15:0] ioIn,
	 input [15:0] RAIn,
    input [15:0] IR,
    input [15:0] ImR,
    input [15:0] w2_1,
    input [15:0] w2_2,
    output [3:0] op,
	 output [15:0] RAOut,
    output [15:0] ImROut,
    output [15:0] ioOut,
    output [15:0] A,
    output [15:0] B,
	 output cmp_result
    );
	 
	 wire [239:0] backup_wire, restore_wire;
	 
rms reg_mgmt_sys (
	.clk(clk),
	.IR(IR),
	.ImR(ImR),
	.w2_1(w2_1),
	.w2_2(w2_2),
	.AltB(w1),
	.writeCR(writeCR),
	.Regsrc(Regsrc),
	.RegR1(RegR1),
	.RegR2(RegR2),
	.RegW1(RegW1),
	.RegW2(RegW2),
	.restore(restore),
	.fcIn(restore_wire),
	.ioIn(ioIn),
	.cmpeq(cmpeq),
	.cmpne(cmpne),
	.ioOut(ioOut),
	.op(op),
	.fcOut(backup_wire),
	.A(A),
	.B(B),
	.cmp_result(cmp_result)
	);
	
fbs fcache_back_sys (
	.clk(clk),
	.backup(backup),
	.restore(restore),
	.dataIn({RAIn, backup_wire}),
	.dataOut({RAOut, restore_wire})
	);
	
	assign ImROut = ImR;
	

endmodule
