module MW_control(md_excep, md_rstatus, multdiv_rd, multdivRDY, rstatus, exception, ir, type, rd, MEM_out, write_to_register);
	
	input multdivRDY, md_excep;
	input [4:0] multdiv_rd;
	input [31:0] ir;
	input [1:0] type;
	input [2:0] exception, md_rstatus;
	output MEM_out, write_to_register;
	output [4:0] rd;
	
	// extend exception type to fit rstatus entry
	output [31:0] rstatus;
	assign rstatus[2:0] = md_excep ? md_rstatus : exception;
	assign rstatus[31:3] = 28'd0;
	wire NOTnop;
	notZero notnop(.out(NOTnop), .i(ir));
	
	wire j   = ~ir[31] & ~ir[30] &~ir[29] & ~ir[28] &  ir[27];
	wire jal = ~ir[31] & ~ir[30] &~ir[29] &  ir[28] &  ir[27];
	wire jr  = ~ir[31] & ~ir[30] & ir[29] & ~ir[28] & ~ir[27];
	wire setx=  ir[31] & ~ir[30] & ir[29] & ~ir[28] &  ir[27];
	wire bne = ~ir[31] & ~ir[30] &~ir[29] &  ir[28] & ~ir[27];
	wire blt = ~ir[31] & ~ir[30] & ir[29] &  ir[28] & ~ir[27];
	
	// write to r30 (rstatus) when an exception occurs
	assign rd = (~(|(exception) & ~md_excep) 
					& ~jal & ~multdivRDY & ~setx)     ? ir[26:22]  : 5'bz;
	assign rd = (|(exception) | md_excep | setx)  ? 5'b11110   : 5'bz;
	assign rd =  jal			 			  				 ? 5'b11111   : 5'bz;
	assign rd =  multdivRDY & ~md_excep 			 ? multdiv_rd : 5'bz;
	
	assign MEM_out = (~ir[31] &  ir[30] & ~ir[29] & ~ir[28] & ~ir[27]); //lw
	wire sw = (~ir[31] & ~ir[30] &  ir[29] &  ir[28] &  ir[27]);
	assign write_to_register = (|rd) & (NOTnop | (~NOTnop & multdivRDY)) 
										& ~sw & ~jr & ~bne & ~blt & ~j;
	
	
endmodule 