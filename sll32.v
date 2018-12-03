module sll32(out, in, amt);

	input [31:0] in;
	input [4:0] amt;
	
	wire [31:0] shift16, shift8, shift4, shift2, shift1;
	wire [31:0] s1, s2, s3, s4;
	
	output [31:0] out;
	
	// shift by 16?
	assign shift16[31:16] = in[15:0];
	assign shift16[15:0] = 16'h0000;
	mux21 shift16orno(amt[4], shift16, in, s1);
	
	// shift by 8?
	assign shift8[31:8] = s1[23:0];
	assign shift8[7:0]  = 8'h00;
	mux21 shift8orno(amt[3], shift8, s1, s2);
	
	// shift by 4?
	assign shift4[31:4] = s2[27:0];
	assign shift4[3:0]  = 4'h0;
	mux21 shift4orno(amt[2], shift4, s2, s3);

	// shift by 2?
	assign shift2[31:2] = s3[29:0];
	assign shift2[1:0] = 2'b00;
	mux21 shift2orno(amt[1], shift2, s3, s4);
	
	
	// shift by 1?
	assign shift1[31:1] = s4[30:0];
	assign shift1[0] = 1'b0;
	mux21 shift1orno(amt[0], shift1, s4, out);
 

endmodule 