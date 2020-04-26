`timescale 1ns / 1ps

module mux_2_bit(
    input [15:0] A,
    input [15:0] B,
	 input [15:0] C,
	 input [15:0] D,
    input [1:0] S,
    output reg [15:0] R
    );
	
	always @ *
	 
	 case (S)
		0: R = A;
		1: R = B;
		2: R = C;
		3: R = D;
	 endcase
	 
endmodule
