`timescale 1ns / 1ps

module mux_1_bit_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg S;

	// Outputs
	wire [15:0] R;

	// Instantiate the Unit Under Test (UUT)
	mux_1_bit uut (
		.A(A), 
		.B(B), 
		.S(S), 
		.R(R)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		S = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// S = 0
		S = 0;
		A = -10;
		B = -10;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				#1;
				if (A == R) begin
					$display("PASS");
				end
				else begin
					$display("FAIL: A = %d, B = %d, R = %d, S = %d",A, B, R, S);
				end
				#5;
			end
			A = -10;
			B = B + 1;
			#5;
		end
		
		// S = 1
		S = 1;
		A = -10;
		B = -10;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				#1;
				if (B == R) begin
					$display("PASS");
				end
				else begin
					$display("FAIL: A = %d, B = %d, R = %d, S = %d",A, B, R, S);
				end
				#5;
			end
			A = -10;
			B = B + 1;
			#5;
		end

	end
      
endmodule

