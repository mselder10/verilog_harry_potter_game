module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 ir_in,
							 gryffindor, slytherin, hufflepuff, ravenclaw,
							 up, down, left, right);

	
input iRST_n;
input iVGA_CLK;
input gryffindor, slytherin, hufflepuff, ravenclaw;
input up, down, left, right;
input[24:0] ir_in;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [7:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
	
/////////////////////////
//////Add switch-input logic here

reg in_trace, crest, logo, OPENINGSCREEN;
// tracking pixel being updated
reg [8:0] row;
reg [9:0] col;
// tracking where user cursor is
reg [8:0] cursor_row;
reg [9:0] cursor_col;
// what color to output
wire [7:0] color_index, crest_index, logo_index, file_index;
reg [31:0] counter;
reg ones, tens, hundreds, thousands;
// element internal counters
reg [12:0] num_pixel_ones, num_pixel_tens, num_pixel_hundreds, num_pixel_thousands;
reg[18:0] in_trace_pixel, crest_pixel;

always@(posedge iVGA_CLK)
begin
	
	// where am I?
	row <= ADDR / 640;
	col <= ADDR % 640;
	
	// logic for trace location
	if ((row >=40 && row <= 439) && (col >=120 && col <= 519))
		in_trace <= 1'b1;
	else
		in_trace <= 1'b0;
		
	if(in_trace_pixel == 160000)
		in_trace_pixel <= 0;
	
	if(in_trace)
		in_trace_pixel <= in_trace_pixel+1;
	
	// logic for crest location 
	if ((row >=10 && row <= 109) && (col >=10 && col <= 109) & ~logo)
		crest <= 1'b1;
	else
		crest <= 1'b0;
		
	if(crest & ~logo)
		crest_pixel <= crest_pixel + 1;
	
	if(crest_pixel == 9999 | logo)
		crest_pixel <= 0;
		
	// logic for numbers
	// ones digit
	if ((row >=0 && row <30))
	begin
		//ones digit
		if((col >=610 && col < 640))
			begin
			ones <= 1'b1;
			num_pixel_ones <= num_pixel_ones + 1;
			end
		else 
			ones <= 1'b0;
			
		if((col >=580 && col < 610))
			begin
			tens <= 1'b1;
			num_pixel_tens <= num_pixel_tens + 1;
			end
		else
			tens <= 1'b0;

		if((col >=550 && col < 580))
			begin
			hundreds <= 1'b1;
			num_pixel_hundreds <= num_pixel_hundreds + 1;
			end
		else
			hundreds <= 1'b0;

		if((col >=520 && col < 550))
			begin
			thousands <= 1'b1;
			num_pixel_thousands <= num_pixel_thousands + 1;
			end
		else
			thousands <= 1'b0;
	end
	
	if(num_pixel_ones == 899 | logo)
		num_pixel_ones <= 0;
	if(num_pixel_tens == 899 | logo)
		num_pixel_tens <= 0;
	if(num_pixel_hundreds == 899 | logo)
		num_pixel_hundreds <= 0;
	if(num_pixel_thousands == 899 | logo)
		num_pixel_thousands <= 0;
	
	// counter for opening screen (will be moved to processor)
	if(counter < 250000000)
		logo <= 1'b0;
	else
		logo <= 1'b0;
	
	counter <= counter +1;

//  if (cursor_here == 1)
//  begin
//		cursor_row <= row;
//		cursor_col <= col;
//  end
		
end

wire [7:0] bckgrd_color;
background bckgrd(.G(gryffindor), .H(hufflepuff), 
							.S(slytherin), .R(ravenclaw), 
							.color_index(bckgrd_color), .clk(iVGA_CLK));

wire [7:0] cursor_color;
wire cursor_here, sparkle_here;					
cursor	  crsr(.row(row), .col(col), .cursor_here(cursor_here), 
					 .color_index(cursor_color), .clk(iVGA_CLK),
					 .up(up), .down(down), .left(left), .right(right),
					 .sparkle_here(sparkle_here));

wire [7:0] fade_color;
wire fade;		 
//fade_block block(.row(row), .col(col), .clk(iVGA_CLK), .here(fade), .color(fade_color));

wire [7:0] box_color;
wire traced;
/*two_by_two boxz(.row(row), .col(col), 
					 .cursor_row(cursor_row), .cursor_col(cursor_col), 
					 .in_trace(in_trace), .color_in_box(color_in_box), 
					 .box_color(box_color), .clk(iVGA_CLK));*/
					 
four_by_four boxz(.row(row), .col(col),  
						.color_in_box(traced), .box_color(box_color), 
						.clk(iVGA_CLK), .ir_in(ir_in),
						.R(ravenclaw), .S(slytherin), .G(gryffindor), 
						.H(hufflepuff));

/*five_by_five boxz(.row(row), .col(col), .color_in_box(traced), 
					.box_color(box_color), .clk(iVGA_CLK), .ir_in(ir_in),
					.R(ravenclaw), .S(slytherin), .G(gryffindor), 
					.H(hufflepuff));*/
					 

// background color					 
assign color_index = ~in_trace & ~fade ? bckgrd_color : 8'dz;
// cursor location
assign color_index = in_trace & cursor_here /*& ~sparkle_here*/ ? cursor_color : 8'dz;
// traced box
assign color_index = in_trace & traced & ~cursor_here /*& ~sparkle_here*/ ? box_color : 8'dz;
// sparkle effect
//assign color_index = sparkle_here ? 8'd5 : 8'dz;
assign color_index = fade & ~in_trace ? fade_color : 8'dz;
// otherwise
//assign color_index = ~cursor_here & ~traced /*& ~sparkle_here*/ ? 8'd0 : 8'dz;

	
// instantiate logo ROM
opening logoz(
	.address(in_trace_pixel),
	.clock(iVGA_CLK),
	.q(logo_index));

// instantiate crest ROM
wire crest_out;
crest crestz(.clk(iVGA_CLK), .R(ravenclaw), .G(gryffindor), 
					.S(slytherin), .H(hufflepuff), .crest_index(crest_index), 
					.ADDR(crest_pixel), .crest(crest_out));

// instantiate numbers ROM
wire num;
number numz(.ADDR_ones(num_pixel_ones), 
			.ADDR_tens(num_pixel_tens), 
			.ADDR_hundreds(num_pixel_hundreds), 
			.ADDR_thousands(num_pixel_thousands), 
			.clk(iVGA_CLK), .num(num), 
			.display_ones     (4'd8), 
			.display_tens     (4'd0), 
			.display_hundreds (4'd0), 
			.display_thousands(4'd0), 
			.ones(ones), 
			.tens(tens), 
			.hundreds(hundreds), 
			.thousands(thousands));
	
assign file_index = logo ? logo_index : 8'dz;
assign file_index = crest & crest_out ? crest_index : 8'dz;
assign file_index = ~num ? num : 8'dz;
assign file_index = ~logo & ~crest_out & num ? color_index : 8'dz;

//////Color table output
img_index	img_index_inst (
	.address ( file_index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
////

//////latch valid data at falling edge;
always@(posedge VGA_CLK_n) bgr_data <= bgr_data_raw;
assign r_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign b_data = bgr_data[7:0]; 
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule 