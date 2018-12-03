module bypass_ctrl(ir_dx, dx_type, ir_xm, xm_type, ir_mw, mw_type, sw, we, stall,
						 ctrl_readRegA, ctrl_readRegB,
						 ctrl_bypassA, ctrl_bypassB, ctrl_bypassD, ctrl_bypassReadA, ctrl_bypassReadB);
	
	input sw, we, stall;
	input [1:0] dx_type, xm_type, mw_type;
	input [4:0] ctrl_readRegA, ctrl_readRegB;
	input [31:0] ir_dx, ir_xm, ir_mw;
	
	output [1:0] ctrl_bypassA, ctrl_bypassB;
	output ctrl_bypassReadA, ctrl_bypassReadB, ctrl_bypassD;

	// decode type for dx
	wire r_dx  = ~dx_type[1] & ~dx_type[0];
	wire i_dx  = ~dx_type[1] &  dx_type[0];
	
	// decode type for xm
	wire r_xm  = ~xm_type[1] & ~xm_type[0];
	wire i_xm  = ~xm_type[1] &  xm_type[0];
	wire ji_xm =  xm_type[1] & ~xm_type[0];
	
	// decode type for mw
	wire ji_mw =  mw_type[1] & ~mw_type[0];
	
	
	wire jal_mw = ~ir_mw[31] & ~ir_mw[30] & ~ir_mw[29] &  ir_mw[28] &  ir_mw[27];
	wire jal_xm = ~ir_xm[31] & ~ir_xm[30] & ~ir_xm[29] &  ir_xm[28] &  ir_xm[27];
	
	// get source registers
	wire [4:0] dx_ir_rs = ir_dx[21:17];
	wire [4:0] xm_ir_rd = jal_xm ? 5'b11111 : ir_xm[26:22];
	wire [4:0] mw_ir_rd = jal_mw ? 5'b11111 : ir_mw[26:22];
	wire [4:0] xm_ir_rs = ir_xm[21:17];
	
	wire rd_read_dx = (~ir_dx[31] & ~ir_dx[30] &  ir_dx[29] &  ir_dx[28] &  ir_dx[27]) | // sw
							(~ir_dx[31] & ~ir_dx[30] &	~ir_dx[29] &  ir_dx[28] & ~ir_dx[27]) | // bne
							(~ir_dx[31] & ~ir_dx[30] &  ir_dx[29] &  ir_dx[28] & ~ir_dx[27]) | // blt
							(~ir_dx[31] & ~ir_dx[30] &  ir_dx[29] & ~ir_dx[28] & ~ir_dx[27]);  //jr
	wire [4:0] dx_ir_rt = rd_read_dx ?  ir_dx[26:22] : ir_dx[16:12];
	
	wire rd_read_xm = (~ir_xm[31] & ~ir_xm[30] &  ir_xm[29] &  ir_xm[28] &  ir_xm[27]) | // sw
							(~ir_xm[31] & ~ir_xm[30] &	~ir_xm[29] &  ir_xm[28] & ~ir_xm[27]) | // bne
							(~ir_xm[31] & ~ir_xm[30] &  ir_xm[29] &  ir_xm[28] & ~ir_xm[27]) | // blt
							(~ir_xm[31] & ~ir_xm[30] &  ir_xm[29] & ~ir_xm[28] & ~ir_xm[27]);  //jr
	
	// check if instructions are no ops
	wire notZero_dx, notZero_xm, notZero_mw;
	notZero dx(.out(notZero_dx), .i(ir_dx));
	notZero xm(.out(notZero_xm), .i(ir_xm));
	notZero mw(.out(notZero_mw), .i(ir_mw));
	
	wire rd_read_mw = (~ir_mw[31] & ~ir_mw[30] &  ir_mw[29] &  ir_mw[28] &  ir_mw[27]) | // sw
							(~ir_mw[31] & ~ir_mw[30] &	~ir_mw[29] &  ir_mw[28] & ~ir_mw[27]) | // bne
							(~ir_mw[31] & ~ir_mw[30] &  ir_mw[29] &  ir_mw[28] & ~ir_mw[27]) | // blt
							(~ir_mw[31] & ~ir_mw[30] &  ir_mw[29] & ~ir_mw[28] & ~ir_mw[27]);  //jr
	
	// encode A bypass
	assign ctrl_bypassA[0] = &(dx_ir_rs ~^ mw_ir_rd) & (r_dx|i_dx) & (~ji_mw) & notZero_dx & notZero_mw & ~rd_read_mw;
	assign ctrl_bypassA[1] = &(dx_ir_rs ~^ xm_ir_rd) & (r_dx|i_dx) & (~ji_xm) & notZero_dx & notZero_xm & ~rd_read_xm;
	
	// encode B bypass
	assign ctrl_bypassB[0] = &(dx_ir_rt ~^ mw_ir_rd) & (r_dx) & (~ji_mw) & notZero_dx & notZero_mw & ~rd_read_mw;
	assign ctrl_bypassB[1] = &(dx_ir_rt ~^ xm_ir_rd) & (r_dx) & (~ji_xm) & notZero_dx & notZero_xm & ~rd_read_xm;
	
	// encode D bypass
	assign ctrl_bypassD    = &(xm_ir_rd ~^ mw_ir_rd) & (r_xm|i_xm) & (~ji_mw) & sw & notZero_xm & notZero_mw;
	
	// encode readA bypass (reg being written same cycle as being read)
	assign ctrl_bypassReadA = &(ctrl_readRegA ~^ mw_ir_rd) & (~ji_mw) & notZero_mw & we & ~stall;
	
	// encode readB bypass (reg being written same cycle as being read)
	assign ctrl_bypassReadB = &(ctrl_readRegB ~^ mw_ir_rd) & (~ji_mw) & notZero_mw & we & ~stall;
	
endmodule