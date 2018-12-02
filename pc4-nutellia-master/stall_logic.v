module stall_logic(stall, ir_dx, dx_type, ir_fd, fd_type, multdiv_on);
	
	input multdiv_on;
	input [31:0] ir_dx, ir_fd;
	input [1:0] dx_type, fd_type;
	
	output stall;
	
	// decode type for fd
	wire r_fd  = ~dx_type[1] & ~dx_type[0];
	wire i_fd  = ~dx_type[1] &  dx_type[0];

	// decode type for dx
	wire ji_dx =  dx_type[1] & ~dx_type[0];
	
	// assign reg values
	wire [4:0] fd_ir_rs = ir_fd[21:17];
	wire [4:0] fd_ir_rt = ir_fd[16:12];
	wire [4:0] dx_ir_rd = ir_dx[26:22];
	
	wire sw_fd = (~ir_fd[31] & ~ir_fd[30] &  ir_fd[29] &  ir_fd[28] &  ir_fd[27]);
	wire lw_dx = (~ir_dx[31] &  ir_dx[30] & ~ir_dx[29] & ~ir_dx[28] & ~ir_dx[27]);
	assign stall = (lw_dx &
						  ((&(fd_ir_rs ~^ dx_ir_rd) & (r_fd|i_fd) & (~ji_dx)) | 
						  ((&(fd_ir_rt ~^ dx_ir_rd) & (r_fd) & (~ji_dx)) & ~sw_fd))) | multdiv_on;

endmodule 