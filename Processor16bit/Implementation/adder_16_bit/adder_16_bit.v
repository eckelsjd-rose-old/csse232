`timescale 1ns / 1ps

module adder_16_bit(
    input [15:0] A,
    input [15:0] B,
    output reg [15:0] R
    );
	 
	 always @ *
	 
	 R = A + B;

endmodule
