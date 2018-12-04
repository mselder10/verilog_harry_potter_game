module multdiv_ctrl(exception, md_rstatus, ctrl_MULT, clock, write_operands, rd, A, B, A_md, B_md, rd_md, IN_PROGRESS, resultRDY, write, reset);
	
	input resultRDY, write, reset, write_operands, clock, ctrl_MULT, exception;
	input [4:0] rd;
	input [31:0] A, B;
	output [2:0] md_rstatus;
	output IN_PROGRESS;
	output [4:0] rd_md;
	output [31:0] A_md, B_md;
	
	// for knowing what exception type
	wire mult;
	dflipflop e0(.d(ctrl_MULT), .clk(clock), .clr(reset), .prn(1'b0), 
					 .ena(write), .q(mult));
	
	assign md_rstatus = (resultRDY & mult & exception) ? 3'd4 : 3'd5;
	
	// delay ctrl_MULT and DIV by one cycle
	dflipflop t0(.d(~resultRDY), .clk(clock), .clr(reset), .prn(1'b0), 
					 .ena(resultRDY|write), .q(IN_PROGRESS));
	
	// store input operands
	register32 Amd(.data_output(A_md), .clock(clock), 
								  .ctrl_writeEnable(write_operands),
							     .clear(reset), .data_input(A));
								  
	register32 Bmd(.data_output(B_md), .clock(clock), 
								  .ctrl_writeEnable(write_operands),
							     .clear(reset), .data_input(B));
								  
	// store destination
	dflipflop rd0(.d(rd[0]), .clk(clock), .clr(reset), .prn(1'b0), .ena(write), .q(rd_md[0]));
	dflipflop rd1(.d(rd[1]), .clk(clock), .clr(reset), .prn(1'b0), .ena(write), .q(rd_md[1]));
	dflipflop rd2(.d(rd[2]), .clk(clock), .clr(reset), .prn(1'b0), .ena(write), .q(rd_md[2]));
	dflipflop rd3(.d(rd[3]), .clk(clock), .clr(reset), .prn(1'b0), .ena(write), .q(rd_md[3]));
	dflipflop rd4(.d(rd[4]), .clk(clock), .clr(reset), .prn(1'b0), .ena(write), .q(rd_md[4]));
	

endmodule 