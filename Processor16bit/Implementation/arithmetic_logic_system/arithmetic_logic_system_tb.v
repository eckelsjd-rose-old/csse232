`timescale 1ns / 1ps

module arithmetic_logic_system_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] Imm;
	reg ALUsrc;
	reg [2:0] ALUop;
	reg clk;

	// Outputs
	wire AltB;
	wire [15:0] ALUout;

	// Instantiate the Unit Under Test (UUT)
	arithmetic_logic_system uut (
		.A(A), 
		.B(B), 
		.Imm(Imm), 
		.ALUsrc(ALUsrc), 
		.ALUop(ALUop), 
		.clk(clk), 
		.AltB(AltB), 
		.ALUout(ALUout) 
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		Imm = 0;
		ALUsrc = 0;
		ALUop = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100.2;
		
		// Add
		$display("ADD:");
		ALUop = 2;
		A = -10;
		B = -10;
		Imm = 10;
		#1;
		repeat (20) begin
			repeat (20) begin
				ALUsrc = 1;
				A = A + 1;
				Imm = Imm - 1;
				#1;
				if ((A + B) == ALUout) begin
					$display("PASS ADD, ALUsrc = 1");
				end
				else begin
					$display("FAIL: %d + %d = %d",A,B,ALUout);
				end
				
				ALUsrc = 0;
				#1;
				if ((A + Imm) == ALUout) begin
					$display("PASS ADD, ALUsrc = 0");
				end
				else begin
					$display("FAIL: %d + %d = %d",A,Imm,ALUout);
				end
				#1;
			end
			A = -10;
			Imm = 10;
			B = B + 1;
			#1;
		end 
		
		// AND
		$display("AND:");
		ALUop = 0;
		A = -10;
		B = -10;
		Imm = 10;
		#1;
		repeat (20) begin
			repeat (20) begin
				ALUsrc = 1;
				A = A + 1;
				Imm = Imm - 1;
				#1;
				if ((A & B) == ALUout) begin
					$display("PASS AND, ALUsrc = 1");
				end
				else begin
					$display("FAIL: %b & %b = %b",A,B,ALUout);
				end
				
				ALUsrc = 0;
				#1;
				if ((A & Imm) == ALUout) begin
					$display("PASS AND, ALUsrc = 0");
				end
				else begin
					$display("FAIL: %b & %b = %b",A,Imm,ALUout);
				end
				#1;
			end
			A = -10;
			Imm = 10;
			B = B + 1;
			#1;
		end 

		// OR
		$display("OR:");
		ALUop = 1;
		A = -10;
		B = -10;
		Imm = 10;
		#1;
		repeat (20) begin
			repeat (20) begin
				ALUsrc = 1;
				A = A + 1;
				Imm = Imm - 1;
				#1;
				if ((A | B) == ALUout) begin
					$display("PASS OR, ALUsrc = 1");
				end
				else begin
					$display("FAIL: %b & %b = %b",A,B,ALUout);
				end
				
				ALUsrc = 0;
				#1;
				if ((A | Imm) == ALUout) begin
					$display("PASS OR, ALUsrc = 0");
				end
				else begin
					$display("FAIL: %b & %b = %b",A,Imm,ALUout);
				end
				#1;
			end
			A = -10;
			Imm = 10;
			B = B + 1;
			#1;
		end 
		
		// Sub
		$display("Sub:");
		ALUop = 3;
		A = -10;
		B = -10;
		Imm = 10;
		#1;
		repeat (20) begin
			repeat (20) begin
				ALUsrc = 1;
				A = A + 1;
				Imm = Imm - 1;
				#1;
				if ((A - B) == ALUout) begin
					$display("PASS Sub, ALUsrc = 1");
				end
				else begin
					$display("FAIL: %d & %d = %d",A,B,ALUout);
				end
				
				ALUsrc = 0;
				#1;
				if ((A - Imm) == ALUout) begin
					$display("PASS Sub, ALUsrc = 0");
				end
				else begin
					$display("FAIL: %d & %d = %d",A,Imm,ALUout);
				end
				#1;
			end
			A = -10;
			Imm = 10;
			B = B + 1;
			#1;
		end 
		
		// Shift
		$display("Shift:");
		ALUop = 4;
		A = -10;
		B = -10;
		Imm = 10;
		#1;
		repeat (20) begin
			repeat (20) begin
				ALUsrc = 1;						// ALUsrc = 1
				A = A + 1;
				Imm = Imm - 1;
				#1;
				if ( $signed(B) < 0) begin // right shift test
					if ( (A >> (~B)) >> 1 == ALUout ) begin
						$display("PASS: Shift right, ALUsrc = 1");
					end
					else begin
						$display("FAIL: Shift right, ALUsrc = 1");
					end
				end
				else begin						// left shift test
					if ( (A << B) == ALUout ) begin 
						$display("PASS: Shift left, ALUsrc = 1");
					end
					else begin
						$display("FAIL: Shift right, ALUsrc = 1");
					end
				end
				
				ALUsrc = 0;						  // ALUsrc = 0
				#1;
				if ( $signed(Imm) < 0) begin // right shift test
					if ( (A >> (~Imm)) >> 1 == ALUout ) begin
						$display("PASS: Shift right, ALUsrc = 0");
					end
					else begin
						$display("FAIL: Shift right, ALUsrc = 0");
					end
				end
				else begin						// left shift test
					if ( (A << Imm) == ALUout ) begin 
						$display("PASS: Shift left, ALUsrc = 0");
					end
					else begin
						$display("FAIL: Shift right, ALUsrc = 0");
					end
				end
				
			end
			A = -10;
			Imm = 10;
			B = B + 1;
			#1;
		end
		
		// Set on Less than
		$display("SLT:");
		ALUop = 5;
		A = -10;
		B = -10;
		Imm = 10;
		#1;
		repeat (20) begin
			repeat (20) begin
				ALUsrc = 1;
				A = A + 1;
				Imm = Imm - 1;
				#1;
				if (((A < B) && AltB) || (~(A < B) && ~AltB)) begin
					$display("PASS Slt, ALUsrc = 1");
				end
				else begin
					$display("FAIL: %d < %d = %d",A,B,AltB);
				end
				
				ALUsrc = 0;
				#1;
				if (((A < Imm) && AltB) || (~(A < Imm) && ~AltB)) begin
					$display("PASS Slt, ALUsrc = 0");
				end
				else begin
					$display("FAIL: %d < %d = %d",A,Imm,AltB);
				end
				
			end
			A = -10;
			Imm = 10;
			B = B + 1;
			#1;
		end
	end
	
	always clk = #0.5 ~clk;
      
endmodule

