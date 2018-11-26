module FD(out_type, pc_out, ir_out, in_type, ir_in, pc_in, flush, stall, clock);
	
	input stall, flush, clock;
	input [1:0] in_type;
	input[31:0] pc_in, ir_in;
	
	output [1:0] out_type;
	output[31:0] pc_out, ir_out;
	
	// PC
	register32 pc(.clock(clock), .ctrl_writeEnable(~stall), 
								.clear(flush), .data_input(pc_in), .data_output(pc_out));
	
	// instruction
	register32 IR(.clock(clock), .ctrl_writeEnable(~stall), 
								.clear(flush), .data_input(ir_in), .data_output(ir_out));

	// instruction type
	dflipflop t0(.d(in_type[0]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~stall), .q(out_type[0]));
	dflipflop t1(.d(in_type[1]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~stall), .q(out_type[1]));
	
	

endmodule 