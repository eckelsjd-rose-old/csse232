`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:21:45 01/30/2019
// Design Name:   amemory16x1k
// Module Name:   C:/Users/tuey/Desktop/CSSE232/project/3B-dripchar-eckelsjd-morganbm-tuey/Implementation/two_port_mem-needs_debugging/mem_unit_tb.v
// Project Name:  mem
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: amemory16x1k
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mem_unit_tb;

	// Inputs
	reg [15:0] W1;
	reg [15:0] W2;
	reg [15:0] A1;
	reg [15:0] A2;
	reg Write1;
	reg Write2;
	reg Read1;
	reg Read2;
	reg clk;

	// Outputs
	wire [15:0] R1;
	wire [15:0] R2;

	// Instantiate the Unit Under Test (UUT)
	amemory16x1k uut (
		.W1(W1), 
		.W2(W2), 
		.R1(R1), 
		.R2(R2), 
		.A1(A1), 
		.A2(A2), 
		.Write1(Write1), 
		.Write2(Write2), 
		.Read1(Read1), 
		.Read2(Read2), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		W1 = 0;
		W2 = 0;
		A1 = 0;
		A2 = 1000;
		Write1 = 0;
		Write2 = 0;
		Read1 = 0;
		Read2 = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Write all 16 bit values into each address
		$display("Port1");
		repeat (30) begin // Should be 2 ^ 16
			W1 = 100;
			W2 = 0;
			#1;
			
			repeat (30) begin
				Write1 = 1;
				Write2 = 1;
				#1;
			
				Write1 = 0;
				Write2 = 0;
				#1;
				
				Read1 = 1;
				Read2 = 1;
				#1;
				if (R1 == W1)
					$display("address = %d; actual = %d; expected = %d PASSED \n", A1, R1, W1);
				else
					$display("address = %d; actual = %d; expected = %d FAILED \n", A1, R1, W1);
				if (R2 == W2)
					$display("address = %d; actual = %d; expected = %d PASSED \n", A2, R2, W2);
				else
					$display("address = %d; actual = %d; expected = %d FAILED \n", A2, R2, W2);
				Read1 = 0;
				Read2 = 0;
				
				W1 = W1 - 1;
				W2 = W2 + 1;
				#1;
			end
			A1 = A1 + 1;
			A2 = A2 - 1;
			#1;
		end
		
		// TODO: Do the exact same thing, but for Address 2
   end
   always clk = #0.5 ~clk;
endmodule

