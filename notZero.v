module notZero(out, i);

	input [31:0] i;
	
	wire w0, w1, w2, w3;
	
	output out;
	
	or zero(w0,  i[31], i[30], i[29], i[28], i[27], i[26], i[25], i[24]);
	or one (w1,  i[23], i[22], i[21], i[20], i[19], i[18], i[17], i[16]);
	or two (w2,  i[15], i[14], i[13], i[12], i[11], i[10], i[9] , i[8] );
	or thre(w3,  i[7] , i[6] , i[5] , i[4] , i[3] , i[2] , i[1] , i[0] );
	or out1(out, w0, w1, w2, w3);

endmodule 