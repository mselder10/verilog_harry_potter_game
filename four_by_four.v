module four_by_four(row, col, color_in_box, box_color, clk, ir_in, R, S, G, H);

	input clk, R, S, G, H;
	input [8:0] row;
	input [9:0] col;
	
	reg color_in;
	input [15:0] ir_in;
	//reg [15:0] //already_traced[;
	
	output color_in_box;
	output [7:0] box_color;
	reg [31:0] counter;
	
	/*initial
	begin
		//already_traced[ <= 16'd0;
	end*/
	
	always@(posedge clk)
	begin
	// ROW 0
		// box 0
		if      ( ir_in[0] & //~already_traced[0] &
					row >= 40 & row < 140 & 
					col >= 120 & col < 220)
			begin
			color_in <= 1'b1;
			//already_traced[0] <= 1;
			end
		// box 1
		else if ( ir_in[1] & //~already_traced[1] &
					row >= 40 & row < 140 & 
					col >= 220 & col < 320)
			begin
			color_in <= 1'b1;
			//already_traced[1] <= 1;
			end
		// box 2
		else if ( ir_in[2] & //~already_traced[2] &
					row >= 40 & row < 140 & 
					col >= 320 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[2] <= 1;
			end
		// box 3
		else if ( ir_in[3] & //~already_traced[3] &
					row >= 40 & row < 140 & 
					col >= 420 & col < 520)
			begin
			color_in <= 1'b1;
			//already_traced[3] <= 1;
			end
	// ROW 1
		// box 4
		else if  ( ir_in[4] & //~already_traced[4] &
					row >= 140 & row < 240 & 
					col >= 120 & col < 220)
			begin
			color_in <= 1'b1;
			//already_traced[4] <= 1;
			end
		// box 5
		else if ( ir_in[5] & //~already_traced[5] &
					row >= 140 & row < 240 & 
					col >= 220 & col < 320)
			begin
			color_in <= 1'b1;
			//already_traced[5] <= 1;
			end
		// box 6
		else if ( ir_in[6] & //~already_traced[6] &
					row >= 140 & row < 240 & 
					col >= 320 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[6] <= 1;
			end
		// box 7
		else if ( ir_in[7] & //~already_traced[7] &
					row >= 140 & row < 240 & 
					col >= 420 & col < 520)
			begin
			color_in <= 1'b1;
			//already_traced[7] <= 1;
			end
	// ROW 2
		// box 8
		else if  ( ir_in[8] & //~already_traced[8] &
					row >= 240 & row < 340 & 
					col >= 120 & col < 220)
			begin
			color_in <= 1'b1;
			//already_traced[8] <= 1;
			end
		// box 9
		else if ( ir_in[9] & //~already_traced[9]  &
					row >= 240 & row < 340 & 
					col >= 220 & col < 320)
			begin
			color_in <= 1'b1;
			//already_traced[9] <= 1;
			end
		// box 10
		else if ( ir_in[10] & //~already_traced[10] &
					row >= 240 & row < 340 & 
					col >= 320 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[10] <= 1;
			end
		// box 11
		else if ( ir_in[11] & //~already_traced[11] &
					row >= 240 & row < 340 & 
					col >= 420 & col < 520)
			begin
			color_in <= 1'b1;
			//already_traced[11] <= 1;
			end
	// ROW 3
		// box 12
		else if  ( ir_in[12] & //~already_traced[12] &
					row >= 340 & row < 440 & 
					col >= 120 & col < 220)
			begin
			color_in <= 1'b1;
			//already_traced[12] <= 1;
			end
		// box 13
		else if ( ir_in[13] & //~already_traced[13] &
					row >= 340 & row < 440 & 
					col >= 220 & col < 320)
			begin
			color_in <= 1'b1;
			//already_traced[13] <= 1;
			end
		// box 14
		else if ( ir_in[14] & //~already_traced[14] &
					row >= 340 & row < 440 & 
					col >= 320 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[14] <= 1;
			end
		// box 15
		else if ( ir_in[15] & //~already_traced[15] &
					row >= 340 & row < 440 & 
					col >= 420 & col < 520)
			begin
			color_in <= 1'b1;
			//already_traced[15] <= 1;
			end
		else 
			color_in <= 1'b0;
	end
	
	assign color_in_box = color_in;
	assign box_color = G ? 8'h49 : 8'bz;
	assign box_color = H ? 8'hdc : 8'bz;
	assign box_color = S ? 8'h16 : 8'bz;
	assign box_color = R ? 8'h99 : 8'bz;
	assign box_color = ~G & ~R & ~H & ~S ? 8'd0 : 8'bz;

endmodule 