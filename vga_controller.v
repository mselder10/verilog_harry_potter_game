module vga_controller(i_rst,
                      clk,
                      oBLANK_n,
                      o_hs,
                      o_vs,
                      b_data,
                      g_data,
                      r_data,
							 gryffindor, slytherin, hufflepuff, ravenclaw);

	
input i_rst;
input clk;
input gryffindor, slytherin, hufflepuff, ravenclaw;
output reg oBLANK_n;
output reg o_hs;
output reg o_vs;
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
assign rst = ~i_rst;
video_sync_generator LTM_ins (.vga_clk(clk),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge clk,negedge i_rst)
begin
  if (!i_rst)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end


//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~clk;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
	
/////////////////////////
//////Add switch-input logic here
reg [7:0] color_index;
reg [18:0] count;
reg in_trace;
reg [8:0] row;
reg [9:0] col;

always@(posedge clk)
begin

	row <= ADDR / 640;
	col <= ADDR % 640;
  if ((row >=40 && row <= 439) && (col >=120 && col <= 519))
		in_trace <= 1'b1;
  else
		in_trace <= 1'b0;
	
  // if not in trace set background color
  if(in_trace == 1'b0 && slytherin)
		color_index <= 8'd0;
  else if (in_trace == 1'b0 && gryffindor)
		color_index <= 8'd1;
  else if (in_trace == 1'b0 && hufflepuff)
		color_index <= 8'd2;
  else if (in_trace == 1'b0 && ravenclaw)
		color_index <= 8'd3;
  else if (in_trace == 1'b1)
		color_index <= 8'd4;
  else 
		color_index <= 8'd4;
end

//////Color table output
img_index	img_index_inst (
	.address ( color_index ),
	.clock ( clk ),
	.q ( bgr_data_raw)
	);	

//////latch valid data at falling edge;
always@(posedge VGA_CLK_n) bgr_data <= bgr_data_raw;
assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0]; 
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge clk)
begin
  o_hs<=cHS;
  o_vs<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule
 	















