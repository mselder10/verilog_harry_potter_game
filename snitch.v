module snitch(row, col, clk, snitch_color, snitch, in_trace, snitch_powerup);

	input clk, in_trace, snitch_powerup;
	input [8:0] row;
	input [9:0] col;
	reg [18:0] ADDR;
	wire [1:0] out;
	reg [18:0] snitch_col, snitch_row;
	reg [31:0] update_location_counter, seconds_counter;
	output [7:0] snitch_color;
	reg snitched;
	output snitch;
	
	snitched snitchz(.address(ADDR),
		.clock(~clk),
		.q(out));
		
	assign snitch_color = ~out[1] & ~out[0] ? 8'd0 : 8'dz;
	assign snitch_color = ~out[1] &  out[0] ? 8'd1 : 8'dz;
	assign snitch_color = out[1] & out[0] ? 8'd11 : 8'dz;
	
	assign snitch =  ~(out[1] & ~out[0]) & snitched & in_trace;
	
	initial
	begin
		snitch_col <= 19'd120;
		snitch_row <= 19'd40;
	end
	
	always @(posedge clk & snitch_powerup)
	begin
		if(update_location_counter >= 32'd10000000)
		begin
			if (snitch_col-10 <= 120) 
				snitch_col <= snitch_col + 10;
			else if(snitch_col + 120 >= 520)
				snitch_col <= snitch_col-10;
			else if(snitch_row - 10 <= 40)
				snitch_row <= snitch_row + 10;
			else if(snitch_row + 120 >= 440)
				snitch_row <= snitch_row - 10;
			else if(seconds_counter % 5 == 0)
				snitch_row <= snitch_row + 10;
			else if(seconds_counter % 3 == 0)
				snitch_row <= snitch_row - 10;
			else if(seconds_counter % 8 > 4)
				snitch_col <= snitch_col - 10;
			else
				begin
					snitch_col <= snitch_col + 10; 
					snitch_row <= snitch_row + 10; 
				end
			
			if(seconds_counter >= 200)
				seconds_counter <= 0;
			else if(seconds_counter <= 4)
				seconds_counter <= seconds_counter + 2;
			else if(seconds_counter%10 == 1)
				seconds_counter <= seconds_counter + 3;
			else if(seconds_counter%12 == 5)
				seconds_counter <= seconds_counter + 8;
			else if(seconds_counter% 7 == 0)
				seconds_counter <= seconds_counter + 17;
			else
				seconds_counter <= seconds_counter + 1;
			
			update_location_counter <= 32'd0;				
		end
		else
			update_location_counter <= 	update_location_counter + 1;
		
		if ((row >= snitch_row) && (row < snitch_row + 100) && (col >= snitch_col) && (col < snitch_col + 100))
		begin
			snitched <= 1'b1;
			if(ADDR == 9999)
				ADDR <= 0;
			else 
				ADDR <= ADDR + 1;
			end
		else
			snitched <= 1'b0;
	end

endmodule 