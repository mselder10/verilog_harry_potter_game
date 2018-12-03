module lightning(row, col, clk, lightning, in_trace, lightning_powerup);

	input clk, in_trace, lightning_powerup;
	input [8:0] row;
	input [9:0] col;
	reg [18:0] lightning_col, lightning_row;
	reg [13:0] ADDR;
	reg [24:0] update_location_counter;
	reg [2:0] cycle_counter;
	wire out;
	output lightning;
	
	lightnin lightninz(.address(ADDR),
		.clock(~clk),
		.q(out));
	assign lightning = ~out;
	
	initial
	begin
		lightning_col <= 220;
		lightning_row <= 40;
	end
	
	always @(posedge clk & lightning_powerup)
	begin
	if(update_location_counter >= 32'd10000000)
		begin
			if(cycle_counter == 0)
				lightning_row <= lightning_row + 10;
			else if(cycle_counter == 1)
				lightning_col <= lightning_col + 10;
			else if(cycle_counter == 2)
				lightning_row <= lightning_row - 10;
			else if (cycle_counter == 3)
				lightning_col <= lightning_col - 10;
				
			cycle_counter <= cycle_counter + 1;
			update_location_counter <= 0;
		end
	else 
		update_location_counter <= update_location_counter + 1;
	
	if(cycle_counter == 4)
		cycle_counter <= 0;
	
	if ((row >= lightning_row) && (row < lightning_row + 100) && (col >= lightning_col) && (col < lightning_col + 100))
		begin
			if(ADDR == 9999 || (row == lightning_row & col == lightning_col))
				ADDR <= 0;
			else 
				ADDR <= ADDR + 1;
		end

	end
	
endmodule 