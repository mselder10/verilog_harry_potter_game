module screenTimer(clock, total_screens, curr_screen, time_out, end_of_game, snitch_powerup,
							play_again, selected_a_mode, select_mode_screen, logo, end_game_early, end_tutorial, 
							two_player_mode);
//, end_of_game
// 5 seconds =  2500000000 cycles
// 10 seconds = 5000000000 cycles
// 20 seconds = 10000000000 cycles
input clock, selected_a_mode, end_game_early, end_tutorial, two_player_mode;
output reg [31:0] time_out = 0;
output reg [4:0] curr_screen;
integer cycle_count = 0;
output reg end_of_game =1'b0;
output reg snitch_powerup;
input [5:0] total_screens;
integer sec_pulse = 0;
reg[31:0] counter_play_again;
output reg play_again, logo, select_mode_screen;
reg [31:0] counter, game_counter;

reg [31:0] sec_count; // can count to  64 secs

initial
begin
	play_again <= 0;
	//curr_screen <= 1;
	game_counter <= 0;
	counter<=0;
	logo <= 1;
	select_mode_screen <= 0;
	snitch_powerup <= 1'b0;
end

always @(posedge clock) begin
    //sec_pulse<= sec_pulse+1; //counting cycles to generate 1 second
    if(sec_pulse == 500000000) begin
	    time_out <= time_out +1;   //time out is counting the seconds
		 sec_pulse <= 0;
	 end
	 else 
		sec_pulse<= sec_pulse+1; 
	
	 counter <= counter + 1;
	
	 if(counter < 2500000000 & logo)
		logo <= 1'b1;
	 else
		logo <= 1'b0;
	
	 if(counter >= 2500000000 & ~selected_a_mode & ~two_player_mode)
		select_mode_screen <= 1'b1;
	 else if (counter >= 2500000000 & (selected_a_mode || two_player_mode))
	 begin
		select_mode_screen <= 1'b0;
		game_counter <= 2500000000;
	 end
	 else
		select_mode_screen <= 1'b0;
		
	 if(game_counter < 2000000000 & game_counter > 1800000000)
		snitch_powerup <= 1'b1;
	 else
		snitch_powerup <= 1'b0;
	 
	 if(game_counter != 0)
		game_counter <= game_counter - 1;
	 
	 if(game_counter < 0 & ~play_again)
	   end_of_game<= 1'b1;  //signal end of game in order to display the score board
	 else
		end_of_game <= 1'b0;
		  
	 if((end_of_game | end_game_early) & ~play_again)
	 begin
		counter_play_again <= counter_play_again + 1;
		if(counter_play_again >= 200000000)
		begin
			play_again <= 1;
			counter_play_again <= 0;
		end
	 end
	 else if (end_tutorial)
		play_again <= 1'b1;
	

end

endmodule