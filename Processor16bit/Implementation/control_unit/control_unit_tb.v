`timescale 1ns / 1ps

module control_unit_tb;

	// Inputs
	reg unsigned [3:0] op;
	reg clk;
	reg Reset;

	// Outputs
	wire PCsrc;
	wire writePC;
	wire writeRA;
	wire ImRPC;
	wire Memsrc;
	wire MemW1;
	wire MemW2;
	wire MemR1;
	wire MemR2;
	wire writeCR;
	wire [1:0] Regsrc;
	wire writeImR;
	wire backup;
	wire restore;
	wire RegW1;
	wire RegW2;
	wire RegR1;
	wire RegR2;
	wire ALUsrc;
	wire [3:0] ALUop;
	wire cmpeq;
	wire cmpne;
	wire [4:0] current_state;
	wire [4:0] next_state;

	// Instantiate the Unit Under Test (UUT)
	control_unit uut (
		.op(op), 
		.clk(clk), 
		.Reset(Reset), 
		.PCsrc(PCsrc), 
		.writePC(writePC), 
		.writeRA(writeRA), 
		.ImRPC(ImRPC), 
		.Memsrc(Memsrc), 
		.MemW1(MemW1), 
		.MemW2(MemW2), 
		.MemR1(MemR1), 
		.MemR2(MemR2), 
		.writeCR(writeCR), 
		.Regsrc(Regsrc), 
		.writeImR(writeImR), 
		.backup(backup), 
		.restore(restore), 
		.RegW1(RegW1), 
		.RegW2(RegW2), 
		.RegR1(RegR1), 
		.RegR2(RegR2), 
		.ALUsrc(ALUsrc), 
		.ALUop(ALUop), 
		.cmpeq(cmpeq), 
		.cmpne(cmpne), 
		.current_state(current_state), 
		.next_state(next_state)
	);

	initial begin
		// Initialize Inputs
		op = 0;
		clk = 0;
		Reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// verify visually on waveforms that each opcode follows the following state progressions:
		// (see finite state machine diagram and control_unit.v for definition of states)
		// op: state 1 -> state 2 -> state 3 -> etc.
		//
		// 0:  0 -> 1  -> 2  -> 4  -> 5  -> 0 (lda)
		// 1:  0 -> 1  -> 6  -> 0				  (ldi)
		// 2:  0 -> 1  -> 2  -> 3  -> 0		  (str)
		// 3:  0 -> 13 -> 14 -> 0				  (bop)
		// 4:  0 -> 15 -> 16 -> 0				  (cal)
		// 5:  0 -> 1  -> 7  -> 0				  (beq)
		// 6:  0 -> 1  -> 8  -> 0				  (bne)
		// 7:  0 -> 1  -> 9  -> 10 -> 0		  (sft)
		// 8:  0 -> 17 -> 22 -> 0				  (cop)
		// 9:  0 -> 0								  (empty opcode)
		// 10: 0 -> 17 -> 20 -> 21 -> 0		  (slt)
		// 11: 0 -> 11 -> 12 -> 0				  (ret)
		// 12: 0 -> 17 -> 18 -> 19 -> 0		  (add)
		// 13: 0 -> 17 -> 18 -> 19 -> 0		  (sub)
		// 14: 0 -> 17 -> 18 -> 19 -> 0		  (and)
		// 15: 0 -> 17 -> 18 -> 19 -> 0		  (orr)
		
		while (op < 16) begin
		
			// check control signals at each of the (23) states
				case (current_state)
					0: if (~PCsrc & writePC & ~Memsrc & MemR1 & MemR2 & writeImR) $display("PASS state %d",current_state);
						else $display("FAIL");
					1: if (~PCsrc & writePC & ~writeCR & RegR1 & RegR2) $display("PASS state %d",current_state);
						else $display("FAIL");
					2: if (~ALUsrc & (ALUop == 2)) $display("PASS state %d",current_state);
						else $display("FAIL");
					3: if (Memsrc & MemW2) $display("PASS state %d",current_state);
						else $display("FAIL");
					4: if (MemR2 & Memsrc) $display("PASS state %d",current_state);
						else $display("FAIL");
					5: if ((Regsrc==1) & RegW2) $display("PASS state %d",current_state);
						else $display("FAIL");
					6: if (RegW2 & (Regsrc == 0)) $display("PASS state %d",current_state);
						else $display("FAIL");
					7: if (~PCsrc & cmpeq) $display("PASS state %d",current_state);
						else $display("FAIL");
					8: if (~PCsrc & cmpne) $display("PASS state %d",current_state);
						else $display("FAIL");
					9: if (~ALUsrc & (ALUop == 4)) $display("PASS state %d",current_state);
						else $display("FAIL");
					10: if (RegW2 & (Regsrc == 2)) $display("PASS state %d",current_state);
						else $display("FAIL");
					11: if (writePC & PCsrc) $display("PASS state %d",current_state);
						else $display("FAIL");
					12: if (restore) $display("PASS state %d",current_state);
						else $display("FAIL");
					13: if (writePC & ~PCsrc & ImRPC) $display("PASS state %d",current_state);
						else $display("FAIL");
					14: $display("Delaying for bop: state 14");
					15: if (writePC & writeRA & ~ImRPC & ~PCsrc) $display("PASS state %d",current_state);
						else $display("FAIL");
					16: if (backup) $display("PASS state %d",current_state);
						else $display("FAIL");
					17: if (~writeCR & RegR1 & RegR2) $display("PASS state %d",current_state);
						else $display("FAIL");
					18: begin
							case (op)
								12: if (ALUsrc & (ALUop == 2)) $display("PASS state %d, add",current_state); //add
									 else $display("FAIL");
								13: if (ALUsrc & (ALUop == 3)) $display("PASS state %d, sub",current_state); //sub
									 else $display("FAIL");
								14: if (ALUsrc & (ALUop == 0)) $display("PASS state %d, and",current_state); //and
									 else $display("FAIL");
								15: if (ALUsrc & (ALUop == 1)) $display("PASS state %d, orr",current_state); //orr
									 else $display("FAIL");
								default: $display("wrong opcode");
							endcase
						end
					19: if (RegW2 & (Regsrc == 2)) $display("PASS state %d",current_state);
						else $display("FAIL");
					20: if (ALUsrc & (ALUop == 5)) $display("PASS state %d",current_state);
						else $display("FAIL");
					21: if (writeCR & RegW1) $display("PASS state %d",current_state);
						else $display("FAIL");
					22: if (RegW2 & (Regsrc == 3)) $display("PASS state %d",current_state);
						else $display("FAIL");
					default: $display("Not a valid state");
					
				endcase
					
			// increment opcode at end of each instruction
			if ((current_state == 0) & (op != 15)) begin
				op = op + 1;
				#1;
			end else begin
				#1;
			end
		end
	end
	
	always clk = #0.5 ~clk;
      
endmodule

