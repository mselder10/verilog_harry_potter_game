module letter(letter, clk, row, col,
			  leaderboard, play_again);
	
	input clk, leaderboard, play_again;
	input [8:0] row;
	input [9:0] col;

	wire [4:0] get_ready_letter, times_up_letter, house_cup_letter;
	wire [4:0] display_letter;

	wire [4:0] get_ready_ADDR, times_up_ADDR, house_cup_ADDR;
	reg [12:0] ADDR;
	wire [15:0] offset_ADDR;

	output letter;


	// find letter offset in mif file
	reg [4:0]  tletter;
	always @(posedge clk)
	begin
		if(((row>= 0 & row < 50) & ((col>=95 & col < 345) || (col>=395 & col < 545))) & leaderboard)
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
		
		// house cup
		// H
		if((col>=95 & col <145) & (row>= 0 & row < 50) & leaderboard)
			tletter <= 5'd7;
		// O
		if((col>=145 & col <195) & (row>= 0 & row < 50) & leaderboard)
			tletter <= 5'd14;
		// U
		if(((col>=195 & col <245) || (col>=445 & col <495)) & (row>= 0 & row < 50) & leaderboard)
			tletter <= 5'd20;
		// S
		if((col>=245 & col <295) & leaderboard & (row>= 0 & row < 50))
			tletter <= 5'd18;
		// E (for now C)
		if((col>=295 & col <345) & leaderboard & (row>= 0 & row < 50))
			tletter <= 5'd2;	
		// SPACE
		// C
		if((col>=395 & col <445) & leaderboard & (row>= 0 & row < 50))
			tletter <= 5'd2;
		// P
		if((col>=495 & col <545) & leaderboard & (row>= 0 & row < 50))
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
		
	end
	
	assign offset_ADDR = ADDR + tletter*2500;

	letters alphabet(.address(offset_ADDR),
				   	 .clock(~clk),
				   	 .q(letter));

endmodule