module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB, reg1_data, reg2_data, reg3_data, reg4_data
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
	
	wire [31:0] readRegA, readRegB, writeReg, regZero; // holds decoded register values
	
   output [31:0] data_readRegA, data_readRegB;
	
	// decode register to read & write
	decoder decode_readA(ctrl_readRegA, readRegA);
	decoder decode_readB(ctrl_readRegB, readRegB);
	decoder decode_writeReg(ctrl_writeReg, writeReg);
	
	// register 0
	register reg0(clock, 1'b0, ctrl_reset, data_writeReg,regZero);
	mytri32 my_triA0(.enable(readRegA[0]), .in(32'h00000000), .out(data_readRegA));
	mytri32 my_triB0(.enable(readRegB[0]), .in(32'h00000000), .out(data_readRegB));
	
	// register 1, 2, 3, 4 - will be reserved for the different players and it's data will always be readable
	output [31:0] reg1_data, reg2_data, reg3_data, reg4_data;
	//wire [31:0] data_readReg1, data_readReg2, data_readReg3, data_readReg4;
	wire WE1, WE2, WE3, WE4;
	and enableWrite1(WE1, ctrl_writeEnable, writeReg[1]);
	and enableWrite2(WE2, ctrl_writeEnable, writeReg[2]);
	and enableWrite3(WE3, ctrl_writeEnable, writeReg[3]);
	and enableWrite4(WE4, ctrl_writeEnable, writeReg[4]);
	
	register reg1(clock, WE1, ctrl_reset, data_writeReg, reg1_data);
	mytri32 my_triA01(.enable(readRegA[1]), .in(reg1_data), .out(data_readRegA));
	mytri32 my_triB01(.enable(readRegB[1]), .in(reg1_data), .out(data_readRegB));
	
	register reg2(clock, WE2, ctrl_reset, data_writeReg,reg2_data);
	mytri32 my_triA02(.enable(readRegA[2]), .in(reg2_data), .out(data_readRegA));
	mytri32 my_triB02(.enable(readRegB[2]), .in(reg2_data), .out(data_readRegB));
	
	register reg3(clock, WE3, ctrl_reset, data_writeReg,reg3_data);
	mytri32 my_triA03(.enable(readRegA[3]), .in(reg3_data), .out(data_readRegA));
	mytri32 my_triB03(.enable(readRegB[3]), .in(reg3_data), .out(data_readRegB));
	
	register reg4(clock, WE4, ctrl_reset, data_writeReg,reg4_data);
	mytri32 my_triA04(.enable(readRegA[4]), .in(reg4_data), .out(data_readRegA));
	mytri32 my_triB04(.enable(readRegB[4]), .in(reg4_data), .out(data_readRegB));
	
	
	
	
	genvar r;
	generate
		for(r = 5; r<32; r=r+1) begin: register_loop			
			wire [31:0] temp; // for register output
			// set write enable flag
			wire WE;
			and enableWrite(WE, ctrl_writeEnable, writeReg[r]);
			// create register, write and read to temp value
			register reg5(clock, WE, ctrl_reset, data_writeReg, temp);
			// output for read A
			mytri32 my_triA(.enable(readRegA[r]), .in(temp), .out(data_readRegA));
			// output for read B
			mytri32 my_triB(.enable(readRegB[r]), .in(temp), .out(data_readRegB));
			
		end
	endgenerate

endmodule
