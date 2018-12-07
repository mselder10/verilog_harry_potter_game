module MW(in_exception, out_exception, out_type, outALU, outMEM, ir_out, in_type, inALU, inMEM, ir_in, clock, flush, block);
	
	input clock, flush, block;
	input [2:0] in_exception;
	input [1:0] in_type;
	input [31:0] inALU, inMEM, ir_in;
	
	output [1:0] out_type;
	output [2:0] out_exception;
	output [31:0] outALU, outMEM, ir_out;
	
	// values
	register pipe_regA(clock, ~block, flush, inALU,  outALU);
	register pipe_regB(clock, ~block, flush, inMEM, outMEM);
	
	// instruction
	register pipe_regIR(clock, ~block, flush, ir_in, ir_out);
	
	// instruction type
	dflipflop t0(.d(in_type[0]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~block), .q(out_type[0]));
	dflipflop t1(.d(in_type[1]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~block), .q(out_type[1]));
	
	// ALU exception
	dflipflop e0(.d(in_exception[0]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~block), .q(out_exception[0]));
	dflipflop e1(.d(in_exception[1]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~block), .q(out_exception[1]));
	dflipflop e2(.d(in_exception[2]), .clk(clock), .clr(flush), .prn(1'b0), .ena(~block), .q(out_exception[2]));

endmodule 