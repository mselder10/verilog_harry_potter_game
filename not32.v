module not32(out, in);

	input [31:0] in;
	output [31:0] out;
	
	genvar c;
	generate
		for(c=0; c<32;c=c+1) begin: loop
			not not1(out[c], in[c]);
		end
	endgenerate

endmodule