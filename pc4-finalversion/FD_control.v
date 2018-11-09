module FD_control(type, ir, readA, readB, load_multdiv_operands);

	input [1:0] type;
	input [31:0] ir;
	
	wire r, i;
	wire read_rd;
	
	output [4:0] readA, readB;
	
	assign r = ~type[1] & ~type[0];
	assign i = ~type[1] &  type[0];
	
	output load_multdiv_operands = r & (~ir[6] & ~ir[5] & ir[4] & ir[3]);
	
	// rd as source flag is extra top bit of type
	assign read_rd = (~ir[31] & ~ir[30] &  ir[29] &  ir[28] &  ir[27]) | /*sw*/
						  (~ir[31] & ~ir[30] & ~ir[29] &  ir[28] & ~ir[27]) | /*bne*/
						  (~ir[31] & ~ir[30] &  ir[29] &  ir[28] & ~ir[27]) | /*blt*/
						  (~ir[31] & ~ir[30] &  ir[29] & ~ir[28] & ~ir[27]) ; /*jr*/
	// read rstatus
	wire read_30 = ( ir[31] & ~ir[30] &  ir[29] &  ir[28] & ~ir[27]); // bex
	
	assign readA = r|i 			  ? ir[21:17] : 5'bz;
	assign readB = r & ~read_rd  ? ir[16:12] : 5'bz;
	assign readB = read_rd       ? ir[26:22] : 5'bz;
	assign readB = read_30       ? 5'b11110  : 5'bz;
	
endmodule