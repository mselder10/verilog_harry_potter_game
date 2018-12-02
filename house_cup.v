module house_cup(clk, pixel, letter, row, col, leaderboard);
	
	input clk, leaderboard;
	input [8:0] row;
	input [9:0] col;

	reg [4:0] display_letter;
	reg [12:0] house_cup_pixel;

	output [4:0] letter;
	output [12:0] pixel;

	assign letter = (col>=95  && col < 145) & leaderboard ? 5'd7 : 5'bz;
	assign letter = (col>=145 && col < 195) & leaderboard ? 5'd14 : 5'bz;
	assign letter = (col>=195 && col < 245) & leaderboard ? 5'd20 : 5'bz;
	assign letter = (col>=245 && col < 295) & leaderboard ? 5'd18 : 5'bz;
	assign letter = (col>=295 && col < 345) & leaderboard ? 5'd4 : 5'bz;
	
	always@(posedge clk)
	begin
		if((row>= 0 & row < 50) & (col>=95 & col <345))
			begin
				house_cup_pixel <= house_cup_pixel + 1;
				if(((house_cup_pixel+1) % 50) == 0)
					house_cup_pixel <= row*50;
			end
	end
	
	assign pixel = house_cup_pixel;
	/*always @(posedge clk)
	begin
		if((row >= 0 && row <50) && leaderboard)
		begin
			// H
			if(col>=95 && col < 145)
				display_letter <= 5'd7;

			// O
			/*if(col>=145 && col < 195)
				display_letter <= 5'd14;

			// U
			if(col>=195 && col < 245)
				display_letter <= 5'd20;

			// S
			if(col>=245 && col < 295)
				display_letter <= 5'd18;

			// E
			if(col>=295 && col < 345)
				display_letter <= 5'd4;

			// SPACE

			// C
			if(col>=395 && col < 445)
				display_letter <= 5'd2;

			// U
			if(col>=445 && col < 495)
				display_letter <= 5'd20;

			// P
			if(col>=495 && col < 545)
				display_letter <= 5'd20;
			
			house_cup_pixel <= house_cup_pixel + 1;
			// pixel counter
			if(((house_cup_pixel+1) % 50) == 0)
					house_cup_pixel <= row*50;

		end*/
	//end

endmodule