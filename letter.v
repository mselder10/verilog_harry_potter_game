module letter(letter, clk, row, col,
			  leaderboard, play_again, select_mode, logo);
	
	input clk, leaderboard, play_again, select_mode, logo;
	input [8:0] row;
	input [9:0] col;

	wire [4:0] get_ready_letter, times_up_letter, house_cup_letter;
	wire [4:0] display_letter;

	wire [4:0] get_ready_ADDR, times_up_ADDR, house_cup_ADDR;
	reg [12:0] ADDR, ADDR1, ADDR2;
	wire [15:0] offset_ADDR;

	output letter;


	// find letter offset in mif file
	reg [4:0]  tletter;
	always @(posedge clk)
	begin
		if(((row>= 0 & row < 50) & ((col>=95 & col < 345) || (col>=395 & col < 545))) & leaderboard & ~play_again)
			begin
				ADDR <= ADDR + 1;
				if(((ADDR+1) % 50) == 0)
					ADDR <= row*50;
			end
		else if((row>= 215 & row < 265) & ((col>=70 & col < 270)||(col>=320 & col <570)) & play_again)
		begin
				ADDR <= ADDR + 1;
				if(((ADDR+1) % 50) == 0)
					ADDR <= (row%215)*50;
			end
		else if((row>= 0 & row < 50) & ((col>=80 & col < 230)||(col>=280 & col <580)) & select_mode)
		begin
				ADDR <= ADDR + 1;
				if(((ADDR+1) % 50) == 0)
					ADDR <= (row%215)*50;
			end
		else if((row>= 130 & row < 180) & (col>=195 & col < 445) & select_mode)
		begin
				ADDR <= ADDR + 1;
				if(((ADDR+1) % 50) == 0)
					ADDR <= (row%130)*50;
			end
		else if((row>= 345 & row < 395) & (col>=220 & col < 420) & select_mode)
		begin
				ADDR <= ADDR + 1;
				if(((ADDR+1) % 50) == 0)
					ADDR <= (row%345)*50;
			end
//		else if((row>= 10 & row < 60) & ((col>=10 & col < 360) | (col>=360 & col < 510)) & logo)
//		begin
//				ADDR <= ADDR + 1;
//				if(((ADDR+1) % 50) == 0)
//					ADDR <= (row%10)*50;
//			end
//		else if((row>= 360 & row < 410) & (col>=280 & col < 580) & logo)
//		begin
//				ADDR <= ADDR + 1;
//				if(((ADDR+1) % 50) == 0)
//					ADDR <= (row%360)*50;
//			end
			
		
		// house cup
		// H
		if((col>=95 & col <145) & (row>= 0 & row < 50) & leaderboard & ~play_again)
			tletter <= 5'd7;
		// O
		if((col>=145 & col <195) & (row>= 0 & row < 50) & leaderboard & ~play_again)
			tletter <= 5'd14;
		// U
		if(((col>=195 & col <245) || (col>=445 & col <495)) & (row>= 0 & row < 50) & leaderboard & ~play_again)
			tletter <= 5'd20;
		// S
		if((col>=245 & col <295) & leaderboard & (row>= 0 & row < 50) & ~play_again)
			tletter <= 5'd18;
		// E (for now C)
		if((col>=295 & col <345) & leaderboard & (row>= 0 & row < 50) & ~play_again)
			tletter <= 5'd2;	
		// SPACE
		// C
		if((col>=395 & col <445) & leaderboard & (row>= 0 & row < 50) & ~play_again)
			tletter <= 5'd2;
		// P
		if((col>=495 & col <545) & leaderboard & (row>= 0 & row < 50) & ~play_again)
			tletter <= 5'd15;
			
		// play again
		// P
		if((col>=70 & col <120) & (row>= 215 & row < 265) & play_again)
			tletter <= 5'd15;
		// L
		if((col>=120 & col <170) & (row>= 215 & row < 265) & play_again)
			tletter <= 5'd11;
		// A
		if(((col>=170 & col <220) || (col >= 320 & col < 370) || (col >= 420 & col < 470)) & (row>= 215 & row < 265)
				& play_again)
			tletter <= 5'd0;
		// Y
		if((col>=220 & col <270) & (row>= 215 & row < 265) & play_again)
			tletter <= 5'd24;
		// SPACE
		// G
		if((col>=370 & col <420) & (row>= 215 & row < 265) & play_again)
			tletter <= 5'd6;
		// I
		if((col>=470 & col <520) & (row>= 215 & row < 265) & play_again)
			tletter <= 5'd8;
		// N
		if((col>=520 & col <570) & (row>= 215 & row < 265) & play_again)
			tletter <= 5'd13;
			
		// one player
		// o
		if((col>=80 & col <130) & (row>= 0 & row < 50) & select_mode)
			tletter <= 5'd14;
		// N
		if((col>=130 & col <180) & (row>= 0 & row < 50) & select_mode)
			tletter <= 5'd13;
		// E (C)
		if((col>=180 & col <230) & (row>= 0 & row < 50)
				& select_mode)
			tletter <= 5'd2;
		//SPACE
		// W
		if((col>=280 & col <330) & (row>= 0 & row < 50) & select_mode)
			tletter <= 5'd22;
		// I
		if((col>=330 & col <380) & (row>= 0 & row < 50) & select_mode)
			tletter <= 5'd8;
		// Z
		if((col>=380 & col <430) & (row>= 0 & row < 50) & select_mode)
			tletter <= 5'd25;
		// A
		if((col>=430 & col <480) & (row>= 0 & row < 50) & select_mode)
			tletter <= 5'd0;
		// R
		if((col>=480 & col <530) & (row>= 0 & row < 50) & select_mode)
			tletter <= 5'd17;
		// D
		if((col>=530 & col <580) & (row>= 0 & row < 50) & select_mode)
			tletter <= 5'd3;
		
		// learn
		// L
		if((col>=195 & col <245) & (row>= 130 & row < 180) & select_mode)
			tletter <= 5'd11;
		// E
		if((col>=245 & col <295) & (row>= 130 & row < 180) & select_mode)
			tletter <= 5'd2;
		// A
		if((col>=295 & col <345) & (row>= 130 & row < 180) & select_mode)
			tletter <= 5'd0;
		// R
		if((col>=345 & col <395) & (row>= 130 & row < 180) & select_mode)
			tletter <= 5'd17;
		// N
		if((col>=395 & col <445) & (row>= 130 & row < 180) & select_mode)
			tletter <= 5'd13;
		
		// play
		// P
		if((col>=220 & col <270) & (row>= 345 & row < 395) & select_mode)
			tletter <= 5'd15;
		// L
		if((col>=270 & col <320) & (row>= 345 & row < 395) & select_mode)
			tletter <= 5'd11;
		// A
		if((col>=320 & col <370) & (row>= 345 & row < 395) & select_mode)
			tletter <= 5'd0;
		// Y
		if((col>=370 & col <420) & (row>= 345 & row < 395) & select_mode)
			tletter <= 5'd24;
			
