module number(ADDR, clk, num, display_ones, display_tens, display_hundreds, display_thousands, display_tthousands, display_hthousands, tthousands, hthousands, ones, tens, hundreds, thousands);

	input clk;
	// position control bits
	input ones, tens, hundreds, thousands;
	// what # to display
	input [3:0] display_ones, display_tens, display_hundreds, display_thousands, display_tthousands, display_hthousands;
	// index positions
	input [12:0] ADDR;

	// decide what place value we are setting
	wire [12:0] ADDR, offset_ADDR;
	wire [3:0] display_num;
	wire out;
	output num;

	assign display_num = ones ? display_ones : 8'bz;
	assign display_num = tens ? display_tens : 8'bz;
	assign display_num = hundreds ? display_hundreds : 8'bz;
	assign display_num = thousands ? display_thousands : 8'bz;
	assign display_num = tthousands ? display_tthousands : 8'bz;
	assign display_num = hthousands ? display_hthousands : 8'bz;

	assign offset_ADDR = ADDR + display_num*900;
	
	numbers numberz(
		.address(offset_ADDR),
		.clock(~clk),
		.q(num));

endmodule