module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
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
	
	genvar r;
	generate
		for(r = 1; r<32; r=r+1) begin: register_loop			
			wire [31:0] temp; // for register output
			// set write enable flag
			wire WE;
			and enableWrite(WE, ctrl_writeEnable, writeReg[r]);
			// create register, write and read to temp value
			register reg1(clock, WE, ctrl_reset, data_writeReg, temp);
			// output for read A
			mytri32 my_triA(.enable(readRegA[r]), .in(temp), .out(data_readRegA));
			// output for read B
			mytri32 my_triB(.enable(readRegB[r]), .in(temp), .out(data_readRegB));
		end
	endgenerate

endmodule
