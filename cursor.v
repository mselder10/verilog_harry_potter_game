module cursor(row, col, cursor_here, color_index, clk,
					up, down, left, right, sparkle_here);
	
	input up, down, left, right, clk;
	input [8:0] row;
	input [9:0] col;
	
	reg [18:0] x, y;
	reg [7:0] cursor_color;
	reg cursor_is_here;
	
	output cursor_here, sparkle_here;
	output [7:0] color_index;
	
	initial
	begin
		x <= 19'd120;
		y <= 19'd40;
	end
	
	reg [31:0] counter;
	
	always @(posedge clk)
	begin
		if(counter >= 32'd2000000)
		begin
			if(~left)
				x <= x - 10;
			else if (~right)
				x <= x + 10;
			else if (~up)
				y <= y - 10;
			else if (~down)
				y <= y + 10;
				counter <= 32'd0;				
		end
		else
			begin
			counter <= 	counter + 1;
			
			end
		
		if ((row > y) && (row < y + 19'd10) && (col > x) && (col < x + 19'd10))
		begin
			cursor_is_here <= 1'b1;
			cursor_color <= 8'd5;
		end
		else
			cursor_is_here <= 1'b0;
	end
	
	assign color_index = cursor_color;
	assign cursor_here = cursor_is_here;
	
	sparkle sprkz(.clk(clk), .sparkle(sparkle_here), 
					  .x(x), .y(y), .row(row), .col(col));

endmodule
