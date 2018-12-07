module decoder (
    i,
	 enable_me
);

   input [4:0] i;
	wire n0,n1,n2,n3,n4;
	output [31:0] enable_me;
	
	// not each bit of in
	not not0(n0, i[0]);
	not not1(n1, i[1]);
	not not2(n2, i[2]);
	not not3(n3, i[3]);
	not not4(n4, i[4]);
	
	// enable register 0
	and and0 (enable_me[0] ,   n4,   n3,   n2,   n1,   n0);
	// enable register 1
	and and1 (enable_me[1] ,   n4,   n3,   n2,   n1, i[0]);
	// enable register 2
	and and2 (enable_me[2] ,   n4,   n3,   n2, i[1],   n0);
	// enable register 3
	and and3 (enable_me[3] ,   n4,   n3,   n2, i[1], i[0]);
	// enable register 4
	and and4 (enable_me[4] ,   n4,   n3, i[2],   n1,   n0);
	// enable register 5
	and and5 (enable_me[5] , 	n4,	n3, i[2], 	n1, i[0]);
	// enable register 6
	and and6 (enable_me[6] , 	n4,	n3, i[2], i[1],   n0);
	// enable register 7
	and and7 (enable_me[7] , 	n4,	n3, i[2], i[1], i[0]);
	// enable register 8
	and and8 (enable_me[8] ,   n4, i[3],   n2,   n1,   n0);
	// enable register 9
	and and9 (enable_me[9] ,   n4, i[3],   n2,   n1, i[0]);
	// enable register 10
	and and10(enable_me[10],   n4, i[3],   n2, i[1], 	n0);
	// enable register 11
	and and11(enable_me[11],   n4, i[3],   n2, i[1], i[0]);
	// enable register 12
	and and12(enable_me[12],   n4, i[3], i[2],   n1,   n0);
	// enable register 13
	and and13(enable_me[13],   n4, i[3], i[2],   n1, i[0]);
	// enable register 14
	and and14(enable_me[14],   n4, i[3], i[2], i[1], 	n0);
	// enable register 15
	and and15(enable_me[15],   n4, i[3], i[2], i[1], i[0]);
	// enable register 16
	and and16(enable_me[16], i[4],   n3,   n2,   n1,   n0);
	// enable register 17
	and and17(enable_me[17], i[4],   n3,   n2,   n1, i[0]);
	// enable register 18
	and and18(enable_me[18], i[4],   n3,   n2, i[1], 	n0);
	// enable register 19
	and and19(enable_me[19], i[4],   n3,   n2, i[1], i[0]);
	// enable register 20
	and and20(enable_me[20], i[4],   n3, i[2],   n1,   n0);
	// enable register 21
	and and21(enable_me[21], i[4],   n3, i[2],   n1, i[0]);
	// enable register 22
	and and22(enable_me[22], i[4],   n3, i[2], i[1],   n0);
	// enable register 23
	and and23(enable_me[23], i[4],   n3, i[2], i[1], i[0]);
	// enable register 24
	and and24(enable_me[24], i[4], i[3],   n2,   n1,   n0);
	// enable register 25
	and and25(enable_me[25], i[4], i[3],   n2,   n1, i[0]);
	// enable register 26
	and and26(enable_me[26], i[4], i[3],   n2, i[1],   n0);
	// enable register 27
	and and27(enable_me[27], i[4], i[3],   n2, i[1], i[0]);
	// enable register 28
	and and28(enable_me[28], i[4], i[3], i[2],   n1,   n0);
	// enable register 29
	and and29(enable_me[29], i[4], i[3], i[2],   n1, i[0]);
	// enable register 30
	and and30(enable_me[30], i[4], i[3], i[2], i[1],   n0);
	// enable register 31
	and and31(enable_me[31], i[4], i[3], i[2], i[1], i[0]);
	
endmodule