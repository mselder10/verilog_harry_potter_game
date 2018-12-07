module screenTimer(clock, total_screens, curr_screen, time_out, end_of_game, snitch_powerup, play_again, random);
//, end_of_game
// 5 seconds =  2500000000 cycles
// 10 seconds = 5000000000 cycles
// 20 seconds = 10000000000 cycles
input clock;
input [31:0] random;
output reg [31:0] time_out = 0;
output reg [4:0] curr_screen;
integer cycle_count = 0;
output reg end_of_game =1'b0;
output reg snitch_powerup;
input [5:0] total_screens;
integer sec_pulse = 0;
reg[31:0] counter_play_again;
output reg play_again;
reg current_game_time=0;

reg [31:0] sec_count; // can count to  64 secs

initial
begin
	play_again <= 0;
	curr_screen <= 1;
end

always @(posedge clock) begin
    //sec_pulse<= sec_pulse+1; //counting cycles to generate 1 second
    if(sec_pulse == 500000000) begin
	    time_out <= time_out +1;   //time out is counting the seconds
		 sec_pulse <= 0;
	 end
	 else 
		sec_pulse<= sec_pulse+1; 
	 
	 if(curr_screen == total_screens & ~play_again)
	     end_of_game<= 1'b1;  //signal end of game in order to display the score board
	 else
		end_of_game <= 1'b0;
		  
	 if(end_of_game==1'b1)
	 begin
		counter_play_again <= counter_play_again + 1;
		if(counter_play_again >= 200000000)
		begin
			play_again <= 1;
			counter_play_again <= 0;
		end
	 end
		
		  
    if (curr_screen == 1)
	 begin
	    if(cycle_count >= 12500000) begin
		   // sec_count <= sec_count +1;
			 cycle_count<=0;
			 curr_screen <= curr_screen + 4'b1;
			 end
		 else
			 cycle_count <= cycle_count +1;
	 end
	 
	 else if(curr_screen % 2 == 0 && curr_screen < total_screens ) begin
		//mod by two means we are displaying a trace
		if(cycle_count == 5000000000) begin
		  // sec_count <= sec_count +1;
		   cycle_count<=0;
			snitch_powerup<=1'b0;
			curr_screen <= curr_screen + 4'b1;
		end
		else if(cycle_count >= 9000000 && cycle_count <= 500000000 && random<=0)begin
		        snitch_powerup<=1'b1;
		        cycle_count <= cycle_count +1;
		end		  
		else if(cycle_count >= 9000000 && cycle_count <= 500000000 && random>=0)begin
		        snitch_powerup<=1'b0;
		        cycle_count <= cycle_count +1;	
		end	  
		else
				  cycle_count <= cycle_count +1;
			
//		if(sec_pulse >= 8 & sec_pulse < 15)
//			snitch_powerup <= 1'b1;
//		else
//			snitch_powerup <= 1'b0;
	 end	
	 //displaying a message?
	 else if(curr_screen % 2 == 1 && curr_screen < total_screens ) begin
	      if(cycle_count >= 2500000000) begin
				//sec_count <= sec_count +1;
				cycle_count<=0;
				curr_screen <= curr_screen + 4'b1;
		end 
	 end
	

end

endmodule