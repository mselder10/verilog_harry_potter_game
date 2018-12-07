module sparkle(row, col, clk, sparkle, display_row1, display_col1, display_row2, display_col2, leaderboard, two_player_mode, select_mode);

	input clk, leaderboard, two_player_mode, select_mode;
	input [8:0] row, display_row1, display_row2;
	input [9:0] col, display_col1, display_col2;
	reg [11:0] offset_ADDR;
	reg [11:0] ADDR, ADDR2, ADDR3, ADDR4, ADDR5, ADDR6, ADDR7, ADDR8;
	reg [11:0] offset, offset2, offset3, offset4, offset5, offset6, offset7, offset8;
	reg [31:0] update_offset_counter, update_offset_counter2, update_offset_counter3, update_offset_counter4, update_offset_counter5,
					update_offset_counter6, update_offset_counter7, update_offset_counter8;
	reg [2:0] cycle_counter, cycle_counter2, cycle_counter3, cycle_counter4, cycle_counter5, cycle_counter6, cycle_counter7, cycle_counter8;
	output sparkle;
	
	sparkles sparkz(
		.address(offset_ADDR),
		.clock(~clk),
		.q(sparkle));
	
	initial
	begin
		cycle_counter <= 0;
		cycle_counter2 <= 0;
		cycle_counter3 <= 0;
		cycle_counter4 <= 0;
	end
	
	always @(posedge clk)
	begin
	if((row >= display_row1 & row < display_row1+20) & (col >= display_col1 & col <display_col1+20) & ~leaderboard)
		begin
			if(update_offset_counter >= 32'd5000)
				begin
					if(cycle_counter == 0)
						offset <= 0;
					else if (cycle_counter == 1)
						offset <= 400;
					else if (cycle_counter == 2)
						offset <= 800;
					else if (cycle_counter == 3)
						offset <= 1200;
		
					cycle_counter <= cycle_counter + 1;
					
					if(cycle_counter == 4)
						cycle_counter <= 0;
				
					update_offset_counter <= 0;
				end
			else
				update_offset_counter <= update_offset_counter + 1;
			
			if(ADDR == 399 || (display_row1 == 140 & display_col1 == 20))
				ADDR <= 0;
			else 
				ADDR <= ADDR + 1;
			offset_ADDR = ADDR + offset;
		end
		else if (leaderboard & (row >= 45 & row <65) & (col >= 120 & col < 140))
		begin
		
			if(update_offset_counter >= 32'd5000)
				begin
						if(cycle_counter == 0)
							offset <= 0;
						else if (cycle_counter == 1)
							offset <= 400;
						else if (cycle_counter == 2)
							offset <= 800;
						else if (cycle_counter == 3)
							offset <= 1200;
			
						cycle_counter <= cycle_counter + 1;
						
						if(cycle_counter == 4)
							cycle_counter <= 0;
					
						update_offset_counter <= 0;
					end
				else
					update_offset_counter <= update_offset_counter + 1;
				
				if(ADDR == 399 || (row == 45 & col == 120))
					ADDR <= 0;
				else 
					ADDR <= ADDR + 1;
					
					offset_ADDR = ADDR + offset;
				end

	
	if((row >= display_row2 & row < display_row2+20) & (col >= display_col2 & col <display_col2+20) & ~leaderboard)
		begin
			if(update_offset_counter2 >= 32'd5000)
				begin
					if(cycle_counter2 == 0)
						offset2 <= 0;
					else if (cycle_counter2 == 1)
						offset2 <= 400;
					else if (cycle_counter2 == 2)
						offset2 <= 800;
		
					cycle_counter2 <= cycle_counter2 + 1;
					
					if(cycle_counter2 == 3)
						cycle_counter2 <= 0;
				
					update_offset_counter2 <= 0;
				end
			else
				update_offset_counter2 <= update_offset_counter2 + 1;
			
			if(ADDR2 == 399 || (row == display_row2 & display_col2 == col))
				ADDR2 <= 0;
			else 
				ADDR2 <= ADDR2 + 1;
		
		offset_ADDR = ADDR2 + offset2;
		end
		else if (leaderboard & (row >= 220 & row <240) & (col >= 172 & col < 192))
			begin

			if(update_offset_counter2 >= 32'd5000)
				begin
						if(cycle_counter2 == 0)
							offset2 <= 0;
						else if (cycle_counter2 == 1)
							offset2 <= 400;
						else if (cycle_counter2 == 2)
							offset2 <= 800;
						else if (cycle_counter2 == 3)
							offset2 <= 1200;
			
						cycle_counter2 <= cycle_counter2 + 1;
						
						if(cycle_counter2 == 4)
							cycle_counter2 <= 0;
					
						update_offset_counter2 <= 0;
					end
				else
					update_offset_counter2 <= update_offset_counter2 + 1;
				
				if(ADDR2 == 399 || (row == 220 & col == 172))
					ADDR2 <= 0;
				else 
					ADDR2 <= ADDR2 + 1;
					
					offset_ADDR = ADDR2 + offset2;
				end
		
		if((row >= 45 & row < 65) & (col >= 530 & col <550) & ~leaderboard & two_player_mode)
		begin
			if(update_offset_counter3 >= 32'd5000)
				begin
					if(cycle_counter3 == 0)
						offset3 <= 0;
					else if (cycle_counter3 == 1)
						offset3 <= 400;
					else if (cycle_counter3 == 2)
						offset3 <= 800;
					else if (cycle_counter3 == 3)
						offset3 <= 1200;
		
					cycle_counter3 <= cycle_counter3 + 1;
					
					if(cycle_counter3 == 4)
						cycle_counter3 <= 0;
				
					update_offset_counter3 <= 0;
				end
			else
				update_offset_counter3 <= update_offset_counter3 + 1;
			
			if(ADDR3 == 399 || (row == 45 & col == 530))
				ADDR3 <= 0;
			else 
				ADDR3 <= ADDR3 + 1;
		
		offset_ADDR = ADDR3 + offset3;
		end
		else if((row >= 290 & row < 310) & (col >= 120 & col <140) & leaderboard)
		begin
		
			if(update_offset_counter3 >= 32'd5000)
				begin
					if(cycle_counter3 == 0)
						offset3 <= 0;
					else if (cycle_counter3 == 1)
						offset3 <= 400;
					else if (cycle_counter3 == 2)
						offset3 <= 800;
					else if (cycle_counter3 == 3)
						offset3 <= 1200;
		
					cycle_counter3 <= cycle_counter3 + 1;
					
					if(cycle_counter3 == 4)
						cycle_counter3 <= 0;
				
					update_offset_counter3 <= 0;
				end
			else
				update_offset_counter3 <= update_offset_counter3 + 1;
			
			if(ADDR3 == 399 || (row == 290 & col == 120))
				ADDR3 <= 0;
			else 
				ADDR3 <= ADDR3 + 1;
		
			offset_ADDR = ADDR3 + offset3;
			end
		
		if((row >= 90 & row < 110) & (col >= 590 & col <610) & ~leaderboard & two_player_mode)
		begin
		
			if(update_offset_counter4 >= 32'd15000)
				begin
					if(cycle_counter4 == 3)
						offset4 <= 0;
					else if (cycle_counter4 == 2)
						offset4 <= 400;
					else if (cycle_counter4 == 1)
						offset4 <= 800;
					else if (cycle_counter4 == 0)
						offset4 <= 1200;
		
					cycle_counter4 <= cycle_counter4 + 1;
					
					if(cycle_counter4 == 4)
						cycle_counter4 <= 0;
				
					update_offset_counter4 <= 0;
				end
			else
				update_offset_counter4 <= update_offset_counter4 + 1;
			
			if(ADDR4 == 399 || (row == 100 & col == 590))
				ADDR4 <= 0;
			else 
				ADDR4 <= ADDR4 + 1;
		
		offset_ADDR = ADDR4 + offset4;
		end
		else if((row >= 350 & row < 370) & (col >= 200 & col <220) & leaderboard)
		begin
			if(update_offset_counter4 >= 32'd15000)
				begin
					if(cycle_counter4 == 3)
						offset4 <= 0;
					else if (cycle_counter4 == 2)
						offset4 <= 400;
					else if (cycle_counter4 == 1)
						offset4 <= 800;
					else if (cycle_counter4 == 0)
						offset4 <= 1200;
		
					cycle_counter4 <= cycle_counter4 + 1;
					
					if(cycle_counter4 == 4)
						cycle_counter4 <= 0;
				
					update_offset_counter4 <= 0;
				end
			else
				update_offset_counter4 <= update_offset_counter4 + 1;
			
			if(ADDR4 == 399 || (row == 350 & col == 200))
				ADDR4 <= 0;
			else 
				ADDR4 <= ADDR4 + 1;
		
			offset_ADDR = ADDR4 + offset4;
		end
		
		
		
		if((row >= 400 & row < 420) & (col >= 555 & col <575) & ~leaderboard)
		begin
			if(update_offset_counter5 >= 32'd5000)
				begin
					if(cycle_counter5 == 3)
						offset5 <= 0;
					else if (cycle_counter5 == 2)
						offset5 <= 400;
					else if (cycle_counter5 == 1)
						offset5 <= 800;
					else if (cycle_counter5 == 0)
						offset5 <= 1200;
		
					cycle_counter5 <= cycle_counter5 + 1;
					
					if(cycle_counter5 == 4)
						cycle_counter5 <= 0;
				
					update_offset_counter5 <= 0;
				end
			else
				update_offset_counter5 <= update_offset_counter5 + 1;
			
			if(ADDR5 == 399 || (row == 400 & col == 555))
				ADDR5 <= 0;
			else 
				ADDR5 <= ADDR5 + 1;
		
		offset_ADDR = ADDR5 + offset5;
		end
		
		// set screen
		if((row >= 55 & row < 75) & (col >= 460 & col <580) & ~leaderboard & select_mode)
		begin
			if(update_offset_counter6 >= 32'd5000)
				begin
					if(cycle_counter6 == 3)
						offset6 <= 0;
					else if (cycle_counter6 == 2)
						offset6 <= 400;
					else if (cycle_counter6 == 1)
						offset6 <= 800;
					else if (cycle_counter6 == 0)
						offset6 <= 1200;
		
					cycle_counter6 <= cycle_counter6 + 1;
					
					if(cycle_counter6 == 4)
						cycle_counter6 <= 0;
				
					update_offset_counter6 <= 0;
				end
			else
				update_offset_counter6 <= update_offset_counter6 + 1;
			
			if(ADDR6 == 399 || (row == 55 & col == 460))
				ADDR6 <= 0;
			else 
				ADDR6 <= ADDR6 + 1;
		
		offset_ADDR = ADDR6 + offset6;
		end
		
		if((row >= 300 & row < 320) & (col >= 70 & col <90) & ~leaderboard & select_mode)
		begin
			if(update_offset_counter7 >= 32'd5000)
				begin
					if(cycle_counter7 == 1)
						offset7 <= 0;
					else if (cycle_counter7 == 2)
						offset7 <= 400;
					else if (cycle_counter7 == 3)
						offset7 <= 800;
					else if (cycle_counter7 == 0)
						offset7 <= 1200;
		
					cycle_counter7 <= cycle_counter7 + 1;
					
					if(cycle_counter7 == 4)
						cycle_counter7 <= 0;
				
					update_offset_counter7 <= 0;
				end
			else
				update_offset_counter7 <= update_offset_counter7 + 1;
			
			if(ADDR7 == 399 || (row == 300 & col == 70))
				ADDR7 <= 0;
			else 
				ADDR7 <= ADDR7 + 1;
		
		offset_ADDR = ADDR7 + offset7;
		end
		
		
		if((row >= 265 & row < 285) & (col >= 340 & col <360) & ~leaderboard & select_mode)
		begin
			if(update_offset_counter8 >= 32'd5000)
				begin
					if(cycle_counter8 == 1)
						offset8 <= 0;
					else if (cycle_counter8 == 2)
						offset8 <= 400;
					else if (cycle_counter8 == 3)
						offset8 <= 800;
					else if (cycle_counter8 == 0)
						offset8 <= 1200;
		
					cycle_counter8 <= cycle_counter8 + 1;
					
					if(cycle_counter8 == 4)
						cycle_counter8 <= 0;
				
					update_offset_counter8 <= 0;
				end
			else
				update_offset_counter8 <= update_offset_counter8 + 1;
			
			if(ADDR8 == 399 || (row == 265 & col == 340))
				ADDR8 <= 0;
			else 
				ADDR8 <= ADDR8 + 1;
		
		offset_ADDR = ADDR8 + offset8;
		end
	end
	
	
endmodule 