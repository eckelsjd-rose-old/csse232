`timescale 1ns / 1ps

module pms_tb_0;

	reg [7:0] count;

	// Inputs
	reg clk;
	reg restore;
	reg writePC;
	reg writeRA;
	reg PCsrc;
	reg ImRPC;
	reg Memsrc;
	reg MemW1;
	reg MemW2;
	reg MemR1;
	reg MemR2;
	reg conditionalBop;
	reg [15:0] RArestore;
	reg [15:0] a2_1;
	reg [15:0] write2;


	// Outputs
	wire [15:0] IR;
	wire [15:0] ImR;
	wire [15:0] Memout;
	wire [15:0] RA;

	// Instantiate the Unit Under Test (UUT)
	pms uut (
		.clk(clk), 
		.restore(restore), 
		.writePC(writePC), 
		.writeRA(writeRA), 
		.PCsrc(PCsrc), 
		.ImRPC(ImRPC), 
		.Memsrc(Memsrc), 
		.MemW1(MemW1), 
		.MemW2(MemW2), 
		.MemR1(MemR1), 
		.MemR2(MemR2), 
		.conditionalBop(conditionalBop), 
		.RArestore(RArestore), 
		.a2_1(a2_1), 
		.write2(write2), 
		.IR(IR), 
		.ImR(ImR), 
		.Memout(Memout), 
		.RA(RA)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		restore = 0;
		writePC = 0;
		writeRA = 0;
		PCsrc = 0;
		ImRPC = 0;
		Memsrc = 0;
		MemW1 = 0;
		MemW2 = 0;
		MemR1 = 0;
		MemR2 = 0;
		conditionalBop = 0;
		RArestore = 0;
		a2_1 = 0;
		write2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Writing shit to memory
		Memsrc = 1;
		MemW2 = 1;
		repeat(100) begin
			#1;
			write2 = write2 + 1;
			a2_1 = a2_1 + 1;
		end
		
		#5;		
		writePC = 1;
		MemR1 = 1;
		count = 0;
		repeat(100) begin
			#1;
			if(IR == count) begin
				$write("PASS\n");
			end else begin
				$write("FAIL\n");
			end
			count = count + 1;
		end
		
		#100;

	end
	
	always clk = #0.5 ~clk;
      
endmodule

