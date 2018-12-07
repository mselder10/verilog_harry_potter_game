module wand_animation(row, col, wand_here, clk, learn_mode, switch_dest_counter, origin, next, wand_on, trace_order, trace_boxes, init_row, init_col);

	input clk, learn_mode;
	input [9:0] init_col;
	input [8:0] init_row;
	output [3:0] origin, next; // change to inputs
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
	output reg wand_on;
	reg [3:0] cycle_counter;
	input [63:0] trace_order;
	reg [5:0] boxes_reached;
	input [5:0] trace_boxes;
	wire out;
	
	output wand_here;
	
	wands wandz(
		.address(offset_ADDR),
		.clock(~clk),
		.q(wand_here));
	
	assign offset_ADDR = ADDR + offset*10000;
	
	ordering orderz(.clk(switch_dest_clk), .trace_order(trace_order), 
						 .next(next), .now(origin), .tutorial(learn_mode));
	
	initial
	begin
		offset <= 0;
		//wand_row <= 90;
		//wand_col <= 170;
		//origin <= 5;
		//next <= 6;
		boxes_reached <= 0;
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
		
		if(switch_dest_counter == 25)
		begin
			switch_dest_counter <= 0;
			switch_dest_clk <= ~switch_dest_clk;
			boxes_reached <= boxes_reached + 1;
		end
		
		if(boxes_reached > trace_boxes*2)
			wand_on <= 1'b0;
		else
			wand_on <= 1'b1;
		
		// move wand
		if(update_location_counter >= 32'd2000000)
		begin
			// to the right
			if(origin == 0 & next == 0)
			begin
				wand_row <= init_row;
				wand_col <= init_col;
			end
			else if(next-origin == 1)
				wand_col <= wand_col + 2;
			// to the left
			else if(next-origin == -1)
				wand_col <= wand_col - 2;
			// down
			else if(next-origin == 4)
				wand_row <= wand_row + 2;
			// up
			else if(next-origin == -4)
				wand_row <= wand_row - 2;
			else
			begin
				wand_row <= wand_row;
				wand_col <= wand_col;
			end
			
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