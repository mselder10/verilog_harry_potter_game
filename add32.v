module add32(sum, overflow, p, g, carryin);

	input[31:0] p, g;
	input carryin;
	
	wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9;
	
	wire [31:0] carry;
	wire [7:0] G,P;
	
	output [31:0] sum;
	output overflow;
	
	// carry out of bits 0-7
	and andw0(w0, P[0], carryin);
	or orcarry7(carry[7], G[0], w0);
	
	// carry out of bits 15-8
	and andw1(w1, P[1], G[0]);
	and andw2(w2, P[1], P[0], carryin);
	or orcarry15(carry[15], G[1], w1, w2);
	
	// carryout of bits 23-16
	and andw3(w3, P[2], G[1]);
	and andw4(w4, P[2], P[1], G[0]);
	and andw5(w5, P[2], P[1], P[0], carryin);
	or orcarry23(carry[23], G[2], w3, w4, w5);
	
	// carryout of bits 31-24
	and andw6(w6, P[3], G[2]);
	and andw7(w7, P[3], P[2], G[1]);
	and andw8(w8, P[3], P[2], P[1], G[0]);
	and andw9(w9, P[3], P[2], P[1], P[0], carryin);
	or orcarry31(carry[31], G[3], w6, w7, w8, w9);
	
	// generate propogte bits
	cla_8bit add1(P[0], G[0], carry[6:0],  p[7:0],  g[7:0],  carryin);
	cla_8bit add2(P[1], G[1], carry[14:8], p[15:8],  g[15:8], carry[7]);
	cla_8bit add3(P[2], G[2], carry[22:16], p[23:16],  g[23:16], carry[15]);
	cla_8bit add4(P[3], G[3], carry[30:24], p[31:24],  g[31:24], carry[23]);
	
	// sum all 32 bits
	sum32 SUMxor(sum, p, carry, carryin);
	
	// overflow
	xor ovflw(overflow, carry[31], carry[30]);

endmodule 