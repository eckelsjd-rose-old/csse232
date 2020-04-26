`timescale 1ns / 1ps

module control_unit(
    input [3:0] op,
	 input clk,
	 input Reset,
	 
    output reg PCsrc,
    output reg writePC,
    output reg writeRA,
    output reg ImRPC,
    output reg Memsrc,
    output reg MemW1,
    output reg MemW2,
    output reg MemR1,
    output reg MemR2,
    output reg writeCR,
    output reg [1:0] Regsrc,
    output reg backup,
    output reg restore,
    output reg RegW1,
    output reg RegW2,
    output reg RegR1,
    output reg RegR2,
    output reg ALUsrc,
    output reg [2:0] ALUop,
    output reg cmpeq,
	 output reg cmpne,
	 output reg resetSig,
	 
	 // track the state
	 output reg [4:0] current_state,
	 output reg[4:0] next_state
    );

	 // state definitions
	 parameter		Fetch = 0;
	 parameter		I_decode = 1;
	 parameter		I_str_ex = 2;
	 parameter		I_str_mem = 3;
	 parameter		I_lda_mem = 4;
	 parameter		I_lda_wb = 5;
	 parameter		I_ldi_ex = 6;
	 parameter		I_beq_ex = 7;
	 parameter		I_bne_ex = 8;
	 parameter		I_sft_ex = 9;
	 parameter		I_sft_mem = 10;
	 parameter		I_ret_decode = 11;
	 parameter		I_ret_ex = 12; // combined with state 11
	 parameter		I_bop_decode = 13;
	 parameter		I_bop_ex = 14;
	 parameter		I_cal_decode = 15;
	 parameter		I_cal_ex = 16; // combined with state 15
	 parameter		G_decode = 17;
	 parameter		G_ex = 18;
	 parameter		G_mem = 19;
	 parameter		G_slt_ex = 20;
	 parameter		G_slt_mem = 21;
	 parameter		G_cop_ex = 22;
	 parameter		reset = 23;
		
	//Output signals
	always @ (current_state) begin
			// reset signals
			PCsrc = 0;
			writePC = 0;
			writeRA = 0;
			ImRPC = 0;
			Memsrc = 0;
			MemW1 = 0;
			MemW2 = 0;
			MemR1 = 0;
			MemR2 = 0;
			writeCR = 0;
			Regsrc = 0;
			backup = 0;
			restore = 0;
			RegW1 = 0;
			RegW2 = 0;
			RegR1 = 0;
			RegR2 = 0;
			ALUsrc = 0;
			ALUop = 0;
			cmpeq = 0;
			cmpne = 0;
			resetSig = 0;
			
			case (current_state)
			
				reset:
					begin
						writePC = 1;
						resetSig = 1;
					end
			
				Fetch:
					begin
						PCsrc = 0;
						writePC = 1;
						Memsrc = 0;
						MemR1 = 1;
						MemR2 = 1;
					end
				
				I_decode:
					begin
						PCsrc = 0;
						writePC = 1;
						writeCR = 0;
						RegR1 = 1;
						RegR2 = 1;
					end
					
				I_str_ex:
					begin
						ALUsrc = 0;
						ALUop = 2;
					end
				
				I_str_mem:
					begin
						Memsrc = 1;
						MemW2 = 1;
					end
				
				I_lda_mem:
					begin
						MemR2 = 1;
						Memsrc = 1;
					end
				
				I_lda_wb:
					begin
						Regsrc = 1;
						RegW2 = 1;
					end
					
				I_ldi_ex:
					begin
						Regsrc = 0;
						RegW2 = 1;
					end
						
				I_beq_ex:
					begin
						cmpeq = 1;
						PCsrc = 0;
					end
					
				I_bne_ex:
					begin
						cmpne = 1;
						PCsrc = 0;
					end
					
				I_sft_ex:
					begin
						ALUsrc = 0;
						ALUop = 4;
					end
					
				I_sft_mem:
					begin
						Regsrc = 2;
						RegW2 = 1;
					end
					
				I_ret_decode:
					begin
						writePC = 1;
						writeRA = 1;
						PCsrc = 1;
						restore = 1;
					end
					
				I_bop_decode:
					begin
						writePC = 1;
						PCsrc = 0;
						ImRPC = 1;
					end
					
				I_bop_ex:
					begin
						//delay;
					end
					
				I_cal_decode:
					begin
						writePC = 1;
						writeRA = 1;
						ImRPC = 1;
						PCsrc = 0;
						backup = 1;
					end
					
				G_decode:
					begin
						writeCR = 0;
						RegR1 = 1;
						RegR2 = 1;
					end
					
				G_ex:
					begin
						ALUsrc = 1;
						case (op)
							12: ALUop = 2; //add
							13: ALUop = 3; //sub
							14: ALUop = 0; //and
							15: ALUop = 1; //orr
							default: $display("Wrong opcode");
						endcase
					end
					
				G_mem:
					begin
						Regsrc = 2;
						RegW2 = 1;
					end
					
				G_slt_ex:
					begin
						ALUsrc = 1;
						ALUop = 5;
					end
					
				G_slt_mem:
					begin
						writeCR = 1;
						RegW1 = 1;
					end
					
				G_cop_ex:
					begin
						Regsrc = 3;
						RegW2 = 1;
					end
				
				default:
					begin
						$display("Not implemented");
					end
					
			endcase
			
		end
	
	//Current State calculation
	always @ (posedge clk) begin
		
			// $display("The current state is %d", current_state);
			if (Reset) current_state = reset;
			else begin
				case (current_state)
					
					reset:
						current_state = Fetch;
						
					Fetch:
						begin
							case (op)
								0: current_state = I_decode; //lda
								1: current_state = I_decode; //ldi
								2: current_state = I_decode; //str
								3: current_state = I_bop_decode; //bop
								4: current_state = I_cal_decode; //cal
								5: current_state = I_decode; //beq
								6: current_state = I_decode; //bne
								7: current_state = I_decode; //sft
								8: current_state = G_decode; //cop
								9: begin
										$display("Empty opcode 9"); //empty
										//current_state = Fetch;
									end
								10: current_state = G_decode; //slt
								11: current_state = I_ret_decode; //ret
								12: current_state = G_decode; //add
								13: current_state = G_decode; //sub
								14: current_state = G_decode; //and
								15: current_state = G_decode; //orr
								//default: $display("Wrong opcode");
							endcase
						end	
					
					I_decode:
						begin
							case (op)
								0: current_state = I_str_ex; //lda
								1: current_state = I_ldi_ex; //ldi
								2: current_state = I_str_ex; //str
								5: current_state = I_beq_ex; //beq
								6: current_state = I_bne_ex; //bne
								7: current_state = I_sft_ex; //sft
								11: current_state = I_ret_decode;
								default: current_state = G_decode;
							endcase
						end
					
					I_str_ex:
						begin
							case (op)
								0: current_state = I_lda_mem; //lda
								2: current_state = I_str_mem; //str
								default: $display("Wrong opcode");
							endcase
						end
					
					I_str_mem:
						begin
							current_state = Fetch;
						end
					
					I_lda_mem:
						begin
							current_state = I_lda_wb;
						end
					
					I_lda_wb:
						begin
							current_state = Fetch;
						end
						
					I_ldi_ex:
						begin
							current_state = Fetch;
						end
							
					I_beq_ex:
						begin
							current_state = Fetch;
						end
						
					I_bne_ex:
						begin
							current_state = Fetch;
						end
						
					I_sft_ex:
						begin
							current_state = I_sft_mem;
						end
						
					I_sft_mem:
						begin
							current_state = Fetch;
						end
						
					I_ret_decode:
						begin
							case (op)
								0: current_state = I_decode; //lda
								1: current_state = I_decode; //ldi
								2: current_state = I_decode; //str
								3: current_state = I_bop_decode; //bop
								4: current_state = I_cal_decode; //cal
								5: current_state = I_decode; //beq
								6: current_state = I_decode; //bne
								7: current_state = I_decode; //sft
								8: current_state = G_decode; //cop
								9: begin
										$display("Empty opcode 9"); //empty
										//current_state = Fetch;
									end
								10: current_state = G_decode; //slt
								11: current_state = Fetch; //ret
								12: current_state = G_decode; //add
								13: current_state = G_decode; //sub
								14: current_state = G_decode; //and
								15: current_state = G_decode; //orr
								//default: $display("Wrong opcode");
							endcase
						end
						
					I_bop_decode:
						begin
							current_state = I_bop_ex;
						end
						
					I_bop_ex:
						begin
							case (op)
								0: current_state = I_decode; //lda
								1: current_state = I_decode; //ldi
								2: current_state = I_decode; //str
								3: current_state = Fetch; //bop
								4: current_state = I_cal_decode; //cal
								5: current_state = I_decode; //beq
								6: current_state = I_decode; //bne
								7: current_state = I_decode; //sft
								8: current_state = G_decode; //cop
								9: begin
										$display("Empty opcode 9"); //empty
										//current_state = Fetch;
									end
								10: current_state = G_decode; //slt
								11: current_state = I_ret_decode; //ret
								12: current_state = G_decode; //add
								13: current_state = G_decode; //sub
								14: current_state = G_decode; //and
								15: current_state = G_decode; //orr
								//default: $display("Wrong opcode");
							endcase
						end
						
					I_cal_decode:
						begin
							case (op)
								0: current_state = I_decode; //lda
								1: current_state = I_decode; //ldi
								2: current_state = I_decode; //str
								3: current_state = I_bop_decode; //bop
								4: current_state = Fetch; //cal
								5: current_state = I_decode; //beq
								6: current_state = I_decode; //bne
								7: current_state = I_decode; //sft
								8: current_state = G_decode; //cop
								9: begin
										$display("Empty opcode 9"); //empty
										//current_state = Fetch;
									end
								10: current_state = G_decode; //slt
								11: current_state = I_ret_decode; //ret
								12: current_state = G_decode; //add
								13: current_state = G_decode; //sub
								14: current_state = G_decode; //and
								15: current_state = G_decode; //orr
								//default: $display("Wrong opcode");
							endcase
						end
						
					G_decode:
						begin
							case (op)
								8: current_state = G_cop_ex; //cop
								10: current_state = G_slt_ex; //slt
								12: current_state = G_ex; //add
								13: current_state = G_ex; //sub
								14: current_state = G_ex; //and
								15: current_state = G_ex; //orr
								3: current_state = I_bop_decode;
								4: current_state = I_cal_decode;
								11: current_state = I_ret_decode;
								default: current_state = I_decode;
							endcase
						end
						
					G_ex:
						begin
							current_state = G_mem;
						end
						
					G_mem:
						begin
							current_state = Fetch;
						end
						
					G_slt_ex:
						begin
							current_state = G_slt_mem;
						end
						
					G_slt_mem:
						begin
							current_state = Fetch;
						end
						
					G_cop_ex:
						begin
							current_state = Fetch;
						end
					
					default:
						begin
							current_state = Fetch;
							$display("Not implementated state");
						end
						
				endcase
			end			
		end

endmodule
