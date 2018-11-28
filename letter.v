module letter(letter, clk, row, col,
			  get_ready, times_up, leaderboard);
	
	input clk, get_ready, times_up, leaderboard;
	input [8:0] row;
	input [9:0] col;

	wire [4:0] get_ready_letter, times_up_letter, house_cup_letter;
	wire [4:0] display_letter;

	wire [4:0] get_ready_ADDR, times_up_ADDR, house_cup_ADDR;
	reg [12:0] ADDR;
	wire [15:0] offset_ADDR;

	output letter;

	// get ready logic
	/*get_ready 	readyz(.row(row), .col(col), .clk(clk),
					   .letter(get_ready_letter), .pixel(get_ready_ADDR));

	time_is_up 	timez(.row(row), .col(col), .clk(clk), 
					  .letter(times_up_letter), .pixel(times_up_ADDR));*/

	/*house_cup 	cupz( .row(row), .col(col), .clk(clk), .leaderboard(leaderboard),
				   	  .letter(house_cup_letter), .pixel(house_cup_ADDR));*/

	// what to display
	/*assign display_letter = get_ready 	 ? get_ready_letter : 5'dz;
	assign display_letter = times_up  	 ? times_up_letter  : 5'dz;*/
	//assign display_letter = leaderboard  ? house_cup_letter : 5'dz;

	/*assign ADDR = get_ready 	 ? get_ready_ADDR : 12'dz;
	assign ADDR = times_up  	 ? times_up_ADDR  : 12'dz;
	assign ADDR = leaderboard   ? house_cup_ADDR : 12'dz;*/

	// find letter offset in mif file
	reg [4:0]  tletter;
	always @(posedge clk)
	begin
		if((row>= 0 & row < 50) & ((col>=95 & col < 345) || (col>=395 & col < 545)))
			begin
				ADDR <= ADDR + 1;
				if(((ADDR+1) % 50) == 0)
					ADDR <= row*50;
			end
		
		// H
		if((col>=95 & col <145) & leaderboard)
			tletter <= 5'd7;
		// O
		if((col>=145 & col <195) & leaderboard)
			tletter <= 5'd14;
		// U
		if(((col>=195 & col <245) || (col>=445 & col <495)) & leaderboard)
			tletter <= 5'd20;
		// S
		if((col>=245 & col <295) & leaderboard)
			tletter <= 5'd18;
		// E (for now A)
		if((col>=295 & col <345) & leaderboard)
			tletter <= 5'd25;	
		// SPACE
		// C
		if((col>=395 & col <445) & leaderboard)
			tletter <= 5'd2;
		// P
		if((col>=495 & col <545) & leaderboard)
			tletter <= 5'd15;
		
	end
	
	//assign tletter = (col>=95 & col <145) ? 5'd7 : 5'dz;
	//assign tletter = (col>=145 & col <195) ? 5'd14 : 5'dz;
	//assign tletter = (col>=220 & col <270) ? 5'd4 : 5'dz;
	
	assign offset_ADDR = ADDR + tletter*2500;

	letters alphabet(.address(offset_ADDR),
				   	 .clock(~clk),
				   	 .q(letter));

endmodule