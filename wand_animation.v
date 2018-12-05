module wand_animation(row, col, wand_here, clk, learn_mode, switch_dest_counter);

	input clk, learn_mode;
	reg [4:0] origin, next; // change to inputs
	input [8:0] row;
	input [9:0] col;
	reg [16:0] ADDR;
	reg [8:0] wand_row;
	reg [9:0] wand_col;
	reg [16:0] offset;
	wire [18:0] offset_ADDR;
	reg [31:0] update_location_counter, update_offset_counter/*, switch_dest_counter*/;
	output reg [31:0] switch_dest_counter;
	reg switch_dest_clk;
	reg [3:0] cycle_counter;
	
	output wand_here;
	
	wands wandz(
		.address(offset_ADDR),
		.clock(~clk),
		.q(wand_here));
	
	assign offset_ADDR = ADDR + offset*10000;
	
//	ordering orderz(.clk(switch_dest_clk), .trace_ADDR(4'b1), 
//						 .next(next), .now(origin), .tutorial(learn_mode));
	
	initial
	begin
		offset <= 0;
		wand_row <= 190;
		wand_col <= 270;
		switch_dest_clk <= 1;
		origin <= 5;
		next <= 6;
		// initial location of wand
	end
	
	always@(posedge clk & learn_mode)
	begin
	
		// initial position of wand
		
		// switch destination (for testing)
//		if(next == 0 & origin != 0)
//		begin
//			if(origin == 0)
//			begin
//				wand_row <= 90;
//				wand_col <= 170;
//			end
//		else if(origin == 1)
//			begin
//				wand_row <= 90;
//				wand_col <= 270;
//			end
//		else if(origin == 2)
//			begin
//				wand_row <= 90;
//				wand_col <= 370;
//			end
//		else if(origin == 3)
//			begin
//				wand_row <= 90;
//				wand_col <= 470;
//			end
//		else if(origin == 4)
//			begin
//				wand_row <= 190;
//				wand_col <= 170;
//			end
//		else if(origin == 5)
//			begin
//				wand_row <= 190;
//				wand_col <= 270;
//			end
//		else if(origin == 6)
//			begin
//				wand_row <= 190;
//				wand_col <= 370;
//			end
//		else if(origin == 7)
//			begin
//				wand_row <= 190;
//				wand_col <= 470;
//			end
//		else if(origin == 8)
//			begin
//				wand_row <= 290;
//				wand_col <= 170;
//			end
//		else if(origin == 9)
//			begin
//				wand_row <= 290;
//				wand_col <= 270;
//			end
//		else if(origin == 10)
//			begin
//				wand_row <= 290;
//				wand_col <= 370;
//			end
//		else if(origin == 11)
//			begin
//				wand_row <= 290;
//				wand_col <= 470;
//			end
//		else if(origin == 12)
//			begin
//				wand_row <= 390;
//				wand_col <= 170;
//			end
//		else if(origin == 13)
//			begin
//				wand_row <= 390;
//				wand_col <= 270;
//			end
//		else if(origin == 14)
//			begin
//				wand_row <= 390;
//				wand_col <= 370;
//			end
//		else if(origin == 15)
//			begin
//				wand_row <= 390;
//				wand_col <= 470;
//			end
//		end
		
		if(switch_dest_counter == 6)
		begin
			origin <= next;
			next <= origin;
			switch_dest_counter <= 0;
			switch_dest_clk <= ~switch_dest_clk;
		end
			
		// move wand
		if(update_location_counter >= 32'd10000000)
		begin
			// to the right
			if(origin == 0 & next == 0)
			begin
				wand_row <= wand_row;
				wand_col <= wand_col;
			end
			else if(next-origin == 1)
				wand_col <= wand_col + 20;
			// to the left
			else if(next-origin == -1)
				wand_col <= wand_col - 20;
			// down
			else if(next-origin == 4)
				wand_row <= wand_row + 20;
			// up
			else if(next-origin == -4)
				wand_row <= wand_row - 20;
			
			switch_dest_counter <= switch_dest_counter + 1;
			update_location_counter <= 32'd0;
		end
		else
			update_location_counter <= update_location_counter + 1;
		
		// mif offset
		if(update_offset_counter >= 32'd5000)
			begin
				if(cycle_counter == 0)
					offset <= 0;
				else if (cycle_counter == 1)
					offset <= 1;
				else if (cycle_counter == 2)
					offset <= 2;
					
				cycle_counter <= cycle_counter + 1;
				
				if(cycle_counter == 3)
					cycle_counter <= 0;
			
				update_offset_counter <= 0;
			end
		else
			update_offset_counter <= update_offset_counter + 1;
		
		// image indexing
		if((row>=wand_row & row < wand_row + 100) & (col>=wand_col & col < wand_col + 100))
			begin
				ADDR <= ADDR + 1;
				if((row == wand_row & col == wand_col) || ADDR == 9999)
				ADDR <= 0;
			end
			
	end

endmodule