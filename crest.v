module crest(clk, R1, G1, S1, H1, R2, G2, S2, H2, Rl, Gl, Sl, Hl, 
crest_index, ADDR, crest, leader_ADDR, player, leaderboard);

	input R1, G1, S1, H1, R2, G2, S2, H2, Rl, Gl, Sl, Hl, clk, leaderboard, player;
	input [18:0] ADDR, leader_ADDR;
	
	wire [18:0] rADDR;
	wire [7:0] h, g, s, r;
	wire [1:0] out;
	
	output[7:0] crest_index;
	output crest;
	
	assign rADDR = leaderboard ? leader_ADDR : ADDR;
	
	crests crestz(
		.address(rADDR),
		.clock(~clk),
		.q(out));
	
	assign crest = ~out[1];
//	assign g = ((G1 /*& ~player*/) | (G2 /*& player*/));
//	assign h = (H1 /*& ~player*/) | (H2 /*& player*/);
//	assign s = (S1 /*& ~player*/) | (S2 /*& player*/);
//	assign r = (R1 /*& ~player*/) | (R2 /*& player*/);
	
	// PLAYER 1
	// two colors of gryffindor
	assign crest_index = (G1) & ~leaderboard & ~player & crest & ~out[0] ? 8'h49 : 8'dz; //outside
	assign crest_index = (G1) & ~leaderboard & ~player & crest & out[0] ? 8'h30 : 8'dz; //inside
	
	// two colors of slytherin
	assign crest_index = (S1) & ~leaderboard & ~player & crest & ~out[0] ? 8'h16 : 8'dz; //outside
	assign crest_index = (S1) & ~leaderboard & ~player & crest & out[0] ? 8'hff : 8'dz; //inside
	
	// two colors of ravenclaw
	assign crest_index = (R1) & ~leaderboard & ~player & crest & ~out[0] ? 8'h10 : 8'dz; //outside
	assign crest_index = (R1) & ~leaderboard & ~player & crest & out[0] ? 8'h99 : 8'dz; //inside
	
	// two colors of hufflepuff
	assign crest_index = (H1) & ~leaderboard & ~player &crest & ~out[0] ? 8'hdc : 8'dz; //outside
	assign crest_index = (H1) & ~leaderboard & crest & out[0] ? 8'h00 : 8'dz; //inside
	
	//default b&w
	assign crest_index = (~R1 & ~G1 & ~S1 & ~H1 & ~player) ? out : 8'dz;
	
	// PLAYER 2
	// two colors of gryffindor
	assign crest_index = (G2) & ~leaderboard & player & crest & ~out[0] ? 8'h49 : 8'dz; //outside
	assign crest_index = (G2) & ~leaderboard & player & crest & out[0] ? 8'h30 : 8'dz; //inside
	
	// two colors of slytherin
	assign crest_index = (S2) & ~leaderboard & player & crest & ~out[0] ? 8'h16 : 8'dz; //outside
	assign crest_index = (S2) & ~leaderboard & player & crest & out[0] ? 8'hff : 8'dz; //inside
	
	// two colors of ravenclaw
	assign crest_index = (R2) & ~leaderboard & player & crest & ~out[0] ? 8'h10 : 8'dz; //outside
	assign crest_index = (R2) & ~leaderboard & player & crest & out[0] ? 8'h99 : 8'dz; //inside
	
	// two colors of hufflepuff
	assign crest_index = (H2) & ~leaderboard & player & crest & ~out[0] ? 8'hdc : 8'dz; //outside
	assign crest_index = (H2) & ~leaderboard & player & crest & out[0] ? 8'h00 : 8'dz; //inside
	
	//default b&w
	assign crest_index = (~R2 & ~G2 & ~S2 & ~H2 & player) ? out : 8'dz;
	
	// LEADERBOARD
	// two colors of gryffindor
	assign crest_index = (Gl) & leaderboard & crest & ~out[0] ? 8'h49 : 8'dz; //outside
	assign crest_index = (Gl) & leaderboard & crest & out[0] ? 8'h30 : 8'dz; //inside
	
	// two colors of slytherin
	assign crest_index = (Sl) & leaderboard & crest & ~out[0] ? 8'h16 : 8'dz; //outside
	assign crest_index = (Sl) & leaderboard & crest & out[0] ? 8'hff : 8'dz; //inside
	
	// two colors of ravenclaw
	assign crest_index = (Rl) & leaderboard & crest & ~out[0] ? 8'h10 : 8'dz; //outside
	assign crest_index = (Rl) & leaderboard & crest & out[0] ? 8'h99 : 8'dz; //inside
	
	// two colors of hufflepuff
	assign crest_index = (Hl) & leaderboard & crest & ~out[0] ? 8'hdc : 8'dz; //outside
	assign crest_index = (Hl) & leaderboard & crest & out[0] ? 8'h00 : 8'dz; //inside

endmodule