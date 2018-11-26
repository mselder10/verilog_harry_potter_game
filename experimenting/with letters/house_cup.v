module house_cup(clk, pixel, letter, row, col, leaderboard);
	
	input clk, leaderboard;
	input [8:0] row;
	input [9:0] col;

	reg [4:0] display_letter;
	reg [12:0] house_cup_pixel;

	output [4:0] letter;
	output [12:0] pixel;


	always @(posedge clk)
	begin
		if((row >= 0 && row <50) && leaderboard)
		begin
			// H
			if(col>=95 && col < 145)
				display_letter <= 5'd7;

			// O
			if(col>=145 && col < 195)
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

			// pixel counter
			if(house_cup_pixel % 50 == 0)
				house_cup_pixel <= row*50;
			else
				house_cup_pixel <= times_up_pixel + 1;
		end
	end

	assign pixel = house_cup_pixel;
	assign letter = display_letter;

endmodule
