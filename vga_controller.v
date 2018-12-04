module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 ir_in_p1, ir_in_p2,
							 gryffindor1, slytherin1, hufflepuff1, ravenclaw1,
							 gryffindor2, slytherin2, hufflepuff2, ravenclaw2,
							 two_player_mode,
					  leaderboard, get_ready, times_up, logo,
					  crest_out, crest_index,
					  snitch_powerup, time_turner_powerup, lightning_powerup, broom_powerup,
					  p1_score_ones, p1_score_tens, p1_score_hundreds, p1_score_thousands,
					  end_game_early);

	
input iRST_n;
input iVGA_CLK;

// house customization (player 1 and 2)
input two_player_mode;
input gryffindor1, slytherin1, hufflepuff1, ravenclaw1;
input gryffindor2, slytherin2, hufflepuff2, ravenclaw2;
reg player;
// wand inputs
input[15:0] ir_in_p1, ir_in_p2;
// powerup flag
input snitch_powerup, time_turner_powerup, lightning_powerup, broom_powerup;

// scoring
// scoring
input [4:0] p1_score_ones, p1_score_tens, p1_score_hundreds, p1_score_thousands;
/*******ADDED**********/
// leaderboard inputs
input leaderboard, logo;
/**********************/

/*******ADDED**********/
// change screen input
input get_ready, times_up;
/**********************/

// VGA stuff
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data; 
output end_game_early;

// where am I on the screem                  
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
	

// states
reg in_trace, crest1, crest2 /*, leader_crest*/;

// tracking pixel being updated
reg [8:0] row;
reg [9:0] col;

// what color to output
wire [7:0] color_index, logo_index, file_index;
output [7:0] crest_index;

// global counter
reg [31:0] counter;

// flags for score number display
reg ones, tens, hundreds, thousands;

// element internal counters
reg [12:0] num_pixel;
reg[18:0] in_trace_pixel, crest_pixel/*, leader_crest_pixel*/;
reg [12:0] Gscore_pixel, Sscore_pixel, Hscore_pixel, Rscore_pixel;

// leaderboard stuff
reg Gr, Hr, Rr, Sr;

// sparkles
reg sparkle;
reg [11:0] sparkel_pixel;

always@(posedge iVGA_CLK)
begin
	
	// where am I by row x col
	row <= ADDR / 640;
	col <= ADDR % 640;
	/********** PLAYER SCREEN **********/
	if (col >= 340 & two_player_mode)
		player <= 1'b1;
	else
		player <= 1'b0;
		
	/********** TRACE LOCATION **********/
	if ((row >=40 && row <= 439) && (col >=120 && col <= 519))
		in_trace <= 1'b1;
	else
		in_trace <= 1'b0;
		
	if(in_trace_pixel == 160000)
		in_trace_pixel <= 0;
	
	if(in_trace)
		in_trace_pixel <= in_trace_pixel+1;
	
	/********** HOUSE CREST GAMEPLAY **********/
	// player 1
	if (((row >=10 && row <= 109) && (col >=10 && col <= 109))
		& ~logo & ~leaderboard)
		crest1 <= 1'b1;
	else
		crest1 <= 1'b0;
		
	if((crest1 & ~logo))
		crest_pixel <= crest_pixel + 1;
	
	//	player 2
	if (((row >=10 && row <= 109) && (col >=530 && col <= 629) & two_player_mode)
		& ~logo & ~leaderboard)
		crest2 <= 1'b1;
	else
		crest2 <= 1'b0;
		
	if((crest2 & ~logo))
		crest_pixel <= crest_pixel + 1;
		
	if((row == 10 && col == 530))
		crest_pixel <= 0;
	else if((crest_pixel+1) % 100 == 0)
		crest_pixel <= (row-10)*100;
	/********** 
	GAMEPLAY **********/
	if ((row >=0 && row <30) & ~(leaderboard | get_ready | times_up))
	begin
		//ones digit
		if((col >=610 && col < 640) & ~two_player_mode)
			begin
			ones <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else if((col >=180 && col < 210) & two_player_mode & ~player)
			begin
			ones <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else if((col >=490 && col < 520) & two_player_mode & player)
			begin
			ones <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else 
			ones <= 1'b0;
			
		if((col >=580 && col < 610) & ~two_player_mode)
			begin
			tens <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else if((col >=150 && col < 180) & two_player_mode & ~player)
			begin
			tens <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else if((col >=460 && col < 490) & two_player_mode & player)
			begin
			tens <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else
			tens <= 1'b0;

		if((col >=550 && col < 580) & ~two_player_mode)
			begin
			hundreds <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else if((col >=120 && col < 180) & two_player_mode & ~player)
			begin
			hundreds <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else if((col >=430 && col < 460) & two_player_mode & player)
			begin
			hundreds <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else
			hundreds <= 1'b0;

		if((col >=520 && col < 550) & ~two_player_mode)
			begin
			thousands <= 1'b1;
			num_pixel <= num_pixel + 1;
			end
		else
			thousands <= 1'b0;
	end
	
	// reset score pixel counter
	if((num_pixel+1) % 30 == 0 | logo | col == 520 || col == 550 || col == 580 || col ==610)
		num_pixel <= row*30;
	
	counter <= counter +1;
		
