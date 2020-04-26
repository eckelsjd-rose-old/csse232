`timescale 1ns / 1ps

module comparator(
    input [15:0] A,
    input [15:0] B,
	 input cmpeq,
	 input cmpne,
    output R
    );
	 
	 assign R = ((A == B) & cmpeq) | ((A != B) & cmpne);
				
endmodule
