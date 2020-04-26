`timescale 1ns / 1ps

module datapath_tb;

	// Inputs
	reg [15:0] ioIn;
	reg reset;

	// Outputs
	wire [15:0] ioOut;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.reset(reset),
		.ioIn(ioIn),  
		.ioOut(ioOut)
	);

	initial begin
		// Initialize Inputs
		
		// 4 sets of tests stored in memory. Go to mem_unit.v file and uncomment the $readmemb line for the desired test.
			
		// Test 1 - Arithmetic test (add, sub, and, orr, slt, cop, sft, ldi)
		
		/*
		reset = 1;
		ioIn = 20;
		#0.2;
		reset = 0;
		#35000;
		// check waveforms for verification of other arithmetic instructions
		// last instruction tested is sft .ip .op -2, check the result:
		if (ioOut == ioIn >> 2) $display("PASS: arithmetic_test of %d",ioIn);
		else $display("FAIL: arithmetic_test of %d", ioIn);
		*/

		// Test 2 - Memory test (lda, str, bne)
		
		/*
		reset = 1;
		ioIn = 50;
		#0.2;
		reset = 0;
		#35000;
		// check waveforms for verification that 3 was loaded from memory into .op briefly
		// last instruction tested loads ioIn from memory to ioOut, check the result:
		if (ioOut == ioIn) $display("PASS: memory_test of %d",ioIn);
		else $display("FAIL: memory_test of %d", ioIn);
		*/
		
		// Test 3 - Summation algorithm (bop, cal, ret)
		
		/*
		reset = 1;
		ioIn = 350;
		#0.2;
		reset = 0;
		#35000;
		if (ioOut == (ioIn * (ioIn + 1)) / 2) $display("PASS: relPrime of %d",ioIn);
		else $display("FAIL: relPrime of %d", ioIn);
		*/
		
		// Test 4 - RelPrime algorithm
		
		
		reset = 1;
		ioIn = 5040;
		#0.2;
		reset = 0;
		#35000;  // 35 microseconds for full program execution
		if (ioOut == 11) $display("PASS: relPrime of %d",ioIn);
		else $display("FAIL: relPrime of %d", ioIn);
		
		
	end
      
endmodule

