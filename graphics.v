module graphics(resetn, 
	VGA_CLK,   														//	VGA Clock
	VGA_HS,															//	VGA H_SYNC
	VGA_VS,															//	VGA V_SYNC
	VGA_BLANK,														//	VGA BLANK
	VGA_SYNC,														//	VGA SYNC
	VGA_R,   														//	VGA Red[9:0]
	VGA_G,	 														//	VGA Green[9:0]
	VGA_B,															//	VGA Blue[9:0]
	CLOCK_50,  														// 50 MHz clock
	ir_in_p1, ir_in_p2,												// ir_reciever readings
	G1, S1, H1, R1,												// house color control player 1
	G2, S2, H2, R2,												// house color control player 2
	two_player_mode,												// dual mode
	leaderboard, get_ready, times_up);
		
	////////////////////////	VGA	////////////////////////////
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	input				CLOCK_50;
	input 			G2, S2, H2, R2;				// house color controls player 2
	input 			G1, S1, H1, R1;				// house color controls player 1
	input				two_player_mode;				// two players
	input [15:0] ir_in_p1, ir_in_p2;						// ir readings for player 1 and 2

	////////////////////////	PS2	////////////////////////////
	input 			resetn;

	////////////////////////	Controls (sent from processor)	////////////////////////////
	input leaderboard, get_ready, times_up;
	wire			 clock;
	
	// clock divider (by 5, i.e., 10 MHz)
	pll div(CLOCK_50,inclock);
	assign clock = CLOCK_50;
	
	wire [1:0] screen;
	wire [31:0] seconds;
	wire EOG;
	wire [31:0] score_player1, score_player2, score_player3, score_player4;
	wire [31:0] data_readReg1, data_readReg2, data_readReg3, data_readReg4;
	wire [2:0] powerUp1, powerUp2, powerUp3, powerUp4;
	wire scoreOption1, scoreOption2, scoreOption3, scoreOption4;
	wire inTrace1, inTrace2, inTrace3, inTrace4;
	///////////////////// Screen Timer ////////////////////////////////////////
	screenTimer timez(.clock(clock), .total_screens(4'd4), .curr_screen(screen), 
							.time_out(seconds), .end_of_game(EOG));
							
							
	////////////////////// Processor /////////////////////////////////////////
   skeleton processor(clock, resetn, score_player1, score_player2, score_player3, score_player4, data_readReg1, data_readReg2,
	data_readReg3, data_readReg4);	
	
	
	/////////////////////// Score Calculation //////////////////////////////
	scoreCalc s1(clock, ir_in_p1[0], 1'b1, 1'b0,  1'b0, score_player1);
	scoreCalc s2(inTrace, scoreOption2, powerUp2, score_player2);
	scoreCalc s3(inTrace, scoreOption3, powerUp3, score_player3);
	scoreCalc s4(inTrace, scoreOption4, powerUp4, score_player4);
	
	wire [31:0] digit0, digit1, digit2, digit3, digit4, digit5;
	scoreToDigits convert(clock, score_player1, digit0, digit1, digit2, digit3, digit4, digit5);
	
	// some LEDs that you could use for debugging if you wanted
	assign leds = 8'b00101011;
		
	// VGA
	wire end_game_early;
	Reset_Delay			r0	(.iCLK(CLOCK_50),.oRESET(DLY_RST)	);
	VGA_Audio_PLL 		p1	(.areset(~DLY_RST),.inclk0(CLOCK_50),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);
	vga_controller vga_ins(.iRST_n(DLY_RST),
								 .iVGA_CLK(VGA_CLK),
								 .oBLANK_n(VGA_BLANK),
								 .oHS(VGA_HS),
								 .oVS(VGA_VS),
								 .b_data(VGA_B),
								 .g_data(VGA_G),
								 .r_data(VGA_R),
								 .ir_in_p1(ir_in_p1),
								 .ir_in_p2(ir_in_p2),
								 .gryffindor1(G1),
								 .slytherin1(S1),
								 .hufflepuff1(H1),
								 .ravenclaw1(R1),
								 .p1_score_ones(4'd7),
								 .p1_score_tens(4'd1),
								 .p1_score_hundreds(4'd6),
								 .p1_score_thousands(4'd9),
								 .two_player_mode(two_player_mode),
								 .gryffindor2(G2),
								 .slytherin2(S2),
								 .hufflepuff2(H2),
								 .ravenclaw2(R2),
								 .snitch_powerup(1'b1),
								 .time_turner_powerup(1'b0), 
								 .lightning_powerup(1'b0), 
								 .broom_powerup(1'b1),
								 .leaderboard(EOG | end_game_early), 
								 .get_ready(1'b0), .times_up(1'b0),
								 .logo(screen[0]),
								 .end_game_early(end_game_early)
								 );
	
	
endmodule
