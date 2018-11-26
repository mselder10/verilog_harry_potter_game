/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB,                   // I: Data from port B of regfile


);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

/***********************************************************************
												PC
*************************************************************************/
	 // instantiate program counter (PC) register
	 wire [31:0] write_pc, pc;
	 register pc_register(.data_output(pc), .clock(~clock), 
									.ctrl_writeEnable(~stall),
									.clear(reset), .data_input(write_pc));
									
	 // set up PC control
	 wire [31:0] jump_address, next_pc;
	 next_pc npc(.pc_out(write_pc), .pc_plus1(next_pc), .clock(~clock), 
					 .branch_ctrl(take_branch), .jump_address(jump_address), 
					 .pc_in(pc));
					 
/***********************************************************************
										FETCH STAGE
*************************************************************************/
	 // send pc to imem address port
	 assign address_imem = pc[11:0];
	 
	 // instantiate instruction type decoder (instr returned from imem)
	 wire [1:0] type;
	 decode_inst_type op(.type(type), .op(q_imem[31:27]));

	 // instantiate FD pipeline register
	 wire [1:0] fd_type;
	 wire [31:0] pc_fd, ir_fd_read, ir_fd;
	 FD fd(.pc_out(pc_fd), .ir_out(ir_fd_read), .pc_in(pc), 
			 .ir_in(q_imem), .stall(stall), 
			 .clock(clock), .flush(flush),
			 .in_type(type), .out_type(fd_type));
			 
	 // fetch stage controls
	 wire load_multdiv_operands;
	 FD_control fd_ctrl(.readA(ctrl_readRegA), .readB(ctrl_readRegB), 
							  .type(fd_type), .ir(ir_fd_read),
							  .load_multdiv_operands(load_multdiv_operands));

	 // sign extend immediate
	 wire [31:0] extended_immediate;
	 sign_extend se_immediate(.out(extended_immediate), 
									  .in(ir_fd_read[16:0]));
	
 	 // bypass if reading a value that is being written in same cycle
	 wire [31:0] tempA, tempB;
	 mux21 muxreadA(.out(tempA), .enable(ctrl_bypassReadA),
						 .in1(data_writeReg), .in2(data_readRegA));
    mux21 muxreadB(.out(tempB), .enable(ctrl_bypassReadB),
						 .in1(data_writeReg), .in2(data_readRegB));
						 
	 // determine if no op
	 mux21 muxNOP(.out(ir_fd), 
					  .in1(32'd0), .in2(ir_fd_read),
					  .enable(stall | take_branch));
					  
/***********************************************************************
								 EXECUTE & BRANCHING
*************************************************************************/
	 // instantiate DX pipeline register
	 wire [1:0] dx_type;
	 wire [31:0] A_read, B_read, extended_N, pc_dx,ir_dx;
	 wire [31:0] B;
	 DX dx(.outA(A_read), .outB(B_read), .pc_out(pc_dx), .ir_out(ir_dx), 
			 .immediate_out(extended_N), .immediate_in(extended_immediate),
		    .inA(tempA), .inB(tempB), 
				.pc_in(pc_fd), .ir_in(ir_fd),
		    .clock(clock), .flush(flush), 
			 .block(multdiv_on),
			 .in_type(fd_type), .out_type(dx_type));
			 
	 // execute stage controls
	 wire ctrl_MULT, ctrl_DIV, jal, setx;
	 wire [2:0] ALU_exception; 
	 wire [4:0] ALUop, shamt;
	 wire [26:0] target;
	 wire [31:0] tB;
	 DX_control dx_ctrl(.ALU_B(B), .B_read(tB), .type(dx_type), 
							  .ir(ir_dx), .ALUop(ALUop), .shamt(shamt), .jal(jal),
							  .extended(extended_N), .jump_target(target), 
							 .ctrl_MULT(ctrl_MULT), .ctrl_DIV(ctrl_DIV),
							 .ALU_exception(ALU_exception), .ALU_ovf(OVF), 
							 .setx(setx));
							 
	 // instantiate branch control 
	 branch_ctrl branching(.N_extended(extended_N), .target(target), 
								  .B_read(tB),
								  .op(ir_dx[31:27]), .branch_ctrl(take_branch),
								  .isNotEqual(INE), .isLessThan(ILT), 
								  .jump_address(jump_address), .pc_dx(pc_dx),
								  .setx(setx));
	 
	 // determine ALU A and tB inputs 
	 // (tB vs. immediate decided in DX_control)
	 wire [31:0] A;
	 mux31 muxA(.out(A), .e0(~ctrl_bypassA[1] & ~ctrl_bypassA[0]), 
								.in0(A_read),
								.e1(ctrl_bypassA[0]), .in1(data_writeReg),
								.e2(ctrl_bypassA[1]), .in2(mem_dest));
	 mux31 muxB(.out(tB),.e0(~ctrl_bypassB[0] & ~ctrl_bypassB[1]), 
								.in0(B_read),
								.e1(ctrl_bypassB[0]), .in1(data_writeReg),
								.e2(ctrl_bypassB[1]), .in2(mem_dest));					
	 
	 // instantiate ALU
	 wire INE, ILT, OVF;
	 wire [31:0] ALU_out;
	 alu ALU(.data_operandA(A), .data_operandB(B), .ctrl_ALUopcode(ALUop),
				.ctrl_shiftamt(shamt), .data_result(ALU_out), 
				.isNotEqual(INE), .isLessThan(ILT), .overflow(OVF));
	 
	 //check if it is a multiplication or division if so output should come from there
	 /*wire mult, div;
	 wire [31:0]  ALU_out_result1;
	 
	 output [31:0] ALU_out_result,mult_result, div_result;
	 
		reg [31:0] a;
		reg [31:0] b;

		reg [31:0] r1;
		reg [31:0] r2;

		initial begin
          a<=A;
			 b<=B;
			r1 = $signed(a) * $signed(b); 
			r2 = $signed(a) / $signed(b);
		end
	 
	 
	 assign mult_result = r1; //$signedA*B;
	 assign div_result = r2; //A/B;
	 assign ALU_out_result1 = ctrl_MULT ? mult_result : ALU_out;
	 assign ALU_out_result = ctrl_DIV ? div_result : ALU_out_result1;*/
	 
	 // determine if special case (setx, jal) or ALU output
	 wire [31:0] DX_out;
	 mux31 muxDXout(.out(DX_out),
								.e0(~jal & ~setx), .in0(ALU_out_result),
								.e1(jal), .in1(pc_dx),
								.e2(setx), .in2(jump_address));
								
/***********************************************************************
											MULTDIV
*************************************************************************/	 
	 wire mdexp, multdiv_resultRDY, multdiv_on;
	 wire [2:0] md_rstatus;
	 wire [4:0] multdiv_rd;
	 wire [31:0] A_md, B_md, multdiv_out;
	 multdiv md(.data_operandA(A_md), .data_operandB(B_md), 
					.ctrl_MULT(ctrl_MULT), 
					.ctrl_DIV(ctrl_DIV), 
					.clock(clock), .data_exception(mdexp),
					.data_result(multdiv_out), 
					.data_resultRDY(multdiv_resultRDY));
			
	 multdiv_ctrl mdctrl(.rd(ir_dx[26:22]), .rd_md(multdiv_rd),
								.A(tempA), .B(tempB), .A_md(A_md), .B_md(B_md), 
								.IN_PROGRESS(multdiv_on), 
								.resultRDY(multdiv_resultRDY), 
								.write_operands(load_multdiv_operands), 
								.write(ctrl_MULT | ctrl_DIV),
								.reset(reset), .clock(clock), 
								.ctrl_MULT(ctrl_MULT), 
								.exception(mdexp), .md_rstatus(md_rstatus));
								
/***********************************************************************
										MEMORY STAGE
*************************************************************************/
	 // instantiate XM pipeline register
	 wire [1:0] xm_type;
	 wire [2:0] excep_xm;
	 wire [31:0] O, mem_dest, ir_xm, regDATA; 
	 XM xm(.outALU(mem_dest), .outDATA(regDATA), .ir_out(ir_xm), 
		    .inALU(DX_out), .inB(tB), .ir_in(ir_dx),
		    .clock(clock), .flush(reset | multdiv_on), .block(stall_XM),
			 .in_type(dx_type), .out_type(xm_type),
			 .in_exception(ALU_exception), .out_exception(excep_xm));
	 
	 // memory stage control
	 wire lw, sw;
	 XM_control xm_ctrl(.ir(ir_xm), .write_to_MEM(wren), 
							  .write_from_MEM(lw));
		
    // set dmem address and possibly bypass input data
	 assign address_dmem = mem_dest[11:0];
	 mux21 muxD(.enable(ctrl_bypassD),.in1(data_writeReg), .in2(regDATA),
					.out(data));
/***********************************************************************
										WRITE STAGE
*************************************************************************/
	 // instantiate MW pipeline register
	 wire [1:0] mw_type;
	 wire [2:0] excep_mw;
	 wire [31:0] outDATA, outMEM, rstat, ir_mw;
	 MW mw(.outALU(outDATA), .outMEM(outMEM), .ir_out(ir_mw), 
		    .inALU(mem_dest), .inMEM(q_dmem), .ir_in(ir_xm),
		    .clock(clock), .flush(reset), .block(stall_MW),
			 .in_type(xm_type), .out_type(mw_type),
			 .in_exception(excep_xm), .out_exception(excep_mw));
	 
	 // write stage control
	 wire MEM_out;
	 MW_control mw_ctrl(.ir(ir_mw),
							  .MEM_out(MEM_out), 
							  .write_to_register(ctrl_writeEnable),
							  .rd(ctrl_writeReg), .rstatus(rstat), 
							  .exception(excep_mw), 
							  .multdiv_rd(multdiv_rd), 
							  .multdivRDY(multdiv_resultRDY), 
							  .md_excep(mdexp), .md_rstatus(md_rstatus));
	 
	 // pick if ALU, data from memory, or multdiv output should be written
	 wire [31:0] data_pick;
	 mux31 muxwrite(.out(data_pick), .e0(~MEM_out & ~multdiv_resultRDY), 
								.in0(outDATA),
								.e1(MEM_out), 
								.in1(outMEM),
								.e2(multdiv_resultRDY), 
								.in2(multdiv_out));
	 // if exception occurred, write rstatus code instead
	 mux21 write_this(.out(data_writeReg),
							.in1(rstat), .in2(data_pick),
							.enable((|excep_mw) | mdexp));
/***********************************************************************
									PIPELINE CONTROL
*************************************************************************/
	 // global control signals
	 wire flush, take_branch;
	 assign flush = reset | take_branch;
	 wire stall_FD, stall_DX, stall_XM, stall_MW;
	 
	 // bypass control
	 wire ctrl_bypassD, ctrl_bypassReadA, ctrl_bypassReadB;
	 wire [1:0] ctrl_bypassA, ctrl_bypassB;
	 bypass_ctrl bypc(.ir_dx(ir_dx), .dx_type(dx_type), 
							.ir_xm(ir_xm), .xm_type(xm_type), 
							.ir_mw(ir_mw), .mw_type(mw_type), 
							.sw(wren), .we(ctrl_writeEnable),
							.ctrl_readRegA(ctrl_readRegA), 
							.ctrl_readRegB(ctrl_readRegB),
							.ctrl_bypassD(ctrl_bypassD),
							.ctrl_bypassA(ctrl_bypassA), 
							.ctrl_bypassB(ctrl_bypassB),
							.ctrl_bypassReadA(ctrl_bypassReadA),
							.ctrl_bypassReadB(ctrl_bypassReadB));
							
	 // stall logic
	 wire stall;
	 stall_logic stl(.stall(stall), .ir_dx(ir_dx), .dx_type(dx_type), 
						  .ir_fd(ir_fd_read), .fd_type(fd_type),
						  .multdiv_on(multdiv_on));

endmodule
