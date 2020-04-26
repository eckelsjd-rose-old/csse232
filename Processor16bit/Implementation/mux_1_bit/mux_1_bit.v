`timescale 1ns / 1ps

module mux_1_bit(
    input [15:0] A,
    input [15:0] B,
    input S,
    output reg [15:0] R
    );

	always @ *
	
	case (S)
		0: R = A;
		1: R = B;
	endcase

endmodule
