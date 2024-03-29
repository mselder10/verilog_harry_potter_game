module number(ADDR/*_ones, ADDR_tens, ADDR_hundreds, ADDR_thousands*/, 
clk, num, display_ones, display_tens, display_hundreds, display_thousands, display_ten_thousands,display_hundred_thousands,
ones, tens, hundreds, thousands, ten_thousands, hundred_thousands);

	input clk;
	// position control bits
	input ones, tens, hundreds, thousands, ten_thousands, hundred_thousands;
	// what # to display
	input [3:0] display_ones, display_tens, display_hundreds, display_thousands, display_ten_thousands, display_hundred_thousands;
	// index positions
	input [14:0] ADDR/*_ones, ADDR_tens, ADDR_hundreds, ADDR_thousands*/;

	// decide what place value we are setting
	wire [12:0] offset_ADDR;
	wire [3:0] display_num;
	wire out;
	output num;

	assign display_num = ones ? display_ones : 8'bz;
	assign display_num = tens ? display_tens : 8'bz;
	assign display_num = hundreds ? display_hundreds : 8'bz;
	assign display_num = thousands ? display_thousands : 8'bz;
	assign display_num = ten_thousands ? display_ten_thousands : 8'bz;
	assign display_num = hundred_thousands ? display_hundred_thousands : 8'bz;

	/*assign ADDR = ones ? ADDR_ones : 8'bz;
	assign ADDR = tens ? ADDR_tens : 8'bz;
	assign ADDR = hundreds ? ADDR_hundreds : 8'bz;
	assign ADDR = thousands ? ADDR_thousands : 8'bz;*/

	assign offset_ADDR = ADDR + display_num*900;
	
	numbers numberz(
		.address(offset_ADDR),
		.clock(~clk),
		.q(num));

endmodule 