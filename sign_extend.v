module sign_extend(in, out);

	input [16:0] in;

	output [31:0] out;
	
	assign out[16:0] = in[16:0];
	
	// set bits 17 through 34 to input's msb
	genvar c;
	generate
		for(c=17; c<32; c=c+1) begin:loop
			assign out[c] = in[16];
		end
	endgenerate

endmodule 