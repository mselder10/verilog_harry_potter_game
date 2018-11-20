module five_by_five(row, col, color_in_box, box_color, clk, ir_in,
					R, S, G, H);

	input clk;
	input [8:0] row;
	input [9:0] col;
	
	reg color_in;
	input [24:0] ir_in;
	//reg [24:0] //already_traced[;
	
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
		if      ( ~ir_in[0] & //~already_traced[0] &
					row >= 40 & row < 120 & 
					col >= 120 & col < 200)
			begin
			color_in <= 1'b1;
			//already_traced[0] <= 1;
			end
		// box 1
		else if ( ~ir_in[1] & //~already_traced[1] &
					row >= 40 & row < 120 & 
					col >= 200 & col < 280)
			begin
			color_in <= 1'b1;
			//already_traced[1] <= 1;
			end
		// box 2
		else if ( ~ir_in[2] & //~already_traced[2] &
					row >= 40 & row < 120 & 
					col >= 360 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[2] <= 1;
			end
		// box 3
		else if ( ~ir_in[3] & //~already_traced[3] &
					row >= 40 & row < 120 & 
					col >= 420 & col < 500)
			begin
			color_in <= 1'b1;
			//already_traced[3] <= 1;
			end
		// box 4
		else if ( ~ir_in[4] & //~already_traced[4] &
					row >= 40 & row < 120 & 
					col >= 500 & col < 580)
			begin
			color_in <= 1'b1;
			//already_traced[4] <= 1;
			end
	// ROW 1
		// box 5
		if      ( ~ir_in[5] & //~already_traced[5] &
					row >= 120 & row < 200 & 
					col >= 120 & col < 200)
			begin
			color_in <= 1'b1;
			//already_traced[5] <= 1;
			end
		// box 6
		else if ( ~ir_in[6] & //~already_traced[6] &
					row >= 120 & row < 200 & 
					col >= 200 & col < 280)
			begin
			color_in <= 1'b1;
			//already_traced[6] <= 1;
			end
		// box 7
		else if ( ~ir_in[7] & //~already_traced[7] &
					row >= 120 & row < 200 & 
					col >= 360 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[7] <= 1;
			end
		// box 8
		else if ( ~ir_in[8] & //~already_traced[8] &
					row >= 120 & row < 200 & 
					col >= 420 & col < 500)
			begin
			color_in <= 1'b1;
			//already_traced[8] <= 1;
			end
		// box 9
		else if ( ~ir_in[9] & //~already_traced[9] &
					row >= 120 & row < 200 & 
					col >= 500 & col < 580)
			begin
			color_in <= 1'b1;
			//already_traced[9] <= 1;
			end
	// ROW 2
		// box 10
		if      ( ~ir_in[10] & //~already_traced[10] &
					row >= 200 & row < 280 & 
					col >= 120 & col < 200)
			begin
			color_in <= 1'b1;
			//already_traced[10] <= 1;
			end
		// box 11
		else if ( ~ir_in[11] & //~already_traced[11] &
					row >= 200 & row < 280 & 
					col >= 200 & col < 280)
			begin
			color_in <= 1'b1;
			//already_traced[11] <= 1;
			end
		// box 12
		else if ( ~ir_in[12] & //~already_traced[12] &
					row >= 200 & row < 280& 
					col >= 360 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[12] <= 1;
			end
		// box 13
		else if ( ~ir_in[13] & //~already_traced[13] &
					row >= 200 & row < 280 & 
					col >= 420 & col < 500)
			begin
			color_in <= 1'b1;
			//already_traced[13] <= 1;
			end
		// box 14
		else if ( ~ir_in[14] & //~already_traced[14] &
					row >= 200 & row < 280 & 
					col >= 500 & col < 580)
			begin
			color_in <= 1'b1;
			//already_traced[14] <= 1;
			end
	// ROW 3
		// box 15
		if      ( ~ir_in[15] & //~already_traced[15] &
					row >= 280 & row < 360 & 
					col >= 120 & col < 200)
			begin
			color_in <= 1'b1;
			//already_traced[15] <= 1;
			end
		// box 16
		else if ( ~ir_in[16] & //~already_traced[16] &
					row >= 280 & row < 360 & 
					col >= 200 & col < 280)
			begin
			color_in <= 1'b1;
			//already_traced[16] <= 1;
			end
		// box 17
		else if ( ~ir_in[17] & //~already_traced[17] &
					row >= 280 & row < 360 & 
					col >= 360 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[17] <= 1;
			end
		// box 8
		else if ( ~ir_in[18] & //~already_traced[18] &
					row >= 280 & row < 360 & 
					col >= 420 & col < 500)
			begin
			color_in <= 1'b1;
			//already_traced[18] <= 1;
			end
		// box 9
		else if ( ~ir_in[19] & //~already_traced[19] &
					row >= 280 & row < 360 & 
					col >= 500 & col < 580)
			begin
			color_in <= 1'b1;
			//already_traced[19] <= 1;
			end
	// ROW 4
		// box 20
		if      ( ~ir_in[20] & //~already_traced[20] &
					row >= 360 & row < 440 & 
					col >= 120 & col < 200)
			begin
			color_in <= 1'b1;
			//already_traced[20] <= 1;
			end
		// box 21
		else if ( ~ir_in[21] & //~already_traced[21] &
					row >= 360 & row < 440 & 
					col >= 200 & col < 280)
			begin
			color_in <= 1'b1;
			//already_traced[21] <= 1;
			end
		// box 22
		else if ( ~ir_in[22] & //~already_traced[22] &
					row >= 360 & row < 440 & 
					col >= 360 & col < 420)
			begin
			color_in <= 1'b1;
			//already_traced[22] <= 1;
			end
		// box 23
		else if ( ~ir_in[23] & //~already_traced[23] &
					row >= 360 & row < 440 & 
					col >= 420 & col < 500)
			begin
			color_in <= 1'b1;
			//already_traced[23] <= 1;
			end
		// box 24
		else if ( ~ir_in[24] & //~already_traced[24] &
					row >= 360 & row < 440 & 
					col >= 500 & col < 580)
			begin
			color_in <= 1'b1;
			//already_traced[24] <= 1;
			end
	end
	
	assign color_in_box = color_in;
	assign box_color = G ? 8'h49 : 8'bz;
	assign box_color = H ? 8'd15 : 8'hdc;
	assign box_color = S ? 8'h16 : 8'bz;
	assign box_color = R ? 8'h99 : 8'bz;
	assign box_color = ~G & ~R & ~H & ~S ? 8'd0 : 8'bz;

endmodule 
