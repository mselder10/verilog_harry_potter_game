module sparkle(row, col, clk, sparkle);

	input clk;
	input [8:0] row;
	input [9:0] col;
	reg [11:0] offset_ADDR;
	reg [11:0] ADDR, ADDR2;
	reg [11:0] offset, offset2;
	reg [31:0] update_offset_counter, update_offset_counter2;
	reg [2:0] cycle_counter, cycle_counter2;
	output sparkle;
	
	sparkles sparkz(
		.address(offset_ADDR),
		.clock(~clk),
		.q(sparkle));
	
	initial
	begin
		cycle_counter <= 0;
	end
	
	always @(posedge clk)
	begin
	if((row >= 80 & row < 100) & (col >=90 & col <110))
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
			
			if(ADDR == 399 || (row == 140 & col == 20))
				ADDR <= 0;
			else 
				ADDR <= ADDR + 1;
		offset_ADDR = ADDR + offset;
		end

	if((row >= 10 & row < 30) & (col >=10 & col <30))
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
			
			if(ADDR2 == 399 || (row == 10 & col == 30))
				ADDR2 <= 0;
			else 
				ADDR2 <= ADDR2 + 1;
		
		offset_ADDR = ADDR2 + offset2;
		end
		//offset_ADDR = ADDR + offset;
	end
	
	
endmodule 