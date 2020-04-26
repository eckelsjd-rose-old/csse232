`timescale 1ns / 1ps

module rms_tb;

	// Inputs
	reg clk;
	reg [15:0] IR;
	reg [15:0] ImR;
	reg [15:0] w2_1;
	reg [15:0] w2_2;
	reg AltB;
	reg writeCR;
	reg [1:0] Regsrc;
	reg RegR1;
	reg RegR2;
	reg RegW1;
	reg RegW2;
	reg restore;
	reg [239:0] fcIn;
	reg [15:0] ioIn;
	reg cmpne;
	reg cmpeq;
	
	reg [3:0] op_code;
	reg [5:0] rs;
	reg [5:0] rt;
	
	// example f regs from fcache for restore
	reg [15:0] f0;
	reg [15:0] f1;
	reg [15:0] f2;
	reg [15:0] f3;
	reg [15:0] f4;
	reg [15:0] f5;
	reg [15:0] f6;
	reg [15:0] f7;
	reg [15:0] f8;
	reg [15:0] f9;
	reg [15:0] f10;
	reg [15:0] f11;
	reg [15:0] f12;
	reg [15:0] f13;
	reg [15:0] f14;
	reg [239:0] fc_out_expected;
	

	// Outputs
	wire [15:0] ioOut;
	wire [3:0] op;
	wire [239:0] fcOut;
	wire [15:0] A;
	wire [15:0] B;
	wire cmp_result;

	// Instantiate the Unit Under Test (UUT)
	rms uut (
		.clk(clk), 
		.IR(IR), 
		.ImR(ImR), 
		.w2_1(w2_1), 
		.w2_2(w2_2), 
		.AltB(AltB), 
		.writeCR(writeCR), 
		.Regsrc(Regsrc),  
		.RegR1(RegR1), 
		.RegR2(RegR2), 
		.RegW1(RegW1), 
		.RegW2(RegW2), 
		.restore(restore), 
		.fcIn(fcIn), 
		.ioIn(ioIn), 
		.cmpne(cmpne), 
		.cmpeq(cmpeq),
		.ioOut(ioOut), 
		.op(op), 
		.fcOut(fcOut), 
		.A(A), 
		.B(B), 
		.cmp_result(cmp_result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		IR = 0;
		ImR = 0;
		w2_1 = 0;
		w2_2 = 0;
		AltB = 0;
		writeCR = 0;
		Regsrc = 0;
		RegR1 = 0;
		RegR2 = 0;
		RegW1 = 0;
		RegW2 = 0;
		restore = 0;
		fcIn = 0;
		ioIn = 0;
		cmpne = 0;
		cmpeq = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		//fill registers with values equal to their addresses (0-63)
		RegW2 = 1;
		repeat(63) begin
			IR = IR + 1;
			ImR = ImR + 1;
			#1;
		end
		
		//test CR mux
		IR = 0;
		writeCR = 0;
		RegW2 = 0;
		RegR1 = 1;
		RegR2 = 1;
		rs = 6'b000000;
		rt = 6'b000000;
		op_code = 4'b0000;
		#1;
		// be sure to ignore cases where rs or rt = 15 (ioIn register)
		repeat(30) begin
			repeat (30) begin
				writeCR = 0;
				IR = {op_code, rs, rt};
				#2;
				if ( ((A == rs) || (rs == 15) || (rt == 15)) && ((B == rt) || (rs == 15) || (rt == 15)) ) begin
					$display("PASS: writeCR = 0");
				end else begin
					$display("FAIL: writeCR = 0");
				end
				
				writeCR = 1;
				IR = {op_code, rs, rt};
				#2;
				if ( ((A == 57) || (rs == 15) || (rt == 15)) && ((B == rt) || (rs == 15) || (rt == 15)) ) begin
					$display("PASS: writeCR = 1");
				end else begin
					$display("FAIL: writeCR = 1");
				end
				
				rs = rs + 1;
			end
			rt = rt + 1;
		end
		
		//test Regsrc mux
		IR = 0;
		ImR = 5;
		w2_1 = 10; //offset mux inputs and check A and B outputs
		w2_2 = 15;
		writeCR = 1;
		RegR1 = 1;
		RegR2 = 1;
		RegW2 = 1;
		#1;
		repeat (20) begin
			Regsrc = 0;
			#2;
			if ( (A == 57) && (B == ImR) ) begin
				$display("PASS: Regsrc = 0");
			end else begin
				$display("FAIL: Regsrc = 0");
			end
			
			Regsrc = 1;
			#2;
			if ( (A == 57) && (B == w2_1) ) begin
				$display("PASS: Regsrc = 1");
			end else begin
				$display("FAIL: Regsrc = 1");
			end
			
			Regsrc = 2;
			#2;
			if ( (A == 57) && (B == w2_2) ) begin
				$display("PASS: Regsrc = 2");
			end else begin
				$display("FAIL: Regsrc = 2");
			end
			
			Regsrc = 3;
			#2;
			if ( (A == 57) && (B == A) ) begin
				$display("PASS: Regsrc = 3");
			end else begin
				$display("FAIL: Regsrc = 3");
			end
			
			ImR = ImR + 1;
			w2_1 = w2_1 + 1;
			w2_2 = w2_2 + 1;
			#1;

		end
		
		//reset registers with values equal to their addresses (0-15)
		RegW2 = 1;
		Regsrc = 0;
		IR = 0;
		ImR = 0;
		#1;
		repeat(15) begin
			IR = IR + 1;
			ImR = ImR + 1;
			#1;
		end
		
		//test restore 
		ImR = 0;
		RegW2 = 0;
		writeCR = 0;
		IR = 0;
		Regsrc = 0;
		RegR1 = 0;
		RegR2 = 0;
		#5;
		
		f0 = 14;
		f1 = 13;
		f2 = 12;
		f3 = 11;
		f4 = 10;
		f5 = 9;
		f6 = 8;
		f7 = 7;
		f8 = 6;
		f9 = 5;
		f10 = 4;
		f11 = 3;
		f12 = 2;
		f13 = 1;
		f14 = 0;
		fcIn = {f14, f13, f12, f11, f10, f9, f8, f7, f6, f5, f4, f3, f2, f1, f0}; //mirror all the values in register f0-f14
		fc_out_expected = {f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14};
		#10;
		
		if (fcOut == fc_out_expected) $display("PASS: fcOut");
		else $display("FAIL: fcOut");
		
		restore = 1;
		RegR2 = 1;
		#5;
		
		repeat(15) begin
			if ( B == f0 ) $display("PASS: fcIn");
			else $display("FAIL: fcIN");
			IR = IR + 1; //increase register address a1 by 1
			f0 = f0 - 1; //check value at register decreases by 1 (starting at 14)
			#2;
		end
			
		//test comparator
		IR = 0;
		ImR = 40;
		writeCR = 1; // A should only equal B when B=57
		RegR1 = 1;
		RegR2 = 1;
		RegW1 = 0;
		RegW2 = 1;
		Regsrc = 0;
		#20;
		
		repeat(20) begin
			cmpeq = 1;
			cmpne = 0;
			#2;
			if ( ((A == B) && cmp_result) || ((A != B) && ~cmp_result) ) $display("PASS: cmpeq");
			else $display("FAIL: cmpeq");
			
			cmpeq = 0;
			cmpne = 1;
			#2;
			if ( ((A == B) && ~cmp_result) || ((A != B) && cmp_result) ) $display("PASS: cmpne");
			else $display("FAIL: cmpne");
			
			ImR = ImR + 1;
			#2;
		end
			
		//test io regs
		Regsrc = 2;
		writeCR = 0;
		op_code = 4'b0000;
		rs = 6'b001111;
		rt = 6'b010000;
		IR = {op_code, rs, rt};
		w2_2 = 0;
		RegW1 = 0;
		RegW2 = 1;
		RegR1 = 1;
		RegR2 = 1;
		#1;
		repeat(15) begin
			if (ioIn == A) $display("PASS: ioIn");
			else $display("FAIL: ioIn");
			
			if (ioOut == B) $display("PASS: ioOut");
			else $display("FAIL: ioOut");
			
			w2_2 = w2_2 + 1;
			ioIn = ioIn + 1;
			#2;
		end
	
	end
	
	always clk = #0.5 ~clk;
      
endmodule

