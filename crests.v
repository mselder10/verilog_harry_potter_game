module crests(clk, R, G, S, H, crest_index, ADDR);

	input R, G, S, H, clk;
	input [18:0] ADDR;
	
	wire [7:0] h, g, s, r;
	
	output[7:0] crest_index;
	
	gryf gryfz(
		.address(ADDR),
		.clock(clk),
		.q(g));
	
	assign crest_index = S & |(g) ? 8'h16 : 8'dz;
	assign crest_index = R & |(g) ? 8'h10 : 8'dz;
	assign crest_index = H & |(g) ? 8'hdc : 8'dz;
	assign crest_index = ~S & ~R & ~G & ~H ? 8'hf : 8'dz;


endmodule