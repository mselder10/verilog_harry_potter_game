module letter(letter, clk, row, col,
			  leaderboard);
	
	input clk, leaderboard;
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
		// E (for now A)
		if((col>=295 & col <345) & leaderboard & (row>= 0 & row < 50))
			tletter <= 5'd13;	
		// SPACE
		// C
		if((col>=395 & col <445) & leaderboard & (row>= 0 & row < 50))
			tletter <= 5'd2;
		// P
		if((col>=495 & col <545) & leaderboard & (row>= 0 & row < 50))
			tletter <= 5'd15;
		
	end
	
	assign offset_ADDR = ADDR + tletter*2500;

	letters alphabet(.address(offset_ADDR),
				   	 .clock(~clk),
				   	 .q(letter));

endmodule