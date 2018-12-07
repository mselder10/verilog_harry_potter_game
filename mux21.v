module mux21(
    enable,
    in1, in2,
    out
);

   input  enable;
	input  [31:0] in1, in2;
   output [31:0] out;
	
	genvar c;
	generate
		for(c=0; c<32; c=c+1) begin: tri_loop
			assign out[c] = enable ? in1[c] : in2[c];
		end
	endgenerate

endmodule