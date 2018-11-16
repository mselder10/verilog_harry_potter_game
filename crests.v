module crests(clk, R, G, S, H, crest_index, ADDR);

	input R, G, S, H, clk;
	input [18:0] ADDR;
	
	wire [7:0] h, g, s, r;
	
	output[7:0] crest_index;
	
	gryf gryfz(
		.address(ADDR),
		.clock(clk),
		.q(g));
		
	huff huffz(
		.address(ADDR),
		.clock(clk),
		.q(h));
		
	rave ravez(
		.address(ADDR),
		.clock(clk),
		.q(r));
	
	slyth slythz(
		.address(ADDR),
		.clock(clk),
		.q(s));
		
	assign crest_index = S ? s : 8'dz;
	assign crest_index = R ? r : 8'dz;
	assign crest_index = G ? g : 8'dz;
	assign crest_index = H ? h : 8'dz;
	assign crest_index = ~S & ~R & ~G & ~H ? 8'hf : 8'dz;


endmodule