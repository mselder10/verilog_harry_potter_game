module pipeline_register(outA, outB, pc_out, ir_out, inA, inB, pc_in, ir_in, clock, flush, block);
	
	input clock, flush, block;
	input [31:0] inA, inB, pc_in, ir_in;
	output [31:0] outA, outB, pc_out, ir_out;
	
	// values
	register pipe_regA( clock, ~block, flush, inA, outA);
	register pipe_regB( clock, ~block, flush, inB, outB);
	
	// PC
	register pipe_regPC(clock, ~block, flush, pc_in, pc_out);
	
	// instruction
	register pipe_regIR(clock, ~block, flush, ir_in, ir_out);
	

endmodule 