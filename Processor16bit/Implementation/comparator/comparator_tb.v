`timescale 1ns / 1ps

module comparator_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg cmpeq;
	reg cmpne;

	// Outputs
	wire R;

	// Instantiate the Unit Under Test (UUT)
	comparator uut (
		.A(A), 
		.B(B), 
		.cmpeq(cmpeq),  
		.cmpne(cmpne), 
		.R(R)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		cmpeq = 0;
		cmpne = 0; 

		// Wait 100 ns for global reset to finish
		#100;
		
		
		repeat (32) begin 
        cmpne = 0;
		  cmpeq = 1;
		  #2;
		  
		  	if(R == 1) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end
			
			A = A + 1; 
			#1;
			
			if(R == 0) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end
			
			cmpne = 1;
			cmpeq = 0;
			#2;
			
			if(R == 1) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end
			
			B = B + 1; 
			#1; 
			
			if(R == 0) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end		
	
		end
	end
      
endmodule
