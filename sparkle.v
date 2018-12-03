module sparkle(clk, sparkle, x, y, row, col);

	input clk;
	input [18:0] x, y;
	input [8:0] row;
	input [9:0] col;
	reg state;
	reg [31:0] counter;
	output sparkle;
	
	always @(posedge clk)
	begin
		if(counter >= 32'd4000050)
			counter <= 32'b0;
			
		if(counter >= 32'd4000000 & 
			(row == y || row == y+2 || row == y+4 || row == y+6 || row == y+8) && 
			(col > x + 19'd10) && (col < x + 19'd20))
			state <= ~state;
		else if(counter >= 32'd4000000 & 
			(row == y + 1 || row == y+3 || row == y+5 || row == y+7 || row == y+9) && 
			(col >= x + 19'd11) && (col < x + 19'd20))
			state <= ~state;
		else
			state <= 1'b0;
		
		counter <= counter + 1;
	end
	
	assign sparkle = state;
	
endmodule 