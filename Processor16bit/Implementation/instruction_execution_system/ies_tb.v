`timescale 1ns / 1ps

module ies_tb;

	// Inputs
	reg clk;
	reg backup;
	reg restore;
	reg writeCR;
	reg [1:0] Regsrc;
	reg cmpeq;
	reg cmpne;
	reg RegR1;
	reg RegR2;
	reg RegW1;
	reg RegW2;
	reg ALUsrc;
	reg [2:0] ALUop;
	reg [15:0] RAIn;
	reg [15:0] IR;
	reg [15:0] ImR;
	reg [15:0] w2_1;
	reg [15:0] ioIn;

	// Outputs
	wire [3:0] op;
	wire [15:0] ioOut;
	wire [15:0] B;
	wire [15:0] ALUout;
	wire cmp_result;
	wire [15:0] RAOut;

	// Instantiate the Unit Under Test (UUT)
	ies uut (
		.clk(clk), 
		.backup(backup), 
		.restore(restore), 
		.writeCR(writeCR), 
		.Regsrc(Regsrc), 
		.cmpeq(cmpeq), 
		.cmpne(cmpne), 
		.RegR1(RegR1), 
		.RegR2(RegR2), 
		.RegW1(RegW1), 
		.RegW2(RegW2), 
		.ALUsrc(ALUsrc), 
		.ALUop(ALUop), 
		.RAIn(RAIn), 
		.IR(IR), 
		.ImR(ImR), 
		.w2_1(w2_1), 
		.ioIn(ioIn), 
		.op(op), 
		.ioOut(ioOut), 
		.B(B), 
		.ALUout(ALUout), 
		.cmp_result(cmp_result), 
		.RAOut(RAOut)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		backup = 0;
		restore = 0;
		writeCR = 0;
		Regsrc = 0;
		cmpeq = 0;
		cmpne = 0;
		RegR1 = 0;
		RegR2 = 0;
		RegW1 = 0;
		RegW2 = 0;
		ALUsrc = 0;
		ALUop = 0;
		RAIn = 0;
		IR = 0;
		ImR = 0;
		w2_1 = 0;
		ioIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Write 2 values into registers A and B
		Regsrc = 0;
		writeCR = 0;
		IR = 0;
		ImR = 10;
		RegW2 = 1;
		#1;
		ImR = 20;
		IR = 1;
		#1;
		
		// Read regfile into A and B
		RegW2 = 0;
		IR = { 4'b0000, 6'b000000, 6'b000001 };
		RegR1 = 1;
		RegR2 = 1;
		#1;
		
		// Add A and B
		RegR1 = 0;
		RegR2 = 0;
		ALUsrc = 1;
		ALUop = 2;
		#1;
		
		// Store ALUout into reg 2
		Regsrc = 2;
		IR = 2;
		RegW2 = 1;
		#1;
		
		// Backup to fcache
		RegW2 = 0;
		backup = 1;
		#1;
		backup = 0;
		
		// Zero out values in registers
		Regsrc = 0;
		IR = 0;
		ImR = 0;
		RegW2 = 1;
		#1;
		IR = 1;
		#1;
		IR = 2;
		#1;
		RegW2 = 0;
		
		// restore register values
		restore = 1;
		#1;
		restore = 0;
		
		
		// check for correct values
		IR = 0;
		RegR2 = 1;
		#1;
		if (B == 10) $display("PASS: backup");
		else $display("FAIL: backup");
		
		IR = 1;
		#1;
		if (B == 20) $display("PASS: backup");
		else $display("FAIL: backup");
		
		IR = 2;
		#1;
		if (B == 30) $display("PASS: addition");
		else $display("FAIL: addition");

	end
	
	always clk = #0.5 ~clk;
      
endmodule

