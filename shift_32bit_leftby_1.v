module shift_32bit_leftby_1(out, in);

	input[31:0] in;
	output[31:0] out;
	
	assign out[31:1] = in[30:0];
	assign out[0] = 0;

endmodule 