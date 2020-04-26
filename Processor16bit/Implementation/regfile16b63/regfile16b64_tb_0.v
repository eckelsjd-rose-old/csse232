`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:18:15 01/28/2019
// Design Name:   regfile16b64
// Module Name:   C:/Users/dripchar/Documents/Classes/CSSE232/regfile16b63/regfile16b64_tb_0.v
// Project Name:  regfile16b63
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regfile16b64
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regfile16b64_tb_0;

	// Inputs
	reg [15:0] a1;
	reg [15:0] a2;
	reg [15:0] w1;
	reg [15:0] w2;
	reg [239:0] fcIn;
	reg w1Control;
	reg w2Control;
	reg r1Control;
	reg r2Control;
	reg clk; 
	reg restore;

	// Outputs
	wire [15:0] r1;
	wire [15:0] r2;
	wire [239:0] fcOut;

	// Instantiate the Unit Under Test (UUT)
	regfile16b64 uut (
		.a1(a1), 
		.a2(a2), 
		.w1(w1), 
		.w2(w2), 
		.fcIn(fcIn), 
		.r1(r1), 
		.r2(r2), 
		.fcOut(fcOut), 
		.w1Control(w1Control), 
		.w2Control(w2Control), 
		.r1Control(r1Control), 
		.r2Control(r2Control),
		.clk(clk),
		.restore(restore)
	);

	initial begin
		// Initialize Inputs
		a1 = 0;
		a2 = 63;
		w1 = 0;
		w2 = 0;
		fcIn = 0;
		w1Control = 0;
		w2Control = 0;
		r1Control = 1;
		r2Control = 1;
		clk = 1;
		restore = 0; 

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		r1Control = 1;
		r2Control = 1;
		repeat (32) begin
			w1Control = 1;
			w2Control = 1;
			#2;
			
			if(r1 == w1 && r2 == w2) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end
			
			w1Control = 0;
			w2Control = 0;
			w1 = w1 + 1;
			w2 = w2 + 1;
			a1 = a1 + 1;
			a2 = a2 - 1;
			#1;
			
		end		
	end
	
	always clk = #0.5 ~clk;
      
endmodule

