module cla_8bit(Pout, Gout, carry, P, G, cin);

	input [7:0] P,G;
	input cin;
	
	wire w0, w1, w2, w3, w4, w5, w6, w7, w8;
	wire w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19;
	wire w20, w21, w22, w23, w24, w25, w26, w27, w28;
	wire w29, w30, w31, w32, w33, w34;
	
	output [6:0] carry;
	output Pout, Gout;
	
	// c0 loGic
	and andw0(w0, P[0], cin);
	or  orc1(carry[0],  G[0], w0);
	
	// c1 loGic
	and andw1(w1, P[1], G[0]);
	and andw2(w2, P[1], P[0], cin);
	or orc2(carry[1], G[1], w1, w2);
	
	// c2 loGic
	and andw3(w3, P[2], G[1]);
	and andw4(w4, P[2], P[1], G[0]);
	and andw5(w5, P[2], P[1], P[0], cin);
	or orc3(carry[2], G[2], w3, w4, w5);
	
	// c3 logic
	and andw6(w6, P[3], G[2]);
	and andw7(w7, P[3], P[2], G[1]);
	and andw8(w8, P[3], P[2], P[1], G[0]);
	and andw9(w9, P[3], P[2], P[1], P[0], cin);
	or orcarry15(carry[3], G[3], w6, w7, w8, w9);
	
	// c4 logic
	and andw10(w10, P[4], G[3]);
	and andw11(w11, P[4], P[3], G[2]);
	and andw12(w12, P[4], P[3], P[2], G[1]);
	and andw13(w13, P[4], P[3], P[2], P[1], G[0]);
	and andw14(w14, P[4], P[3], P[2], P[1], P[0], cin);
	or orcarry19(carry[4], G[4], w10, w11, w12, w13,w14);
	
	// c5 logic
	and andw15(w15, P[5], G[4]);
	and andw16(w16, P[5], P[4], G[3]);
	and andw17(w17, P[5], P[4], P[3], G[2]);
	and andw18(w18, P[5], P[4], P[3], P[2], G[1]);
	and andw19(w19, P[5], P[4], P[3], P[2], P[1], G[0]);
	and andw20(w20, P[5], P[4], P[3], P[2], P[1], P[0], cin);
	or orcarry23(carry[5], G[5], w15, w16, w17, w18,w19, w20);
	
	// c6 logic
	and andw21(w21, P[6], G[5]);
	and andw22(w22, P[6], P[5], G[4]);
	and andw23(w23, P[6], P[5], P[4], G[3]);
	and andw24(w24, P[6], P[5], P[4], P[3], G[2]);
	and andw25(w25, P[6], P[5], P[4], P[3], P[2], G[1]);
	and andw26(w26, P[6], P[5], P[4], P[3], P[2], P[1], G[0]);
	and andw27(w27, P[6], P[5], P[4], P[3], P[2], P[1], P[0], cin);
	or orcarry27(carry[6], G[6], w21, w22, w23, w24, w25, w26, w27);
	
	// cout logic
	and andw28(w28, P[7], G[6]);
	and andw29(w29, P[7], P[6], G[5]);
	and andw30(w30, P[7], P[6], P[5], G[4]);
	and andw31(w31, P[7], P[6], P[5], P[4], G[3]);
	and andw32(w32, P[7], P[6], P[5], P[4], P[3], G[2]);
	and andw33(w33, P[7], P[6], P[5], P[4], P[3], P[2], G[1]);
	and andw34(w34, P[7], P[6], P[5], P[4], P[3], P[2], P[1], G[0]);
	and andw35(Pout, P[7], P[6], P[5], P[4], P[3], P[2], P[1], P[0]);
	or orcarry31(Gout, G[7], w28, w29, w30, w31, w32, w33, w34);
	

endmodule 