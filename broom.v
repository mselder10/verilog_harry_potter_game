module broom(row, col, clk, broom, in_trace, broom_powerup);

	input clk, in_trace, broom_powerup;
	input [8:0] row;
	input [9:0] col;
	reg [18:0] broom_col, broom_row;
	reg [13:0] ADDR;
	reg [24:0] update_location_counter;
	reg cycle_counter;
	wire out;
	output broom;
	
	broomstick broomstikz(.address(ADDR),
		.clock(~clk),
		.q(out));
	assign broom = ~out;
	
	// in box 6
	initial
	begin
		broom_col <= 320;
		broom_row <= 140;
	end
	
	always @(posedge clk & broom_powerup)
	begin
	if(update_location_counter >= 32'd10000000)
		begin
			if(cycle_counter == 0)
				broom_row <= broom_row + 10;
//			else if(cycle_counter == 1)
//				broom_col <= broom_col + 10;
			else if(cycle_counter == 1)
				broom_row <= broom_row - 10;
//			else if (cycle_counter == 3)
//				broom_col <= broom_col - 10;
				
			cycle_counter <= cycle_counter + 1;
			update_location_counter <= 0;
		end
	else 
		update_location_counter <= update_location_counter + 1;
	
	if(cycle_counter == 2)
		cycle_counter <= 0;
	
	if ((row >= broom_row) && (row < broom_row + 100) && (col >= broom_col) && (col < broom_col + 100))
		begin
			//broom <= 1'b1;
			if(ADDR == 9999 || (row == broom_row & col == broom_col))
				ADDR <= 0;
			else 
				ADDR <= ADDR + 1;
		end

	end
	
endmodule 