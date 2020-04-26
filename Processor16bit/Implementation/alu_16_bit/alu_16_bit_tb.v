`timescale 1ns / 1ps

module alu_16_bit_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [2:0] op;

	// Outputs
	wire [15:0] R;
	wire AltB;

	// Instantiate the Unit Under Test (UUT)
	alu_16_bit uut (
		.A(A), 
		.B(B), 
		.op(op), 
		.R(R), 
		.AltB(AltB)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		op = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// And
		$display("AND:");
		op = 0;
		A = -10;
		B = -10;
		#1;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				#5;
				if ((A & B) == R) begin
					$display("PASS AND");
				end
				else begin
					$display("FAIL: %b & %b = %b",A,B,R);
				end
			end
			A = -10;
			B = B + 1;
			#5;
		end
		
		// Or
		$display("OR:");
		op = 1;
		A = -10;
		B = -10;
		#1;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				#5;
				if ((A | B) == R) begin
					$display("PASS OR");
				end
				else begin
					$display("FAIL: %b | %b = %b",A,B,R);
				end
			end
			A = -10;
			B = B + 1;
			#5;
		end
		
		// Add
		$display("Add:");
		op = 2;
		A = -10;
		B = -10;
		#1;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				#5;
				if (A + B == R) begin
					$display("PASS Add");
				end
				else begin
					$display("FAIL: %d + %d = %d",A,B,R);
				end
			end
			A = -10;
			B = B + 1;
			#5;
		end
		
		// Sub
		$display("Sub:");
		op = 3;
		A = -10;
		B = -10;
		#1;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				#5;
				if (A - B == R) begin
					$display("PASS Sub");
				end
				else begin
					$display("FAIL: %d - %d = %d",A,B,R);
				end
			end
			A = -10;
			B = B + 1;
			#5;
		end
		
		// Shift
		$display("Shift:");
		op = 4;
		A = -10;
		B = -10;
		#1;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				#5;
				if ( $signed(B) < 0) begin // right shift test
					if ( (A >> (~B)) >> 1 == R ) begin
						$display("PASS: Shift right");
					end
					else begin
						$display("FAIL: Shift right");
					end
				end
				else begin						// left shift test
					if ( (A << B) == R ) begin 
						$display("PASS: Shift left");
					end
					else begin
						$display("FAIL: Shift right");
					end
				end
			end
			A = -10;
			B = B + 1;
			#5;
		end
		
		// Set on Less than
		$display("SLT:");
		op = 5;
		A = -10;
		B = -10;
		#1;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				#5;
				if (((A < B) && AltB) || (~(A < B) && ~AltB)) begin
					$display("PASS Slt");
				end
				else begin
					$display("FAIL: %d < %d = %d",A,B,AltB);
				end
			end
			A = -10;
			B = B + 1;
			#5;
		end
		
	end
      
endmodule

