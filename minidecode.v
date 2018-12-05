module minidecode(ADD, SUB, NOTHING, opcode, ZERO);

	input [1:0] opcode;
	input ZERO;
	
	wire n0, n1, nZ;
	
	output ADD, SUB, NOTHING;
	
	not not0(n0, opcode[0]);
	not not1(n1, opcode[1]);
	not notZ(nZ, ZERO);
	
	// logic for op decode
	and add_on(ADD, n1, n0, nZ);
	and subtract_on(SUB, n1, opcode[0], nZ);
	and nothing_on(NOTHING, opcode[1], n0, nZ);

endmodule