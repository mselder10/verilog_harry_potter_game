module number(ADDR, clk, display_num, num);

	input clk;
	input [3:0] display_num;
	input [14:0] ADDR;
	wire [12:0] offset_ADDR;
	wire out;
	output num;
	
	assign offset_ADDR = ADDR + display_num*900;
	
	numbers numberz(
		.address(offset_ADDR),
		.clock(clk),
		.q(num));

endmodule 