end

wire [7:0] bckgrd_color;
background bckgrd(.G(gryffindor1), .H(hufflepuff1), 
				  .S(slytherin1), .R(ravenclaw1), 
				  .color_index(bckgrd_color), .clk(iVGA_CLK));

/*********PLAYER TRACE**********/
// player 1
wire [7:0] p1_box_color;
wire p1_traced, reset_p2;
wire [15:0] p1_trace;
four_by_four boxp1(.row(row), .col(col),  
						.color_in_box(p1_traced), .box_color(p1_box_color), 
						.clk(iVGA_CLK), .ir_in(ir_in_p1),
						.R(ravenclaw1), .S(slytherin1), .G(gryffindor1), 
						.H(hufflepuff1),
						.already_traced(p1_trace), 
						.broom_powerup(broom_powerup & ~(p1_trace[6] | p2_trace[6])), .two_player_mode(two_player_mode), 
						.reset_other_player_trace(reset_p2), .clear_my_trace(reset_p1), 
						.snitch_location(snitch_location), 
						.reset_trace(((p1_trace & trace_displayed)==trace_displayed) || (((p2_trace & trace_displayed)==trace_displayed) & two_player_mode)),
						.displayed_trace(trace_displayed));
					
// player 2
wire [7:0] p2_box_color;
wire p2_traced, reset_p1;
wire [15:0] p2_trace;
four_by_four boxp2(.row(row), .col(col),  
						.color_in_box(p2_traced), .box_color(p2_box_color), 
						.clk(iVGA_CLK), .ir_in(ir_in_p2),
						.R(ravenclaw2), .S(slytherin2), .G(gryffindor2), 
						.H(hufflepuff2),
						.already_traced(p2_trace), 
						.broom_powerup(broom_powerup & ~(p1_trace[6] | p2_trace[6])), .two_player_mode(two_player_mode), 
						.reset_other_player_trace(reset_p1), .clear_my_trace(reset_p2), 
						.reset_trace(((p2_trace & trace_displayed)==trace_displayed) || ((p1_trace & trace_displayed)==trace_displayed)),
						.displayed_trace(trace_displayed));
				
/*********TRACE DISPLAY**********/
wire trace_color;
display_trace tracez(.row(row), .col(col), .trace(trace_displayed), 
							.trace_color(trace_color), .clk(iVGA_CLK));

wire [15:0] trace_displayed, previous_trace_displayed;	
wire end_game_early, changed_trace;
wire [3:0] trace_count;				
trace_change changez(.trace_to_display(trace_displayed), .clk(iVGA_CLK), 
							.p1_traced(p1_trace), .p2_traced(p2_trace), 
							.trace_screen_on(~logo & ~leaderboard), 
							.end_game_early(end_game_early), .trace_count(trace_count),
							.two_player_mode(two_player_mode));
					 
/*********COLORS**********/
// background color					 
assign color_index = ~in_trace ? bckgrd_color : 8'dz;
// untraced box
assign color_index = in_trace & ~p1_traced & (~p2_traced & two_player_mode) & ~trace_color ? 8'd7 : 8'dz;
// traced box
assign color_index = ~two_player_mode & in_trace &  p1_traced 				    ? p1_box_color : 8'dz;
assign color_index =  two_player_mode & in_trace &  p1_traced & ~p2_traced  & ~leaderboard ? p1_box_color : 8'dz;
assign color_index =  two_player_mode & in_trace & ~p1_traced &  p2_traced  & ~leaderboard ? p2_box_color : 8'dz;
assign color_index =  two_player_mode & in_trace &  p1_traced &  p2_traced  & ~leaderboard ? 8'h10 : 8'dz;
// display trace pattern
assign color_index = in_trace & trace_color & ~p1_traced & ~p2_traced & ~leaderboard ? 8'd40 : 8'dz;

	
/******OPENING SCREEN**********/
opening logoz(
	.address(in_trace_pixel),
	.clock(iVGA_CLK),
	.q(logo_index));
	
