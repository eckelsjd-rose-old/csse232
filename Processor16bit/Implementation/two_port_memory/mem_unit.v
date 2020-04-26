/*********************************************************/
// MODULE:      memory
//
// FILE NAME:   memory.v
// VERSION:     1.0
// DATE:        Created 21 Nov 2004
// AUTHOR:      J.P. Mellor
//
// DESCRIPTION: This module defines memory similar to ipcore
//              generated distributed memory, but which is easier
//              to load programs and data into.
//
/*********************************************************/
module amemory16x1k(W1,
						  W2,
						  R1,
                    R2,
                    A1,
						  A2,
						  Write1,
						  Write2,
						  Read1,
						  Read2,
                    clk);
   
   // Definitions
`define MEM_DEPTH 1024//65535
`define MEM_WIDTH 16
`define ADDR_SIZE 16

   // Inputs
   
   input [`MEM_WIDTH-1:0] W1;
	input [`MEM_WIDTH-1:0] W2;
	input [`ADDR_SIZE-1:0] A1;
	input [`MEM_WIDTH-1:0] A2;
	
   input                 clk;

   // Outputs
   output reg [`MEM_WIDTH-1:0] R1;
	output reg [`MEM_WIDTH-1:0] R2;

   // Signals
	input						  Write1;
	input						  Write2;
   input						  Read1;
	input						  Read2;

   // The memory
   reg [`MEM_WIDTH-1:0] mem [`MEM_DEPTH-1:0];


   // Operations
   always @ (posedge clk)
     begin
	    if (Write1)
          mem[A1] <= W1;
		
		 if (Write2)
			 mem[A2] <= W2;
			 
		 if (Read1)
			 R1 <= mem[A1];
     
		 if (Read2)
			 R2 <= mem[A2];
	  end
	  
	//integer i;
	initial begin
	 
	// Test 1
	//$readmemb("arithmetic_test.mem", mem);
	
	// Test 2
	//$readmemb("memory_test.mem", mem);
	
	// Test 3
	//$readmemb("summation.mem", mem);
	
	// Test 4
	//$readmemb("relPrime.mem", mem);
	
	end
   
endmodule
