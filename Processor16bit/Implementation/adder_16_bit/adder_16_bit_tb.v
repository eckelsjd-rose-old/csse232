`timescale 1ns / 1ps

module adder_16_bit_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;

	// Outputs
	wire [15:0] R;

	// Instantiate the Unit Under Test (UUT)
	adder_16_bit uut (
		.A(A), 
		.B(B), 
		.R(R)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		A = -20;
		B = -20;
		repeat (40) begin
			repeat (40) begin
				A = A + 1;
				#1;
				if (A + B == R) begin
					$display("PASS");
				end
				else begin
					$display("FAIL: %d + %d = %d", A, B, R);
				end
				#5;
			end
			A = -20;
			B = B + 1;
			#5;
		end

	end
      
endmodule

