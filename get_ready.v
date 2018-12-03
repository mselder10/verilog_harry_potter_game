module get_ready(row, col, letter, clk, pixel);
	
	input clk;
	input [8:0] row;
	input [9:0] col;

	reg [4:0] display_letter;
	reg [12:0] get_ready_pixel;

	output [12:0] pixel;
	output [4:0] letter;

	always @(posedge clk)
	begin
		// ROW 1
		if((row>=190 & row <240))
		begin
			// G
			if (col>=170 & col<220)
				display_letter <= 5'd6;

			// E
			if((col>=220 & col<270))
				display_letter <= 5'd4;

			// T
			if((col>=270 & col<320))
				display_letter <= 5'd19;

			// pixel counter
			if((get_ready_pixel+1) % 50 == 0)
				get_ready_pixel <= (row%190)*50;
			else
				get_ready_pixel <= get_ready_pixel + 1;
		end

		
		if((row>=240 & row <290))
		begin
			// R
			if((col>=170 & col<220))
				display_letter <= 5'd17;

			// E
			if((col>=220 & col<270))
				display_letter <= 5'd17;

			// A
			if((col>=270 & col<320))
				display_letter <= 5'd1;

			// D
			if((col>=320 & col<370))
				display_letter <= 5'd3;

			// Y
			if((row>=240 & row <290) && (col>=370 & col<420))
				display_letter <= 5'd24;

			// pixel counter
			if((get_ready_pixel+1) % 50 == 0)
				get_ready_pixel <= (row%240)*50;
			else
				get_ready_pixel <= get_ready_pixel + 1;
		end

	end

	assign pixel = get_ready_pixel;
	assign letter = display_letter;

endmodule