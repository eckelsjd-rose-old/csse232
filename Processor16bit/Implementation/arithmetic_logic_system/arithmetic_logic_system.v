`timescale 1ns / 1ps

module arithmetic_logic_system(
    input [15:0] A,
    input [15:0] B,
    input [15:0] Imm,
    input ALUsrc,
    input [2:0] ALUop,
	 input clk,
    output AltB,
    output [15:0] ALUout
    );

	 wire [15:0] mux_out, alu_out;
	 wire a_ltb;
	 reg [15:0] ALUout_reg;
	 reg AltB_reg;
	 
alu_16_bit alu(
	.A(A),
	.B(mux_out),
	.op(ALUop),
	.R(alu_out),
	.AltB(a_ltb)
	);
	
mux_1_bit alu_mux(
	.A(Imm), 
	.B(B),
	.S(ALUsrc),
	.R(mux_out)
	);
	
	assign ALUout = ALUout_reg;
	assign AltB = AltB_reg;
	
	always @(posedge clk) begin
		ALUout_reg = alu_out;
		AltB_reg = a_ltb;
	end

endmodule
