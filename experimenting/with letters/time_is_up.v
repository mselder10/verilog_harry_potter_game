module time_is_up(row, col, letter, pixel, clk);

	input [8:0] row;
	input [9:0] col;

	reg [4:0] display_letter;
	reg [12:0] times_up_pixel;

	output [4:0] letter;
	output [12:0] pixel;

	always @(posedge clk)
	begin
		// ROW 1
		if((row>=190 & row <240))
		begin
			// T
			if (col>=170 & col<220)
				display_letter <= 5'd19;

			// I
			if((col>=220 & col<270))
				display_letter <= 5'd8;

			// M
			if((col>=270 & col<320))
				display_letter <= 5'd12;

			// E
			if((col>=320 & col<370))
				display_letter <= 5'd4;

			// pixel counter
			if(times_up_pixel % 50 == 0)
				times_up_pixel <= (row%190)*50;
			else
				times_up_pixel <= times_up_pixel + 1;
		end

		// ROW 2
		if((row>=240 & row <290))
		begin
			// I
			if((col>=220 & col<270))
				display_letter <= 5'd8;

			// S
			if((col>=270 & col<320))
				display_letter <= 5'd18;

			// pixel counter
			if(times_up_pixel % 50 == 0)
				times_up_pixel <= (row%240)*50;
			else
				times_up_pixel <= times_up_pixel + 1;
		end

		// ROW 3
		if((row>=290 & row <340))
		begin
			// U
			if((col>=220 & col<270))
				display_letter <= 5'd20;

			// P
			if((col>=270 & col<320))
				display_letter <= 5'd15;

			// pixel counter
			if(times_up_pixel % 50 == 0)
				times_up_pixel <= (row%290)*50;
			else
				times_up_pixel <= times_up_pixel + 1;
		end


	end

	assign pixel = times_up_pixel;
	assign letter = display_letter;

endmodule