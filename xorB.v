module xorB(out, in1, in2);

	input [31:0] in1;
	input in2;
	
	output [31:0] out;
	
	genvar c;
	generate
		for(c=0; c<32; c=c+1) begin: loop
			xor(out[c], in1[c], in2);
		end
	endgenerate

endmodule