module snitch(row, col, clk, snitch_color, snitch, in_trace, snitch_powerup, snitch_location, ir_in_p1, snitch_caught);

	input clk, in_trace, snitch_powerup;
	input [8:0] row;
	input [9:0] col;
	input [15:0] ir_in_p1;
	reg [18:0] ADDR;
	wire [1:0] out;
	reg [18:0] snitch_col, snitch_row;
	reg [31:0] update_location_counter, seconds_counter;
	output [7:0] snitch_color;
	output reg [15:0] snitch_location;
	reg snitched;
	output reg snitch_caught;
	output snitch;
	
	snitched snitchz(.address(ADDR),
		.clock(~clk),
		.q(out));
		
	assign snitch_color = ~out[1] & ~out[0] & ~snitch_caught ? 8'd0 : 8'dz;
	assign snitch_color = ~out[1] &  out[0] & ~snitch_caught ? 8'd1 : 8'dz;
	assign snitch_color = out[1] & out[0]   & ~snitch_caught ? 8'd11 : 8'dz;
	
	assign snitch =  ~(out[1] & ~out[0]) & snitched & in_trace & ~snitch_caught;
	
	initial
	begin
		snitch_col <= 19'd120;
		snitch_row <= 19'd40;
	end
	
	always @(posedge clk & snitch_powerup)
	begin
		if(update_location_counter >= 32'd7500000)
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
			if(ADDR == 9999 || (row == snitch_row & col == snitch_col))
				ADDR <= 0;
			else 
				ADDR <= ADDR + 1;
			end
		else
			snitched <= 1'b0;
	
	// did you catch the snitch?
	if      (ir_in_p1[0] &
					snitch_row >= 40 & snitch_row < 140 & 
					snitch_col >= 120 & snitch_col < 220)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000000000001;
			end
		// box 1
		else if (ir_in_p1[1] &
					snitch_row >= 40 & snitch_row < 140 & 
					snitch_col >= 220 & snitch_col < 320)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000000000010;
			end
		// box 2
		else if (ir_in_p1[2] &
					snitch_row >= 40 & snitch_row < 140 & 
					snitch_col >= 320 & snitch_col < 420)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000000000100;
			end
		// box 3
		else if (ir_in_p1[3]&
					snitch_row >= 40 & snitch_row < 140 & 
					snitch_col >= 420 & snitch_col < 520)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000000001000;
			end
	// ROW 1
		// box 4
		else if  (ir_in_p1[4] &
					snitch_row >= 140 & snitch_row < 240 & 
					snitch_col >= 120 & snitch_col < 220)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000000010000;
			end
		// box 5
		else if (ir_in_p1[5] &
					snitch_row >= 140 & snitch_row < 240 & 
					snitch_col >= 220 & snitch_col < 320)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000000100000;
			end
		// box 6
		else if (ir_in_p1[6] &
					snitch_row >= 140 & snitch_row < 240 & 
					snitch_col >= 320 & snitch_col < 420)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000001000000;
			end
		// box 7
		else if (ir_in_p1[7] &
					snitch_row >= 140 & snitch_row < 240 & 
					snitch_col >= 420 & snitch_col < 520)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000010000000;
			end
	// ROW 2
		// box 8
		else if  (ir_in_p1[8] &
					snitch_row >= 240 & snitch_row < 340 & 
					snitch_col >= 120 & snitch_col < 220)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000000100000000;
			end
		// box 9
		else if (ir_in_p1[9]  &
					snitch_row >= 240 & snitch_row < 340 & 
					snitch_col >= 220 & snitch_col < 320)
			begin
				snitch_caught <= 1'b1;
				snitch_location <=  16'b0000001000000000;
			end
		// box 10
		else if (ir_in_p1[10] &
					snitch_row >= 240 & snitch_row < 340 & 
					snitch_col >= 320 & snitch_col < 420)
			begin
				snitch_caught <= 1'b1;
				snitch_location <= 16'b0000010000000000;
			end
		// box 11
		else if (ir_in_p1[11] &
					snitch_row >= 240 & snitch_row < 340 & 
					snitch_col >= 420 & snitch_col < 520)
			begin
				snitch_caught <= 1'b1;
				snitch_location <= 16'b0000100000000000;
			end
	// ROW 3
		// box 12
		else if  (ir_in_p1[12] &
					snitch_row >= 340 & snitch_row < 440 & 
					snitch_col >= 120 & snitch_col < 220)
			begin
				snitch_caught <= 1'b1;
				snitch_location <= 16'h0001000000000000;
			end
		// box 13
		else if (ir_in_p1[13] &
					snitch_row >= 340 & snitch_row < 440 & 
					snitch_col >= 220 & snitch_col < 320)
			begin
				snitch_caught <= 1'b1;
				snitch_location <= 16'h0010000000000000;
			end
		// box 14
		else if (ir_in_p1[14] &
					snitch_row >= 340 & snitch_row < 440 & 
					snitch_col >= 320 & snitch_col < 420)
			begin
				snitch_caught <= 1'b1;
				snitch_location <= 16'h0100000000000000;
			end
		// box 15
		else if (ir_in_p1[15] &
					snitch_row >= 340 & snitch_row < 440 & 
					snitch_col >= 420 & snitch_col < 520)
			begin
				snitch_caught <= 1'b1;
				snitch_location <= 16'h1000000000000000;
			end
		else 
			begin
				snitch_caught <= 1'b0;
				snitch_location <= 0;
			end
			
			
	end

endmodule 