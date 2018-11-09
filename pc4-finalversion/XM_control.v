module XM_control(ir, write_to_MEM, write_from_MEM);

	input [31:0] ir;
	
	output write_from_MEM, write_to_MEM;
	
	assign write_to_MEM   = ~ir[31] & ~ir[30] &  ir[29] &  ir[28] &  ir[27];
	assign write_from_MEM = ~ir[31] &  ir[30] & ~ir[29] & ~ir[28] & ~ir[27];

endmodule 