`timescale 1ns / 1ps

module fbs(
  input clk,
  input backup,
  input restore,
  input [255:0] dataIn,
  output [255:0] dataOut
);

  reg [15:0] FCCreg;

  wire [15:0] IorD_R, fccAdder_R, fcacheSrc_R;
  
  adder_16_bit fccAdder(
    .A(IorD_R),
    .B(FCCreg),
    .R(fccAdder_R)
    );

  // Controls FCC inc or dec
  mux_1_bit IorD(
    .A(16'b1111111111111111),
    .B(16'b0000000000000001),
    .S(backup),
    .R(IorD_R)
    );
  
  // Controls FCC + 1 or FCC
  mux_1_bit fcacheSrc (
    .A(fccAdder_R),
    .B(FCCreg),
    .S(backup),
    .R(fcacheSrc_R)
  );

  fcache FCache (
    .clk(clk),
    .write(backup),
    .addr(fcacheSrc_R),
    .wData(dataIn),
    .rData(dataOut)    
  );

	initial begin
    FCCreg = 0;
	end

	always @(posedge clk) begin
		if(backup | restore) FCCreg <= fccAdder_R;
	end
	
endmodule
