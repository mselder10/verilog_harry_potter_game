module mytri32(out, in, enable);
   input  enable;
	input  [31:0] in;
   output [31:0] out;
	
	genvar c;
	generate
		for(c=0; c<32; c=c+1) begin: tri_loop
			assign out[c] = enable ? in[c] : 1'bz;
		end
	endgenerate

endmodule