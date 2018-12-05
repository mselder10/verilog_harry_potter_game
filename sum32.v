module sum32(sum, p, c, cin);

	input [31:0] c, p;
	input cin;
	
	output [31:0] sum;
	
	xor xor1(sum[0], p[0], cin);
	xor xor2(sum[1], p[1], c[0]);
	xor xor3(sum[2], p[2], c[1]);
	xor xor4(sum[3], p[3], c[2]);
	xor xor5(sum[4], p[4], c[3]);
	xor xor6(sum[5], p[5], c[4]);
	xor xor7(sum[6], p[6], c[5]);
	xor xor8(sum[7], p[7], c[6]);
	xor xor9(sum[8], p[8], c[7]);
	xor xor10(sum[9], p[9], c[8]);
	
	xor xor11(sum[10], p[10], c[9]);
	xor xor12(sum[11], p[11], c[10]);
	xor xor13(sum[12], p[12], c[11]);
	xor xor14(sum[13], p[13], c[12]);
	xor xor15(sum[14], p[14], c[13]);
	xor xor16(sum[15], p[15], c[14]);
	xor xor17(sum[16], p[16], c[15]);
	xor xor18(sum[17], p[17], c[16]);
	xor xor19(sum[18], p[18], c[17]);
	xor xor20(sum[19], p[19], c[18]);
	
	xor xor21(sum[20], p[20], c[19]);
	xor xor22(sum[21], p[21], c[20]);
	xor xor23(sum[22], p[22], c[21]);
	xor xor24(sum[23], p[23], c[22]);
	xor xor25(sum[24], p[24], c[23]);
	xor xor26(sum[25], p[25], c[24]);
	xor xor27(sum[26], p[26], c[25]);
	xor xor28(sum[27], p[27], c[26]);
	xor xor29(sum[28], p[28], c[27]);
	xor xor30(sum[29], p[29], c[28]);
	
	xor xor31(sum[30], p[30], c[29]);
	xor xor32(sum[31], p[31], c[30]);
	

endmodule 