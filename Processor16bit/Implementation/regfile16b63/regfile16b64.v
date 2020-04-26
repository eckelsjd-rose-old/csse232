`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:49:19 01/28/2019 
// Design Name: 
// Module Name:    regfile16b64 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module regfile16b64(
    input [15:0] a1,
    input [15:0] a2,
    input [15:0] w1,
    input [15:0] w2,
    input [239:0] fcIn,
	 input [15:0] ioIn,
	 input w1Control,
    input w2Control,
    input r1Control,
    input r2Control,
	 input restore,
	 input clk,
    output reg [15:0] r1,
    output reg [15:0] r2,
	 output reg [15:0] ioOut,
    output [239:0] fcOut
    );
	 
	 
	 reg[15:0]	regFile[63:0];
	 
	 
	 
	 integer i;
	 initial begin
		 for(i = 0; i < 64; i = i + 1)
			regFile[i] <= 0;
	 end
	 
	 always @(posedge clk) begin
	 
	 regFile[15] = ioIn;
	 ioOut = regFile[16];
	 
	 if(r1Control) begin
		if (a1 ==63) r2 = 0;
		else r1 = regFile[a1];
	 end
	 if(r2Control) begin
		if(a2 == 63) r2 =0;
		else r2 = regFile[a2];
	 end
	 
	 if(w1Control) regFile[a1] = w1;
	 if(w2Control) regFile[a2] = w2;
	 
	 if(restore) begin
		regFile[0] = fcIn[15:0];
		regFile[1] = fcIn[31:16];
		regFile[2] = fcIn[47:32];
		regFile[3] = fcIn[63:48];
		regFile[4] = fcIn[79:64];
		regFile[5] = fcIn[95:80];
		regFile[6] = fcIn[111:96];
		regFile[7] = fcIn[127:112];
		regFile[8] = fcIn[143:128];
		regFile[9] = fcIn[159:144]; 
		regFile[10] = fcIn[175:160];
		regFile[11] = fcIn[191:176];
		regFile[12] = fcIn[207:192];
		regFile[13] = fcIn[223:208];
		regFile[14] = fcIn[239:224];
	 end
	end
	
	
	assign fcOut[15:0] = regFile[0];
	assign fcOut[31:16] = regFile[1];
	assign fcOut[47:32] = regFile[2];
	assign fcOut[63:48] = regFile[3];
	assign fcOut[79:64] = regFile[4];
	assign fcOut[95:80] = regFile[5];
	assign fcOut[111:96] = regFile[6];
	assign fcOut[127:112] = regFile[7];
	assign fcOut[143:128] = regFile[8];
	assign fcOut[159:144] = regFile[9];
	assign fcOut[175:160] = regFile[10];
	assign fcOut[191:176] = regFile[11];
	assign fcOut[207:192] = regFile[12];
	assign fcOut[223:208] = regFile[13];
	assign fcOut[239:224] = regFile[14];


endmodule
