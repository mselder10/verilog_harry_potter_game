module letter(letter, clk, row, col,
			  get_ready, times_up, leaderboard);
	
	input clk, get_ready, times_up, leaderboard;
	input [8:0] row;
	input [9:0] col;

	wire [4:0] get_ready_letter, times_up_letter, house_cup_letter;
	wire [4:0] display_letter;

	wire [4:0] get_ready_ADDR, times_up_ADDR, house_cup_ADDR;
	reg [12:0] ADDR, ADDR2;
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

		if((row>= 190 & row < 240) & ((col>=170 & col < 370)))
			begin
				ADDR <= ADDR + 1;
				if(((ADDR) % 50) == 0)
					ADDR <= (row-190)*50;
			end

		if((row>= 240 & row < 290) & ((col>=220 & col < 320)))
			begin
				ADDR <= ADDR + 1;
				if(((ADDR) % 50) == 0)
					ADDR <= (row-240)*50;
			end
		
		// house cup
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

		// wand
		// W
		if((col>=170 & col <220) & (row>= 190 & row < 240) & get_ready)
			tletter <= 5'd22;
		// A
		if((col>=220 & col <270) & (row>= 190 & row < 240) & get_ready)
			tletter <= 5'd0;
		// N
		if(((col>=270 & col <320) & (row>= 190 & row < 240) & get_ready)
			tletter <= 5'd13;
		// D
		if((col>=320 & col <370) & (row>= 190 & row < 240) & get_ready)
			tletter <= 5'd3;
		
		// up
		// U
		if((col>=220 & col <345) & (row>= 240 & row < 290) & (get_ready|times_up))
			tletter <= 5'd20;	
		// P
		if((col>=495 & col <545) & (row>= 240 & row < 290) & (get_ready|times_up))
			tletter <= 5'd15;

		// time
		// T
		if((col>=170 & col <220) & (row>= 190 & row < 240) & times_up)
			tletter <= 5'd19;
		// I
		if((col>=220 & col <270) & (row>= 190 & row < 240) & times_up)
			tletter <= 5'd8;
		// M
		if(((col>=270 & col <320) & (row>= 190 & row < 240) & times_up)
			tletter <= 5'd12;
		// E
		if((col>=320 & col <370) & (row>= 190 & row < 240) & times_up)
			tletter <= 5'd3;
		
	end

	assign offset_ADDR = ADDR + tletter*2500;

	letters alphabet(.address(offset_ADDR),
				   	 .clock(~clk),
				   	 .q(letter));

endmodule
