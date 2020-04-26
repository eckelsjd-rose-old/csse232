`timescale 1ns / 1ps

module alu_16_bit(
    input [15:0] A,
    input [15:0] B,
    input [2:0] op,
    output reg [15:0] R,
    output reg AltB
    );
	 
	 always @ * begin
	 
		 case (op)
			0: R = A & B; 	// And
			1: R = A | B; 	// Or
			2: R = A + B;	// Add
			3: R = B - A;	// Sub
			4: if ($signed(B) < 0) begin // shift
					R = (A >>(~B)) >> 1;
				end
				else if (B == 0) begin
					R = A;
				end
				else begin
					R = A << B;
				end
			5: begin // slt
				AltB = (A < B);
				R = A + B;
				end
			default: R = A + B;
		 endcase
			
	 end
	 
endmodule
