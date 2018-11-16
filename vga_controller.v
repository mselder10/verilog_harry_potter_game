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
input[15:0] ir_in;
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
reg[18:0] in_trace_pixel, crest_pixel;
reg [31:0] counter;

always@(posedge iVGA_CLK)
begin

	row <= ADDR / 640;
	col <= ADDR % 640;
	
	
  if ((row >=40 && row <= 439) && (col >=120 && col <= 519))
		in_trace <= 1'b1;
  else
		in_trace <= 1'b0;
		
	if ((row >=9 && row <= 108) && (col >=9 && col <= 108) & ~logo)
		crest <= 1'b1;
	else
		crest <= 1'b0;
		
	if(crest)
		crest_pixel <= crest_pixel + 1;
	
	if(crest_pixel == 9999)
		crest_pixel <= 0;
		
	if(in_trace_pixel == 160000)
		in_trace_pixel <= 0;
	
	if(in_trace)
		in_trace_pixel <= in_trace_pixel+1;
		
	if(counter < 5000000000)
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
						.clk(iVGA_CLK), .ir_in(ir_in));
					 

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

	

hogwarts_logo logoz(
	.address(in_trace_pixel),
	.clock(iVGA_CLK),
	.q(logo_index));
	
//crests crestz(
//	.address(crest_pixel),
//	.clock(iVGA_CLK),
//	.q(crest_index));

crests crestz(.clk(iVGA_CLK), .R(ravenclaw), .G(gryffindor), 
					.S(slytherin), .H(hufflepuff), .crest_index(crest_index), 
					.ADDR(crest_pixel));
	
assign file_index = logo ? logo_index : 8'dz;
assign file_index = crest ? crest_index : 8'dz;
assign file_index = ~logo & ~crest ? color_index : 8'dz;

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