module countdown(row, col, countdown, clk, logo, counter, seconds_left);

	input clk, logo;
	input [8:0] row;
	input [9:0] col;
	output reg [3:0] seconds_left;
	reg [18:0] ADDR;
	output reg [31:0] counter;
	wire [31:0] offset_ADDR;
	output countdown;
	
	assign offset_ADDR = ADDR + seconds_left*900;
	
	numbers numberz(
		.address(offset_ADDR),
		.clock(~clk),
		.q(countdown));
		
	initial
	begin
		seconds_left <= 8;
	end
	
	always @(posedge clk & ~logo)
	begin

		if((row == 390 & col == 565) || ADDR == 899)
			ADDR <= 0;
		else if((row >= 410 & row < 440) & (col >= 565 & col < 595))
			ADDR <= ADDR + 1;	
		
		if(counter >= 50000000 & seconds_left != 0)
		begin
			counter <= 0;
			seconds_left <= seconds_left - 1;
		end
		else
			counter <= counter + 1;
			
	end


endmodule 