/******LEADERBOARD**********/
wire Gl, Hl, Rl, Sl, crestl;
wire [18:0] leader_crest_pixel;
wire [12:0] leaderboard_score_pixel;
wire leader_crest;
wire [2:0] leaderboard_score;
leaderboard ledaerz(.G(Gl), .H(Hl), .R(Rl), .S(Sl), 
						  .row(row), .col(col), .clk(iVGA_CLK), .leaderboard(leaderboard), .logo(logo),
							.crest(leader_crest), .crest_ADDR(leader_crest_pixel), .score(leaderboard_score),
							.score_ADDR(leaderboard_score_pixel));
/**********************/

/*******SPARKLES**********/
wire sparks;
sparkle sparklez(.clk(iVGA_CLK), .row(row), .col(col), .sparkle(sparks),
					  .display_row1(8'd80), .display_col1(9'd90), 
					  .display_row2(8'd10), .display_col2(9'd10));

/*******HOUSE CRESTS**********/
output crest_out;
crest crestz(.clk(iVGA_CLK), .R1(ravenclaw1), .G1(gryffindor1), 
					.S1(slytherin1), .H1(hufflepuff1),
					.R2(ravenclaw2), .G2(gryffindor2), 
					.S2(slytherin2), .H2(hufflepuff2), 
					.Rl(Rl), .Gl(Gl), 
					.Sl(Sl), .Hl(Hl), 
					.player(player),
					.crest_index(crest_index),
					.ADDR(crest_pixel), .crest(crest_out), 
					.leaderboard(leaderboard), .leader_ADDR(leader_crest_pixel));
/*************COUNTDOWN TIMER*************/
wire countdown;
//countdown downz(.row(row), .col(col), .clk(iVGA_CLK), .countdown(countdown), .logo(logo));

/********NUMBERS AND SCORE DISPLAY********/
wire num;
wire [12:0] number_ADDR;
assign number_ADDR = leaderboard ? leaderboard_score_pixel : num_pixel;
wire [3:0] ones_place, tens_place, hundreds_place, thousands_place, ten_thousands_place, hundred_thousands_place;
// gryffindor house points	
assign ones_place 					= leaderboard & row < 140 ? 4'd0 : 4'bz;
assign tens_place 					= leaderboard & row < 140 ? 4'd1 : 4'bz;
assign hundreds_place				= leaderboard & row < 140 ? 4'd0 : 4'bz;
assign thousands_place 				= leaderboard & row < 140 ? 4'd0 : 4'bz;
assign ten_thousands_place 		= leaderboard & row < 140 ? 4'd0 : 4'bz;
assign hundred_thousands_place 	= leaderboard & row < 140 ? 4'd0 : 4'bz;
// slytherin house points
assign ones_place 					= leaderboard & row > 140 & row < 240 ? 4'd0 : 4'bz;
assign tens_place 					= leaderboard & row > 140 & row < 240 ? 4'd7 : 4'bz;
assign hundreds_place				= leaderboard & row > 140 & row < 240 ? 4'd0 : 4'bz;
assign thousands_place 				= leaderboard & row > 140 & row < 240 ? 4'd2 : 4'bz;
assign ten_thousands_place 		= leaderboard & row > 140 & row < 240 ? 4'd0 : 4'bz;
assign hundred_thousands_place 	= leaderboard & row > 140 & row < 240 ? 4'd0 : 4'bz;
// ravenclaw house points
assign ones_place 					= leaderboard & row > 240 & row < 340 ? 4'd1 : 4'bz;
assign tens_place 					= leaderboard & row > 240 & row < 340 ? 4'd3 : 4'bz;
assign hundreds_place				= leaderboard & row > 240 & row < 340 ? 4'd8 : 4'bz;
assign thousands_place 				= leaderboard & row > 240 & row < 340 ? 4'd0 : 4'bz;
assign ten_thousands_place 		= leaderboard & row > 240 & row < 340 ? 4'd3 : 4'bz;
assign hundred_thousands_place 	= leaderboard & row > 240 & row < 340 ? 4'd0 : 4'bz;
// hufflepuff house points
assign ones_place 					= leaderboard & row > 340 ? 4'd0 : 4'bz;
assign tens_place 					= leaderboard & row > 340 ? 4'd5 : 4'bz;
assign hundreds_place				= leaderboard & row > 340 ? 4'd7 : 4'bz;
assign thousands_place 				= leaderboard & row > 340 ? 4'd0 : 4'bz;
assign ten_thousands_place 		= leaderboard & row > 340 ? 4'd8 : 4'bz;
assign hundred_thousands_place 	= leaderboard & row > 340 ? 4'd0 : 4'bz;
// GAMEPLAY SCORE
// player 1
assign ones_place 				= ~leaderboard & ~player ? p1_score_ones : 4'bz;
assign tens_place 				= ~leaderboard & ~player ? p1_score_tens : 4'bz;
assign hundreds_place			= ~leaderboard & ~player ? p1_score_hundreds : 4'bz;
assign thousands_place 			= ~leaderboard & ~player & ~two_player_mode ? p1_score_thousands : 4'bz;
// player 2
assign ones_place 				= ~leaderboard & player ? 4'd5 : 4'bz;
assign tens_place 				= ~leaderboard & player ? 4'd6 : 4'bz;
assign hundreds_place			= ~leaderboard & player ? 4'd7 : 4'bz;

