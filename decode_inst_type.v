module decode_inst_type(type, op);

	input [4:0] op;
	
	wire w0, w1, w2, w3;
	wire r, i, ji, jii;
	
	output [1:0] type;
	
	// R type logic
	assign r =  ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];
	
	// JI type logic
	assign w0 =  ~op[4] & ~op[3] & ~op[2] & ~op[1] &  op[0];
	assign w1 =  ~op[4] & ~op[3] & ~op[2] &  op[1] &  op[0];
	assign w2 =   op[4] & ~op[3] &  op[2] &  op[1] & ~op[0];
	assign w3 =   op[4] & ~op[3] &  op[2] & ~op[1] &  op[0];
	assign ji = w0 | w1 | w2 | w3;
	
	// JII type logic
	assign jii = ~op[4] & ~op[3] &  op[2] & ~op[1] & ~op[0];
	
	// I type logic
	assign i = ~r & ~ji & ~jii;
	
	// describe type in two bit output
	assign type = r   ? 2'b00 : 2'bzz;
	assign type = i   ? 2'b01 : 2'bzz;
	assign type = ji  ? 2'b10 : 2'bzz;
	assign type = jii ? 2'b11 : 2'bzz;
	

endmodule 