module crest(clk, R, G, S, H, crest_index, ADDR, crest);

	input R, G, S, H, clk;
	input [18:0] ADDR;
	
	wire [7:0] h, g, s, r;
	wire [1:0] out;
	
	output[7:0] crest_index;
	output crest;
	
	crests crestz(
		.address(ADDR),
		.clock(clk),
		.q(out));
	
	assign crest = ~out[1];

	// two colors of gryffindor
	assign crest_index = G & crest & ~out[0] ? 8'h49 : 8'dz; //outside
	assign crest_index = G & crest & out[0] ? 8'h30 : 8'dz; //inside
	
	// two colors of slytherin
	assign crest_index = S & crest & ~out[0] ? 8'h16 : 8'dz; //outside
	assign crest_index = S & crest & out[0] ? 8'hff : 8'dz; //inside
	
	// two colors of ravenclaw
	assign crest_index = R & crest & ~out[0] ? 8'h10 : 8'dz; //outside
	assign crest_index = R & crest & out[0] ? 8'h99 : 8'dz; //inside
	
	// two colors of hufflepuff
	assign crest_index = H & crest & ~out[0] ? 8'hdc : 8'dz; //outside
	assign crest_index = H & crest & out[0] ? 8'h00 : 8'dz; //inside
	
	//default b&w
	assign crest_index = ~S & ~R & ~G & ~H ? out : 8'dz;


endmodule