number numz(.ADDR(number_ADDR), 
			.clk(iVGA_CLK), .num(num), 
			.display_ones     (ones_place), 
			.display_tens     (tens_place), 
			.display_hundreds (hundreds_place), 
			.display_thousands(thousands_place), 
			.display_ten_thousands(ten_thousands_place),
			.display_hundred_thousands(hundred_thousands_place),
			.ones(ones | (leaderboard_score == 3'b001)), 
			.tens(tens | (leaderboard_score == 3'b010)), 
			.hundreds(hundreds | (leaderboard_score == 3'b011)), 
			.thousands(thousands | (leaderboard_score == 3'b100)),
			.ten_thousands(leaderboard_score == 3'b101),
			.hundred_thousands(leaderboard_score == 3'b110));

/********POWERUPS********/
// snitch
wire [7:0] snitch_color;
wire snitch_here, snitch_caught;
wire [15:0] snitch_location;
snitch snitchd(.row(row), .col(col), .clk(iVGA_CLK), .in_trace(in_trace), 
					.snitch_color(snitch_color), .snitch(snitch_here), 
					.snitch_powerup(snitch_powerup & ~logo & ~leaderboard & ~snitch_caught & ~two_player_mode), 
					.snitch_location(snitch_location), .ir_in_p1(ir_in_p1), .snitch_caught(snitch_caught));
// broom
wire broom;
broom broomz(.row(row), .col(col), .broom(broom), .clk(iVGA_CLK), 
				 .in_trace(in_trace), .broom_powerup(broom_powerup & ~logo & ~leaderboard && ~(p1_trace[6] | p2_trace[6])));

// time turner
wire time_turner;
time_turner turnz(.row(row), .col(col), .clk(iVGA_CLK), 
						.time_turner(time_turner), .in_trace(in_trace), 
						.time_turner_powerup(time_turner_powerup & ~logo & ~leaderboard));

// lightning						
wire lightning;
lightning boltz(.row(row), .col(col), .clk(iVGA_CLK), 
						.lightning(lightning), .in_trace(in_trace), 
						.lightning_powerup(lightning_powerup & ~logo & ~leaderboard));
/*******LETTERS**********/
wire letter;
letter letterz(.letter(letter), .clk(iVGA_CLK), .row(row), .col(col),
			  	.leaderboard(leaderboard));

/***********MUX IMAGES***************/
// logo
assign file_index = logo ? logo_index : 8'dz;
// crests
assign file_index = (crest1 | crest2 | leader_crest) & crest_out ? crest_index : 8'dz;
// numbers
assign file_index = ~num ? num : 8'dz;
//assign file_index = ~countdown & ~logo & ~leaderboard ? countdown : 8'dz;
// powerups
assign file_index = broom ? 8'b0 : 8'dz;
assign file_index = time_turner ? 8'b0 : 8'dz;
assign file_index = lightning ? 8'b0 : 8'dz;
assign file_index = snitch_here ? snitch_color : 8'dz;
// sparkle
assign file_index = ~sparks & ~leaderboard & ~logo ? sparks : 8'dz;
// letters
assign file_index = ~letter & (leaderboard | get_ready | times_up) ? letter : 8'dz;
// background color / trace
assign file_index = ~logo & ~crest_out & num & ~leaderboard & sparks & ~snitch_here 
								  & ~broom & ~lightning & ~time_turner /*& countdown*/ ? color_index : 8'dz;
// leaderboard
assign file_index = letter & ~leader_crest & leaderboard ? 8'd1 : 8'dz;
/**********************/

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