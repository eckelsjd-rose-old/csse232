`timescale 1ns / 1ps

module mux_2_bit_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] C;
	reg [15:0] D;
	reg [1:0] S;

	// Outputs
	wire [15:0] R;

	// Instantiate the Unit Under Test (UUT)
	mux_2_bit uut (
		.A(A), 
		.B(B),
		.C(C),
		.D(D),
		.S(S), 
		.R(R)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		C = 0;
		D = 0;
		S = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// S = 0
		S = 0;
		A = -10;
		B = -10;
		C = -10;
		D = -10;
		repeat (20) begin
			repeat (20) begin
				repeat (20) begin
					repeat (20) begin
						A = A + 1;
						S = 0;
						#1;
						case (A == R) 
							0: $display("FAIL: A = %d, B = %d, C = %d, D = %d, R = %d, S = %d", A, B, C, D, R, S);
							1: $display("PASS");
						endcase 
						
						S = 1;
						#1;
						case (B == R) 
							0: $display("FAIL: A = %d, B = %d, C = %d, D = %d, R = %d, S = %d", A, B, C, D, R, S);
							1: $display("PASS");
						endcase 
						
						S = 2;
						#1;
						case (C == R) 
							0: $display("FAIL: A = %d, B = %d, C = %d, D = %d, R = %d, S = %d", A, B, C, D, R, S);
							1: $display("PASS");
						endcase 
						
						S = 3;
						#1;
						case (D == R) 
							0: $display("FAIL: A = %d, B = %d, C = %d, D = %d, R = %d, S = %d", A, B, C, D, R, S);
							1: $display("PASS");
						endcase 
						#1;
					end
					A = -10;
					B = B + 1;
					#1;
				end
				B = -10;
				C = C + 1;
				#1;
			end
			C = -10;
			D = D + 1;
			#1;
		end
		
	end
		
endmodule
