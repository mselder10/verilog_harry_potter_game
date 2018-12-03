module four_by_four(row, col, color_in_box, box_color, clk, ir_in, R, S, G, H, already_traced,
							broom_powerup, two_player_mode, reset_other_player_trace, clear_my_trace, snitch_location, reset_trace,
							displayed_trace);

	input clk, R, S, G, H, broom_powerup, two_player_mode, clear_my_trace, reset_trace;
	input [8:0] row;
	input [9:0] col;
	input [15:0] ir_in;
	output reg [15:0] already_traced;
	input [15:0] snitch_location;
	input [15:0] displayed_trace;
	reg snitch, did_player_hit_trace;
	output reg color_in_box;
	output reg reset_other_player_trace;
	output [7:0] box_color;
	reg [31:0] counter, hold_reset;
	
	initial
	begin
		already_traced <= 16'd0;
		snitch <= 0;
		hold_reset <= 0;
	end

	always@(posedge clk)
	begin
//	/***********RESET USER TRACE WHEN NEW TRACE DISPLAYED********/
	if(reset_trace || hold_reset != 0)
	begin
		if(hold_reset < 10000000)
		begin
			already_traced <= 0;
			hold_reset <= hold_reset + 1;
		end
		else
			hold_reset <= 0;
	end
	
	/***********BROOM POWERUP************/
	// reset trace on broom_powerup
	if((~two_player_mode & broom_powerup & ir_in[6]) || (two_player_mode & clear_my_trace))
		already_traced <= 0;
		
	// TWO PLAYER reset opponent trace on broom_powerup
	if(two_player_mode & broom_powerup & ir_in[6])
		reset_other_player_trace <= 1'b1;
	else
		reset_other_player_trace <= 1'b0;
	/************************************/
	// ROW 0
		// box 0
		if      ((ir_in[0] || already_traced[0]) &
					row >= 40 & row < 140 & 
					col >= 120 & col < 220)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[0] <= 1'b1;
				snitch <= snitch_location[15];
				did_player_hit_trace <= displayed_trace[0];
			end
		// box 1
		else if ((ir_in[1] || already_traced[1]) &
					row >= 40 & row < 140 & 
					col >= 220 & col < 320)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[1] <= 1'b1;
				snitch <= snitch_location[1];
				did_player_hit_trace <= displayed_trace[1];
			end
		// box 2
		else if ((ir_in[2] || already_traced[2]) &
					row >= 40 & row < 140 & 
					col >= 320 & col < 420)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[2] <= 1'b1;
				snitch <= snitch_location[2];
				did_player_hit_trace <= displayed_trace[2];
			end
		// box 3
		else if ((ir_in[3] || already_traced[3]) &
					row >= 40 & row < 140 & 
					col >= 420 & col < 520)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[3] <= 1'b1;
				snitch <= snitch_location[3];
				did_player_hit_trace <= displayed_trace[3];
			end
	// ROW 1
		// box 4
		else if  ((ir_in[4] || already_traced[4]) &
					row >= 140 & row < 240 & 
					col >= 120 & col < 220)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[4] <= 1'b1;
				snitch <= snitch_location[4];
				did_player_hit_trace <= displayed_trace[4];
			end
		// box 5
		else if ((ir_in[5] || already_traced[5]) &
					row >= 140 & row < 240 & 
					col >= 220 & col < 320)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[5] <= 1'b1;
				snitch <= snitch_location[5];
				did_player_hit_trace <= displayed_trace[5];
			end
		// box 6
		else if ((ir_in[6] || already_traced[6]) &
					row >= 140 & row < 240 & 
					col >= 320 & col < 420)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[6] <= 1'b1;
				snitch <= snitch_location[6];
				did_player_hit_trace <= displayed_trace[6];
			end
		// box 7
		else if ((ir_in[7] || already_traced[7]) &
					row >= 140 & row < 240 & 
					col >= 420 & col < 520)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[7] <= 1'b1;
				snitch <= snitch_location[7];
				did_player_hit_trace <= displayed_trace[7];
			end
	// ROW 2
		// box 8
		else if  ((ir_in[8] || already_traced[8]) &
					row >= 240 & row < 340 & 
					col >= 120 & col < 220)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[8] <= 1'b1;
				snitch <= snitch_location[8];
				did_player_hit_trace <= displayed_trace[8];
			end
		// box 9
		else if ((ir_in[9] || already_traced[9])  &
					row >= 240 & row < 340 & 
					col >= 220 & col < 320)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[9] <= 1'b1;
				snitch <= snitch_location[9];
				did_player_hit_trace <= displayed_trace[9];
			end
		// box 10
		else if ((ir_in[10] || already_traced[10]) &
					row >= 240 & row < 340 & 
					col >= 320 & col < 420)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[10] <= 1'b1;
				snitch <= snitch_location[10];
				did_player_hit_trace <= displayed_trace[10];
			end
		// box 11
		else if ((ir_in[11] || already_traced[11]) &
					row >= 240 & row < 340 & 
					col >= 420 & col < 520)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[11] <= 1'b1;
				snitch <= snitch_location[11];
				did_player_hit_trace <= displayed_trace[11];
			end
	// ROW 3
		// box 12
		else if  ((ir_in[12] || already_traced[12]) &
					row >= 340 & row < 440 & 
					col >= 120 & col < 220)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[12] <= 1'b1;
				snitch <= snitch_location[12];
				did_player_hit_trace <= displayed_trace[12];
			end
		// box 13
		else if ((ir_in[13] || already_traced[13]) &
					row >= 340 & row < 440 & 
					col >= 220 & col < 320)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[13] <= 1'b1;
				snitch <= snitch_location[13];
				did_player_hit_trace <= displayed_trace[13];
			end
		// box 14
		else if ((ir_in[14] || already_traced[14]) &
					row >= 340 & row < 440 & 
					col >= 320 & col < 420)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[14] <= 1'b1;
				snitch <= snitch_location[14];
				did_player_hit_trace <= displayed_trace[14];
			end
		// box 15
		else if ((ir_in[15] || already_traced[15]) &
					row >= 340 & row < 440 & 
					col >= 420 & col < 520)
			begin
				color_in_box <= (hold_reset == 0);
				already_traced[15] <= 1'b1;
				snitch <= snitch_location[15];
				did_player_hit_trace <= displayed_trace[15];
			end
		else 
		begin
			color_in_box <= 1'b0;
			snitch <= 1'b0;
		end
			
	end
	
	// hit target
	assign box_color = G & ~snitch & did_player_hit_trace ? 8'h49 : 8'bz;
	assign box_color = H & ~snitch & did_player_hit_trace ? 8'hdc : 8'bz;
	assign box_color = S & ~snitch & did_player_hit_trace ? 8'h16 : 8'bz;
	assign box_color = R & ~snitch & did_player_hit_trace ? 8'h9a : 8'bz;
	// did not hit target
	assign box_color = G & ~snitch & ~did_player_hit_trace ? 8'h50 : 8'bz;
	assign box_color = H & ~snitch & ~did_player_hit_trace ? 8'hdd	: 8'bz;
	assign box_color = S & ~snitch & ~did_player_hit_trace ? 8'h17 : 8'bz;
	assign box_color = R & ~snitch & ~did_player_hit_trace ? 8'h99 : 8'bz;
	// snitch
	assign box_color = snitch 		 ? 8'h50 : 8'bz;
	// default
	assign box_color = ~G & ~R & ~H & ~S & ~snitch ? 8'd0 : 8'bz;

endmodule 