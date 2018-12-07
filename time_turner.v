module time_turner(row, col, clk, time_turner, in_trace, time_turner_powerup, already_traced_12, time_turner, time_turner_caught);

	input clk, in_trace, time_turner_powerup, already_traced_12;
	input [8:0] row;
	input [9:0] col;
	reg [18:0] time_turner_col, time_turner_row;
	reg [13:0] ADDR;
	reg [24:0] update_location_counter;
	reg cycle_counter;
	wire out;
	output time_turner;
	output reg time_turner_caught;
	
	time_turn time_turnz(.address(ADDR),
		.clock(~clk),
		.q(out));
	assign time_turner = ~out;
	
	initial
	begin
		time_turner_col <= 120;
		time_turner_row <= 340;
		time_turner_caught <= 0;
	end
	
	always @(posedge clk & time_turner_powerup & ~time_turner_caught)
	begin
	
	if(already_traced_12)
		time_turner_caught <= 1'b1;
	else
		time_turner_caught <= 1'b0;

	if(update_location_counter >= 32'd10000000)
		begin
			if(cycle_counter == 0)
				time_turner_col <= time_turner_col + 2;
			else if(cycle_counter == 1)
				time_turner_col <= time_turner_col - 2;
				
			cycle_counter <= cycle_counter + 1;
			update_location_counter <= 0;
		end
	else 
		update_location_counter <= update_location_counter + 1;
	
	if(cycle_counter == 2)
		cycle_counter <= 0;
	
	if ((row >= time_turner_row) && (row < time_turner_row + 100) && (col >= time_turner_col) && (col < time_turner_col + 100))
		begin
			if(ADDR == 9999 || (row == time_turner_row & col == time_turner_col))
				ADDR <= 0;
			else 
				ADDR <= ADDR + 1;
		end

	end
	
endmodule 