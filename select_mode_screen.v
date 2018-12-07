module select_mode_screen(two_player_mode, clk, learn, ir_in_p1, select_mode_screen, selected_a_mode);

	input two_player_mode, clk, select_mode_screen;
	input [15:0] ir_in_p1;
	
	output reg learn;
	output reg selected_a_mode;
	
	initial
	begin
		selected_a_mode <= 1'b0;
	end
	
	always@(posedge clk & select_mode_screen)
	begin
		
		if(|(ir_in_p1[7:0]))
		begin
			learn <= 1'b1;
			selected_a_mode <= 1'b1;
		end
		else if (|(ir_in_p1[13:8]) | ir_in_p1[15])
		begin
			learn <= 1'b0;
			selected_a_mode <= 1'b1;
		end
			
	end

endmodule 