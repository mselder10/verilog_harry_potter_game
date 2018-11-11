module background(G, H, S, R, color_index, clk);

	input G, H, S, R, clk;
	
	reg [7:0] index;
	
	output [7:0] color_index;
	
	always@(posedge clk)
	begin
		if(S)
			index <= 8'd1;
		else if (G)
			index <= 8'd2;
		else if (H)
			index <= 8'd3;
		else if (R)
			index <= 8'd4;
		else 
			index <= 8'd0;
	end
	
	assign color_index = index;

endmodule
