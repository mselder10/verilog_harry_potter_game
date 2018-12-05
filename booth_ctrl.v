module booth_ctrl(SHIFT, SUB, NOTHING, multiplier);

	input [31:0] multiplier;
	
	wire [32:0] extend_multiplier;

	output [15:0] SHIFT, SUB, NOTHING;
	
	assign extend_multiplier[32:1] = multiplier[31:0];
	assign extend_multiplier[0] = 1'b0;
	
	
	booth booth0(SHIFT[0] , SUB[0] , NOTHING[0] , extend_multiplier[2:0]  );
	booth booth1(SHIFT[1] , SUB[1] , NOTHING[1] , extend_multiplier[4:2]  );
	booth booth2(SHIFT[2] , SUB[2] , NOTHING[2] , extend_multiplier[6:4]  );
	booth booth3(SHIFT[3] , SUB[3] , NOTHING[3] , extend_multiplier[8:6] );
	booth booth4(SHIFT[4] , SUB[4] , NOTHING[4] , extend_multiplier[10:8]);
	booth booth5(SHIFT[5] , SUB[5] , NOTHING[5] , extend_multiplier[12:10]);
	booth booth6(SHIFT[6] , SUB[6] , NOTHING[6] , extend_multiplier[14:12]);
	booth booth7(SHIFT[7] , SUB[7] , NOTHING[7] , extend_multiplier[16:14]);
	booth booth8(SHIFT[8] , SUB[8] , NOTHING[8] , extend_multiplier[18:16]);
	booth booth9(SHIFT[9] , SUB[9] , NOTHING[9] , extend_multiplier[20:18]);
	booth bootha(SHIFT[10], SUB[10], NOTHING[10], extend_multiplier[22:20]);
	booth boothb(SHIFT[11], SUB[11], NOTHING[11], extend_multiplier[24:22]);
	booth boothc(SHIFT[12], SUB[12], NOTHING[12], extend_multiplier[26:24]);
	booth boothd(SHIFT[13], SUB[13], NOTHING[13], extend_multiplier[28:26]);
	booth boothe(SHIFT[14], SUB[14], NOTHING[14], extend_multiplier[30:28]);
	booth boothf(SHIFT[15], SUB[15], NOTHING[15], extend_multiplier[32:30]);
	
endmodule