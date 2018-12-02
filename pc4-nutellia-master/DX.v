module DX(out_type, outA, outB, pc_out, immediate_out, immediate_in, ir_out, in_type, inA, inB, pc_in, ir_in, clock, flush, block);
	
	input clock, flush, block;
	input [1:0] in_type;
	input [31:0] immediate_in;
	input [31:0] inA, inB, pc_in, ir_in;
	output [1:0] out_type;
	output [31:0] outA, outB, pc_out, ir_out, immediate_out;
	
	// values
	register32 pipe_regA(.clock(clock), .ctrl_writeEnable(~block), 
								.clear(flush), .data_input(inA), .data_output(outA));
	register32 pipe_regB(.clock(clock), .ctrl_writeEnable(~block), 
								.clear(flush), .data_input(inB), .data_output(outB));
	
	// PC
	register32 pipe_regPC(.clock(clock), .ctrl_writeEnable(~block), 
								 .clear(flush), .data_input(pc_in), .data_output(pc_out));
	
	// instruction
	register32 pipe_regIR(.clock(clock), .ctrl_writeEnable(~block), 
								 .clear(flush), .data_input(ir_in), .data_output(ir_out));
	
	// sign extended immediate
	register32 pipe_regIM(.clock(clock), .ctrl_writeEnable(~block), 
								 .clear(flush), .data_input(immediate_in), 
								 .data_output(immediate_out));
	
	// store instruction type
	dflipflop t0(.d(in_type[0]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~block), .q(out_type[0]));
	dflipflop t1(.d(in_type[1]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~block), .q(out_type[1]));

endmodule 