//		// welcome to
//		// W
//		if((col>=10 & col <60) & (row>= 10 & row < 60) & logo)
//			tletter <= 5'd22;
//		// E x2
//		if(((col>=60 & col <110) || (col>= 310 & col <= 360)) & (row>= 10 & row < 60) & logo)
//			tletter <= 5'd2;
//		// L
//		if((col>=110 & col <160) & (row>= 10 & row < 60) & logo)
//			tletter <= 5'd11;
//		// C
//		if((col>=160 & col <210) & (row>= 10 & row < 60) & logo)
//			tletter <= 5'd2;
//		// O x2
//		if(((col>=210 & col <260) | (col>=460 & col <510)) & (row>= 10 & row < 60) & logo)
//			tletter <= 5'd14;
//		// M
//		if((col>=260 & col <310) & (row>= 10 & row < 60) & logo)
//			tletter <= 5'd12;
//		// SPACE (360-410)
//		// T
//		if((col>=410 & col <460) & (row>= 10 & row < 60) & logo)
//			tletter <= 5'd2;
//		
//			
//		// wizard
//		// W
//		if((col>=280 & col <330) & (row>= 360 & row < 410) & logo)
//			tletter <= 5'd22;
//		// I
//		if((col>=330 & col <380) & (row>= 360 & row < 410) & logo)
//			tletter <= 5'd8;
//		// Z
//		if((col>=380 & col <430) & (row>= 360 & row < 410) & logo)
//			tletter <= 5'd25;
//		// A
//		if((col>=430 & col <480) & (row>= 360 & row < 410) & logo)
//			tletter <= 5'd0;
//		// R
//		if((col>=480 & col <530) & (row>= 360 & row < 410) & logo)
//			tletter <= 5'd17;
//		// D
//		if((col>=530 & col <580) & (row>= 360 & row < 410) & logo)
//			tletter <= 5'd3;
		
		
	end
	
	assign offset_ADDR = ADDR + tletter*2500;

	letters alphabet(.address(offset_ADDR),
				   	 .clock(~clk),
				   	 .q(letter));

endmodule