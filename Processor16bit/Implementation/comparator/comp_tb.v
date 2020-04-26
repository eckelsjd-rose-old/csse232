`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:35:19 01/22/2019
// Design Name:   comparator
// Module Name:   C:/Users/dripchar/Documents/Classes/CSSE232/comparator/comp_tb.v
// Project Name:  comparator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module comp_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg ControlSignal;

	// Outputs
	wire [15:0] R;

	// Instantiate the Unit Under Test (UUT)
	comparator uut (
		.A(A), 
		.B(B), 
		.ControlSignal(ControlSignal), 
		.R(R)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		ControlSignal = 0;
		
		#20 A = 0;
		#20 B = 1;
		
		#20 A = 1;
		#20 B = 0; 
		 
		#20 A = 100;
		#20 B = 50;
		
		#20 A = 2;
		#20 B = 10000;
		
		#20 A = 0;
		#20 B = 0;
		#20 ControlSignal = 1;
		
		#20 A = 0;
		#20 B = 1;
		
		#20 A = 1;
		#20 B = 0; 
		
		#20 A = 100;
		#20 B = 50;
		
		#20 A = 2;
		#20 B = 10000;
		
	
		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
      
endmodule

