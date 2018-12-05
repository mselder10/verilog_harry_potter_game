module wand_animation(origin, next_box, wand_here, clk);

	input origin, next_box,clk;
	output wand_here;
	
//	wands wandz(
//		.address(ADDR),
//		.clock(~clk),
//		.q(wand_here));
		
	always@(posedge clk)
	begin
		
	end

endmodule