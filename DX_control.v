module DX_control(setx, jal, ALU_exception, ALU_ovf, ctrl_MULT, ctrl_DIV, ALU_B, B_read, type, ir, ALUop, shamt, extended, jump_target);
	
	input ALU_ovf;
	input [1:0] type;
	input [31:0] ir, extended, B_read;
	
	output jal, setx;
	output ctrl_MULT, ctrl_DIV;
	output [2:0] ALU_exception;
	output [26:0] jump_target;
	output [4:0] ALUop, shamt;
	output [31:0] ALU_B;
	
	// decode type
	wire r  = ~type[1] & ~type[0];
	wire i  = ~type[1] &  type[0];
	wire ji =  type[1] & ~type[0];
	//assign jii=  type[1] &  type[0];
						  
	assign ctrl_MULT = r & ~ir[6] & ~ir[5] & ir[4] &  ir[3] & ~ir[2];
	assign ctrl_DIV  = r & ~ir[6] & ~ir[5] & ir[4] &  ir[3] &  ir[2];
	assign jal       = ~ir[31] & ~ir[30] &~ir[29] &  ir[28] &  ir[27];
	assign setx      =  ir[31] & ~ir[30] & ir[29] & ~ir[28] &  ir[27];
	wire addi        = ~ir[31] & ~ir[30] & ir[29] & ~ir[28] &  ir[27];
	wire sw          = ~ir[31] & ~ir[30] &  ir[29] &  ir[28] &  ir[27];
	wire lw          = ~ir[31] &  ir[30] & ~ir[29] & ~ir[28] & ~ir[27];
	wire bne_blt	  = (~ir[31] & ~ir[30] &	~ir[29] &  ir[28] & ~ir[27]) | // bne
							 (~ir[31] & ~ir[30] &  ir[29] &  ir[28] & ~ir[27]);
	
	
	// decode instruction
	assign ALUop       = r ?    ir[6:2] : 5'bz;
	assign ALUop       = addi|sw|lw ? 5'd0    : 5'bz;
	assign ALUop		 = bne_blt ? 5'b00001: 5'bz;
	assign shamt       = r ?    ir[11:7]: 5'bz;
	assign ALU_B   	 = i&~bne_blt ?    extended: B_read;
	assign jump_target = ji?    ir[26:0]: 26'bz;
	
	// add exception
	assign ALU_exception = (r & (~ir[6] & ~ir[5] & ~ir[4] & ~ir[3] & ~ir[2]) & ALU_ovf) ? 3'b001 : 3'bz; // add overflow
	// addi exception
	assign ALU_exception = addi & ALU_ovf ? 3'b010 : 3'bz; // addi overflow
	// sub exception
	assign ALU_exception = (r & (~ir[6] & ~ir[5] & ~ir[4] & ~ir[3] &  ir[2]) & ALU_ovf) ? 3'b011 : 3'bz; // sub overflow
	
	assign ALU_exception = ~ALU_ovf ? 3'b000 : 3'bz;
	
endmodule