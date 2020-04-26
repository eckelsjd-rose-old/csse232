`timescale 1ns / 1ps

module mms_tb_0;

	// Inputs
	reg clk;
	reg w1;
	reg w2;
	reg r1;
	reg r2;
	reg Memsrc;
	reg [15:0] a1;
	reg [15:0] a2_0;
	reg [15:0] a2_1;
	reg [15:0] write2;

	// Outputs
	wire [15:0] IR;
	wire [15:0] ImR;
	wire [15:0] Memout;

	// Instantiate the Unit Under Test (UUT)
	mms uut (
		.clk(clk), 
		.w1(w1), 
		.w2(w2), 
		.r1(r1), 
		.r2(r2), 
		.Memsrc(Memsrc), 
		.a1(a1), 
		.a2_0(a2_0), 
		.a2_1(a2_1), 
		.write2(write2), 
		.IR(IR), 
		.ImR(ImR), 
		.Memout(Memout)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		w1 = 0;
		w2 = 0;
		r1 = 0;
		r2 = 0;
		Memsrc = 0;
		a1 = 0;
		a2_0 = 0;
		a2_1 = 0;
		write2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		w2 = 1;
		repeat(100) begin
		#1;
		a2_0 = a2_0 + 1;
		write2 = write2 + 1;
		end
		
		w2 = 0;
		a2_0 = 0;
		#1;
		
		repeat(100) begin
			r1 = 1;
			r2 = 1;
			#1;
			
			if(IR == a1 && ImR == a2_0 && Memout == a2_0) begin
				$write("PASS");
			end else begin 
				$write("FAIL");
			end
			
			a1 = a1 + 1;
			a2_0 = a2_0 + 1;
			
		end

	end
	
	always clk = #0.5 ~clk;
      
endmodule

