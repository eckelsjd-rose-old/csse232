`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:52:03 02/05/2019
// Design Name:   fbs
// Module Name:   C:/Users/tuey/Desktop/CSSE232/project/3B-dripchar-eckelsjd-morganbm-tuey/Implementation/f_register_backup_system/fbs_tb.v
// Project Name:  f_register_backup_system
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fbs
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fbs_tb;

	// Inputs
	reg clk;
	reg backup;
	reg restore;
	reg [255:0] dataIn;

	// Outputs
	wire [255:0] dataOut;
	wire restoreOut;
	
	// Holder
	wire [15:0] fcc;

  // Counters (for the test)
  reg [255:0] expectedRestoreValue;
	// Instantiate the Unit Under Test (UUT)
	fbs uut (
		.clk(clk), 
		.backup(backup), 
		.restore(restore), 
		.dataIn(dataIn), 
		.dataOut(dataOut), 
		.restoreOut(restoreOut),
		.fcc(fcc)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		backup = 0;
		restore = 0;
		dataIn = 0;

		#100.1;
		
		repeat (16) begin
			backup = 1;
			#1;
			backup = 0;
			#0.5;
			if (dataIn == dataOut)
					$display("dataIn = %d dataOut = %d PASSED \n", dataIn, dataOut);
			else
					$display("dataIn = %d dataOut = %d FAILED \n", dataIn, dataOut);
			#0.5;
			dataIn = dataIn + 1;		
		end
		
		restore = 1;
		backup = 0;
		repeat (16) begin
			#1;
		end
		
		
	end
				
	always clk = #0.5 ~clk;
  
endmodule

