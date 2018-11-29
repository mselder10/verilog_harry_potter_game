module message_letter(letter, clk, row, col,
			  get_ready, times_up);
			  
	input clk, get_ready, times_up;
	input [8:0] row;
	input [9:0] col;
	
	reg [12:0] ADDR;
	wire [15:0] offset_ADDR;
	reg [4:0]  tletter;
	
	output letter;
	
	always @(posedge clk)
	begin
		if((row>= 190 & row < 240) & ((col>=170 & col < 370)) & get_ready)
			begin
				ADDR <= ADDR + 1;
				if(row == 190 & col == 170)
					ADDR <= 0;
				else if(((ADDR) % 50) == 0)
					ADDR <= (row%190)*50;
			end
		// wand
		// W
		if((col>=170 & col <220) & (row>= 190 & row < 240) & get_ready)
			tletter <= 5'd22;
		// A
		if((col>=220 & col <270) & (row>= 190 & row < 240) & get_ready)
			tletter <= 5'd0;
		// N
		if((col>=270 & col <320) & (row>= 190 & row < 240) & get_ready)
			tletter <= 5'd13;
		// D
		if((col>=320 & col <370) & (row>= 190 & row < 240) & get_ready)
			tletter <= 5'd3;
	end
	
	assign offset_ADDR = ADDR + tletter*2500;
	
	letters alphabet(.address(offset_ADDR),
				   	 .clock(~clk),
				   	 .q(letter));
			  
endmodule 