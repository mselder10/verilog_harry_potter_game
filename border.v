//module border(border, row, col, clk);
//	
//	input clk;
//	input [8:0] row;
//	input [9:0] col;
//
//	reg [12:0] border_pixel;
//	reg [12:0] index_offset, row_offset;
//	wire out;
//
//	output border;
//	
//	borders borderz(.address(border_pixel),
//					.clock(clk),
//					.q(border));
//	
//	always @ (posedge clk)
//	begin
//
//		// top left corner
//		if((col >= 100 & col < 120) & (row >= 20 & row < 40))
//		begin
//			index_offset <= 13'd0;
//			row_offset <= 4'd20;
//		end
//
//		// top right corner
//		if((col >= 520 & col < 540) & (row >= 20 & row < 40))
//		begin
//			index_offset <= 13'd400;
//			row_offset <= 4'd20;
//		end
//
//		// bottom left corner
//		if((col >= 100 & col < 120) & (row >= 440 & row < 460))
//		begin
//			index_offset <= 13'd800;
//			row_offset <= 4'd440;
//		end
//
//
//		// bottom right corner
//		if((col >= 520 & col < 540) & (row >= 440 & row < 460))
//		begin
//			index_offset <= 13'd1200;
//			row_offset <= 4'd440;
//		end
//
//		// left
//		if((row >= 40 & row < 440) & (col >= 100 & col < 120))
//		begin
//			index_offset <= 13'd1600;
//			row_offset <= 4'd20;
//		end
//
//		// right
//		if((row >= 40 & row < 440) & (col >= 520 & col < 540))
//		begin
//			index_offset <= 13'd1600;
//			row_offset <= 4'd40;
//		end
//
//		// top
//		if((row >= 20 & row < 40) & (col >= 120 & col < 520))
//		begin
//			index_offset <= 13'd2000;
//			row_offset <= 4'd20;
//		end
//
//		// bottom
//		if((row >= 440 & row < 460) & (col >= 120 & col < 520))
//		begin
//			index_offset <= 13'd2000;
//			row_offset <= 4'd440;
//		end
//
//	end
//	
//	always @ (negedge clk)
//	begin
//		if(border_pixel % 20 == 0)
//			border_pixel <= index_offset + (row % row_offset)*20;
//		else
//			border_pixel <= border_pixel + 1;
//	end
//
//endmodule

module border(border, row, col, clk);
	
	input clk;
	input [8:0] row;
	input [9:0] col;

	reg [12:0] border_pixel;
	reg [12:0] corner_pixel, LR_pixel, TB_pixel;
	reg corner, LR, TB, bor;
	reg [12:0] index_offset, row_offset;
	wire out;

	output border;
	
	borders borderz(.address(border_pixel),
					.clock(~clk),
					.q(border));
	
	always @ (posedge clk)
	begin
	
	// corners
		// top left corner
		if((col >= 100 & col < 120) & (row >= 20 & row < 40))
			begin
			//index_offset <= 13'd0;
			//row_offset <= 4'd20;
				corner <= 1'b1;
				if((corner_pixel+1) % 20 == 0)
					corner_pixel <= (row-20)*20;
				else
					corner_pixel <= corner_pixel+1;
			
			end
		// top right corner
		else if((col >= 520 & col < 540) & (row >= 20 & row < 40))
			begin
				corner <= 1'b1;
				if((corner_pixel+1) % 20 == 0)
					corner_pixel <= 400+(row-20)*20;
				else
					corner_pixel <= corner_pixel+1;
			end
		else
			corner <= 1'b0;
	
	//counter
		
	end
	
	always @ (negedge clk)
	begin
		if(corner)
			border_pixel <= corner_pixel;
	end
	
					
endmodule