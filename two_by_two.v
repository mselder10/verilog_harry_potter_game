module two_by_two(row, col, cursor_row, cursor_col, in_trace, color_in_box, box_color, clk);

	input in_trace, clk;
	input [8:0] cursor_row;
	input [9:0] cursor_col;
	input [8:0] row;
	input [9:0] col;
	
	reg color_in;
	reg [3:0] box;
	
	output color_in_box;
	output [7:0] box_color;
	
	always@(posedge clk)
	begin
		// is cursor in box 0
		if		 (in_trace &
				  cursor_row < 240 & cursor_col < 320)
			box[0] <= 1'b1;
		// is cursor in box 1
		else if(in_trace &
				  cursor_row < 240 & cursor_col >= 320)
			box[1] <= 1'b1;
		// is cursor in box 2
		else if(in_trace &
				  cursor_row >= 239 & cursor_col < 320)
			box[2] <= 1'b1;
		// is cursor in box 3
		else if(in_trace &
				  cursor_row >= 239 & cursor_col >= 320)
			box[3] <= 1'b1;
		
		if      (box[0] & row < 240 & col < 320)
			color_in <= 1'b1;
		else if (box[1] & row < 240 & col >= 320)
			color_in <= 1'b1;
		else if (box[2] & row >= 239 & col < 320)
			color_in <= 1'b1;
		else if (box[3] & row >= 239 & col >= 320)
			color_in <= 1'b1;
		else
			color_in <= 1'b0;
			
			
	end
	
	assign color_in_box = color_in;
	assign box_cursor_color = 8'd6;

endmodule 