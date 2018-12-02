module next_pc(pc_out, pc_plus1, clock, branch_ctrl, jump_address, pc_in);
	
	input clock, branch_ctrl;
	input [31:0] pc_in, jump_address;
	
	output [31:0] pc_out, pc_plus1;
	
	// add four to current PC
	mini_ALU add1(.data_result(pc_plus1), .data_operandA(pc_in), .data_operandB(32'd1), .opcode(2'b00));
	
	// decide if there's a jump
	mux21 jumpif(.enable(branch_ctrl), .in1(jump_address), .in2(pc_plus1), .out(pc_out));
	
endmodule 