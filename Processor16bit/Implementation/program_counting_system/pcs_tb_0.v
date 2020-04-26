`timescale 1ns / 1ps

module pcs_tb_0;

	// Inputs
	reg clk;
	reg restore;
	reg writePC;
	reg writeRA;
	reg PCsrc;
	reg ImRPC;
	reg conditionalBop;
	reg [15:0] ImR;

	// Outputs
	wire [15:0] PC;
	wire [15:0] PC_1;

	// Instantiate the Unit Under Test (UUT)
	pcs uut (
		.clk(clk),
		.restore(restore),
		.writePC(writePC), 
		.writeRA(writeRA), 
		.PCsrc(PCsrc), 
		.ImRPC(ImRPC), 
		.conditionalBop(conditionalBop), 
		.ImR(ImR), 
		.PC(PC), 
		.PC_1(PC_1),
		.RA()
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		restore = 0;
		writePC = 0;
		writeRA = 0;
		PCsrc = 0;
		ImRPC = 0;
		conditionalBop = 0;
		ImR = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		writePC = 1; // Clock through some cycles
		#5;
		
		writeRA = 1; // Jump to 22
		ImR = 22;
		ImRPC = 1;
		#1;
		writeRA = 0;
		ImRPC = 0;
		#5;
		PCsrc = 1; // Return to ra
		#1;
		PCsrc = 0;
		#10;
		
		writeRA = 1; // Jump to 4096
		ImR = 4096;
		ImRPC = 1;
		#1;
		writeRA = 0;
		ImRPC = 0;
		#5;
		PCsrc = 1; // Return
		#1;
		PCsrc = 0;
		#5;
		
		writeRA = 1; // Jump to 349
		ImR = 349;
		ImRPC = 1;
		#1;
		writeRA = 0;
		ImRPC = 0;
		#5;
		PCsrc = 1; // Return
		#1;
		PCsrc = 0;
		#17;
		
		
        
		// Add stimulus here

	end
	
	always clk = #0.5 ~clk;
      
endmodule

