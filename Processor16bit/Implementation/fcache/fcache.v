`timescale 1ns / 1ns

module fcache
  (input clk,
   input write,
   input [15:0] addr,
   input [255:0] wData,
   output [255:0] rData);

   reg[255:0] 	 regfile[0:1023];

   assign rData = regfile[addr];

   always @(posedge clk) begin
      if (write) regfile[addr] <= wData;
   end

endmodule
