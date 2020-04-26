`timescale 1ns / 1ps


module dms_tb_0;

	// Inputs
	reg clk;
	reg backup;
	reg restore;
	reg cmpeq;
	reg cmpne;
	reg RegW1;
	reg RegW2;
	reg RegR1;
	reg RegR2;
	reg writeCR;
	reg w1;
	reg [1:0] Regsrc;
	reg [15:0] ioIn;
	reg [15:0] RAIn;
	reg [15:0] IR;
	reg [15:0] ImR;
	reg [15:0] w2_1;
	reg [15:0] w2_2;

	// Outputs
	wire [3:0] op;
	wire [15:0] RAOut;
	wire [15:0] ioOut;
	wire [15:0] A;
	wire [15:0] B;
	wire cmp_result;
	wire [15:0] ImROut;
	wire [239:0] fcOut;

	// Instantiate the Unit Under Test (UUT)
	dms uut (
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
		.w1(w1), 
		.Regsrc(Regsrc), 
		.ioIn(ioIn), 
		.RAIn(RAIn), 
		.IR(IR), 
		.ImR(ImR), 
		.w2_1(w2_1), 
		.w2_2(w2_2), 
		.op(op), 
		.RAOut(RAOut), 
		.ImROut(ImROut), 
		.ioOut(ioOut), 
		.A(A), 
		.B(B), 
		.cmp_result(cmp_result),
		.fcOut(fcOut)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		backup = 0;
		restore = 0;
		cmpeq = 0;
		cmpne = 0;
		RegW1 = 0;
		RegW2 = 0;
		RegR1 = 0;
		RegR2 = 0;
		writeCR = 0;
		w1 = 0;
		Regsrc = 0;
		ioIn = 0;
		RAIn = 0;
		IR = 0;
		ImR = 0;
		w2_1 = 0;
		w2_2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		RAIn = 49;
		// backup three sets of data
		repeat(3) begin
			RegW2 = 1;
			IR = 0;
			#1;
			repeat(14) begin
				ImR = ImR + 1;
				IR = IR + 1;
				#1;
			end
			
			RegW2 = 0;
			RAIn = RAIn + 1;
			backup = 1;
			#1;
			backup = 0;
			#10;
      end
		
		repeat(3) begin
			restore = 1;
			#1;
			restore = 0;
			IR = 14;
			RegR2 = 1;
			repeat (14) begin
				#1;
				if (B == ImR) $display("PASS");
				else $display("FAIL, ImR = %d, B = %d",ImR, B);
				ImR = ImR - 1;
				IR = IR - 1;
			end
		end
	
	end
	
	always clk = #0.5 ~clk;
      
endmodule

