module opdecode(add, subtract, AND, OR, sll, sra, opcode, ZERO);

	input [4:0] opcode;
	input ZERO;
	
	wire n2, n1, n0, nZ;
	
	output add, subtract, AND, OR, sll, sra;
	
	not not0(n0, opcode[0]);
	not not1(n1, opcode[1]);
	not not2(n2, opcode[2]);
	not notZ(nZ, ZERO);
	
	// logic for op decode
	and add_on(add, n2, n1, n0, nZ);
	and subtract_on(subtract, n2, n1, opcode[0], nZ);
	and AND_on(AND, n2, opcode[1], n0, nZ);
	and OR_on(OR, n2, opcode[1], opcode[0], nZ);
	and sll_on(sll, opcode[2], n1, n0, nZ);
	and sra_on(sra, opcode[2], n1, opcode[0], nZ);

endmodule 