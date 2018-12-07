module sra32(out, in, amt);

	input [31:0] in;
	input [4:0] amt;
	
	wire [31:0] shift16, shift8, shift4, shift2, shift1;
	wire [31:0] s1, s2, s3, s4;
	wire msb;
	
	output [31:0] out;
	
	// determine most significant bit for sign extension
	assign msb = in[31] ? 1'b1 : 1'b0;
	
	// shift by 16?
	assign shift16[15:0] = in[31:16];
		// sign extend
		genvar a;
		generate
			for(a=31;a>15;a=a-1) begin: shift16msb
				assign shift16[a] = msb;
			end
		endgenerate
	mux21 shift16orno(amt[4], shift16, in, s1);
	
	// shift by 8?
	assign shift8[23:0] = s1[31:8];
		// sign extend
		genvar b;
		generate
			for(b=31;b>23;b=b-1) begin: shift8msb
				assign shift8[b] = msb;
			end
		endgenerate
	mux21 shift8orno(amt[3], shift8, s1, s2);
	
	// shift by 4?
	assign shift4[27:0] = s2[31:4];
		// sign extend
		genvar c;
		generate
			for(c=31;c>27;c=c-1) begin: shift4msb
				assign shift4[c] = msb;
			end
		endgenerate
	mux21 shift4orno(amt[2], shift4, s2, s3);

	// shift by 2?
	assign shift2[29:0] = s3[31:2];
		// sign extend
		assign shift2[30] = msb;
		assign shift2[31] = msb;
	mux21 shift2orno(amt[1], shift2, s3, s4);
	
	
	// shift by 1?
	assign shift1[30:0] = s4[31:1];
		// sign extend
		assign shift1[31] = msb;
	mux21 shift1orno(amt[0], shift1, s4, out);
 

endmodule 