module fade_block(row, col, clk, here, color);

	input clk;
	
	input [8:0] row;
	input [9:0] col;
	
	reg[18:0] x, y;
	reg[31:0] counter;
	
	reg there, block_is_here;
	
	output here;
	output [7:0] color;
	
	initial
	begin
		x <= 18'd50;
		y <= 18'd50;
	end
	
	always @(posedge clk)
	begin
		/*if(counter >= 32'd4000000)
			counter <= 32'd0;
		
		if (counter <= 32'd2000000)	
			there <= 1'b1;
		else if (counter > 32'd2000000)	
			there <= 1'b0;*/
		
		counter <= counter + 1;
		
		if ((row > y) && (row < y + 19'd10) && (col > x) && (col < x + 19'd10))
		begin
			block_is_here <= 1'b1;
		end
	end
	
	assign here = block_is_here;
	assign color = 8'd5;
	
endmodule 