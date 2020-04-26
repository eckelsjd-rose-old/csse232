`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:41:32 01/28/2019
// Design Name:   fcache
// Module Name:   /home/bailey/comparch/3B-dripchar-eckelsjd-morganbm-tuey/Implementation/fcache/fcache_tb_0.v
// Project Name:  fcache
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fcache
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fcache_tb_0;

	// Inputs
	reg clk;
	reg write;
	reg [15:0] addr;
	reg [255:0] wData;

	// Outputs
	wire [255:0] rData;

	// Instantiate the Unit Under Test (UUT)
	fcache uut (
		.clk(clk), 
		.write(write), 
		.addr(addr), 
		.wData(wData), 
		.rData(rData)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		write = 0;
		addr = 0;
		wData = 0;

		// Wait 100 ns for global reset to finish
		#100;

		    
		// Add stimulus here
		// repeat (2**16) begin
		repeat (30) begin
			wData = 2**255;
			repeat (5) begin
				write = 1;
				#1
				write = 0;
				#1
				$write("@%d wrote%d, read%d", addr, wData, rData);
				if(rData == wData) begin
					$display("PASS");
				end else begin
					$display("FAIL");
				end
				#1
				wData = wData - 1;
			end
			addr = addr + 1;
		end
	end
	
	always clk = #0.5 ~clk;
      
endmodule

