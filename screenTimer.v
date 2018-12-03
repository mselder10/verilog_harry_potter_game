module screenTimer(clock, total_screens, curr_screen, time_out, end_of_game);
//, end_of_game
// 5 seconds =  2500000000 cycles
// 10 seconds = 5000000000 cycles
// 20 seconds = 10000000000 cycles
input clock;
output reg [31:0] time_out = 0;
output reg [4:0] curr_screen = 1;
integer cycle_count = 0;
output reg end_of_game =1'b0;
input [5:0] total_screens;
integer sec_pulse = 0;

reg [31:0] sec_count; // can count to  64 secs

always @(posedge clock) begin
    //sec_pulse<= sec_pulse+1; //counting cycles to generate 1 second
    if(sec_pulse == 500000000) begin
	    time_out <= time_out +1;   //time out is counting the seconds
		 sec_pulse <= 0;
	 end
	 else 
		sec_pulse<= sec_pulse+1; 
	 
	 if(curr_screen == total_screens)
	     end_of_game<= 1'b1;  //signal end of game in order to display the score board
		  
    if (curr_screen == 1)
	 begin
	    if(cycle_count == 1250000000) begin
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
			curr_screen <= curr_screen + 4'b1;
		end
		else
		   cycle_count <= cycle_count +1;
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


















//module screenTimer(clock, total_screens, timePowerUp, curr_screen, time_out, end_of_game, flagP1, flagP2, flagP3, flagP4);
////, end_of_game
//// 5 seconds =  2500000000 cycles
//// 10 seconds = 5000000000 cycles
//// 20 seconds = 10000000000 cycles
//input clock, timePowerUp;
//output reg [31:0] time_out = 0;
//output reg [4:0] curr_screen = 5'b1;
//integer cycle_count = 0;
//output reg end_of_game =1'b0;
//input [5:0] total_screens;
//integer sec_pulse = 0;
//output reg flagP1 = 1'b0;
//output reg flagP2 = 1'b0;
//output reg flagP3 = 1'b0;
//output reg flagP4 = 1'b0;
//reg [31:0] sec_count; // can count to  64 secs
//
//always @(posedge clock) begin
//    //sec_pulse<= sec_pulse+1; //counting cycles to generate 1 second
//    if(sec_pulse >= 5) begin //500000000
//	    time_out <= time_out +1;   //time out is counting the seconds
//		 sec_pulse <= 0;
//	 end
//	 else 
//		sec_pulse<= sec_pulse+1; 
//	 
//	 if(curr_screen == total_screens)
//	     end_of_game<= 1'b1;  //signal end of game in order to display the score board
//	 
//	 //Screen one - logo	  
//    if (curr_screen == 1)
//	 begin
//	    if(cycle_count >= 5) begin //1250000000
//		   // sec_count <= sec_count +1;
//			 cycle_count<=0;
//			 curr_screen <= curr_screen + 4'b1;
//			 end
//		else
//		   cycle_count <= cycle_count +1;
//	 end
//	 
//	 //Traces
//	 else if(curr_screen % 2 == 0 && curr_screen < total_screens ) begin
//	    //flags for powerups
////	   if(cycle_count >= 5 && cycle_count <= 10 && curr_screen ==2) begin //5000000  50000000
////		     flagP1<=1'b1;
////		end
////		else 
////		   flagP1<=1'b0;
////			
////		if(cycle_count >= 2 && cycle_count <= 6 && curr_screen >2) begin //70000 5000000
////		     flagP1<=1'b1;
////			  flagP2<=1'b1;
////		end
////		else begin
////			  flagP1<=1'b0;
////			  flagP2<=1'b0;
////		end	  
////			
////		if(cycle_count >= 8 && cycle_count <= 12 && curr_screen >2) begin //300000000 4000000000
////		     flagP3<=1'b1;
////			  flagP4<=1'b1;
////		end
////		else begin
////			  flagP3<=1'b0;
////			  flagP4<=1'b0;
////		end
//		//mod by two means we are displaying a trace
//		if(timePowerUp >= 1'b1) begin
//			if(cycle_count >= 20) begin //9999900000
//		  // sec_count <= sec_count +1;
//		   cycle_count<=0;
//			curr_screen <= curr_screen + 4'b1;
//		   end
//		end
//		else if(timePowerUp == 1'b0) begin
//		   if(cycle_count >= 15) begin //5000000000
//		  // sec_count <= sec_count +1;
//		   cycle_count<=0;
//			curr_screen <= curr_screen + 4'b1;
//		   end
//		 end
//		
//		else
//		   cycle_count <= cycle_count +1;
//	 end	
//	 //displaying a message?
//	 else if(curr_screen % 2 == 1 && curr_screen < total_screens ) begin
//	      if(cycle_count >= 5) begin //2500000000
//				//sec_count <= sec_count +1;
//				cycle_count<=0;
//				curr_screen <= curr_screen + 4'b1;
//		end 
//	 end
//	
//
//end
//
//endmodule