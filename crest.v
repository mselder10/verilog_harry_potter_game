module crest(clk, R, G, S, H, crest_index, ADDR, crest, leader_ADDR, leaderboard);

	input R, G, S, H, clk, leaderboard;
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

	// two colors of gryffindor
	assign crest_index = G & ~R & ~S & ~H & crest & ~out[0] ? 8'h49 : 8'dz; //outside
	assign crest_index = G & ~R & ~S & ~H & crest & out[0] ? 8'h30 : 8'dz; //inside
	
	// two colors of slytherin
	assign crest_index = S & ~R & ~G & ~H & crest & ~out[0] ? 8'h16 : 8'dz; //outside
	assign crest_index = S & ~R & ~G & ~H & crest & out[0] ? 8'hff : 8'dz; //inside
	
	// two colors of ravenclaw
	assign crest_index = R & ~S & ~G & ~H & crest & ~out[0] ? 8'h10 : 8'dz; //outside
	assign crest_index = R & ~S & ~G & ~H & crest & out[0] ? 8'h99 : 8'dz; //inside
	
	// two colors of hufflepuff
	assign crest_index = H & ~S & ~G & ~R & crest & ~out[0] ? 8'hdc : 8'dz; //outside
	assign crest_index = H & ~S & ~G & ~R & crest & out[0] ? 8'h00 : 8'dz; //inside
	
	//default b&w
	assign crest_index = ~S & ~R & ~G & ~H ? out : 8'dz;


endmodule