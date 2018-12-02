module branch_ctrl(setx, N_extended, target, B_read, op, branch_ctrl, isNotEqual, isLessThan, jump_address, pc_dx);

	input setx, isNotEqual, isLessThan;
	input [4:0] op;
	input [26:0] target;
	input [31:0] B_read, N_extended, pc_dx;
	
	output branch_ctrl;
	output [31:0] jump_address;
	
	// instantiate mini_ALU for jump address computation
	wire [31:0] ALU_out;
	mini_ALU compute(.data_result(ALU_out), 
						  .data_operandA(pc_dx), .data_operandB(N_extended), 
						  .opcode(2'b00));
						  
	// shift T input
	wire [31:0] shifted_T;
	assign shifted_T[26:0] = target;
	assign shifted_T[31:27] = 5'b00000;
	
	wire BnotZero;
	notZero Bnzero(.out(BnotZero), .i(B_read));
	
	// branch logic
	wire use_readB, use_shifted_T, use_ALU_out;
	assign use_readB = ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0]; // jr
	assign use_shifted_T = (~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0]) || /* j */
								  (~op[4] & ~op[3] & ~op[2] &  op[1] & op[0]) || /* jal */
								  ( op[4] & ~op[3] &  op[2] & ~op[1] & op[0]) || /* setx*/
								  ((op[4] & ~op[3] &  op[2]  & op[1] & ~op[0]) & BnotZero); // bex
	assign use_ALU_out = ((~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0]) & isNotEqual) ||
								((~op[4] & ~op[3] &  op[2] & op[1] & ~op[0]) & ~isLessThan);

	
	// decide what to set jump address as
	mytri32 mytri0(.out(jump_address), .in(B_read), .enable(use_readB));
	mytri32 mytri1(.out(jump_address), .in(shifted_T), .enable(use_shifted_T));
	mytri32 mytri2(.out(jump_address), .in(ALU_out), .enable(use_ALU_out));
	
	// assign branch control bit
	assign branch_ctrl = use_readB || (use_shifted_T & ~setx) || use_ALU_out;
								
endmodule