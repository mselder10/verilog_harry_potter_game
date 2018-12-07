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
	leaderboard,  
	learn_mode
	);
		
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
	input leaderboard;
	input learn_mode;
	wire			 clock;
	
	// clock divider (by 5, i.e., 10 MHz)
	pll div(CLOCK_50,inclock);
	assign clock = CLOCK_50;
	
	wire [1:0] screen;
	wire [31:0] seconds;
	wire EOG;
	wire [31:0] score_player1, score_player2, score_player3, score_player4;
	wire [31:0] score_playerp1, score_playerp2, score_playerp3, score_playerp4;
	wire [31:0] data_readReg1, data_readReg2, data_readReg3, data_readReg4;
	wire [2:0] powerUp1, powerUp2, powerUp3, powerUp4;
	wire scoreOption1, scoreOption2, scoreOption3, scoreOption4;
	wire inTrace1, inTrace2, inTrace3, inTrace4;
	wire play_again, select_mode, logo, snitch_powerup;
	wire [15:0] current_trace;
	///////////////////// Screen Timer ////////////////////////////////////////
	screenTimer timez(.clock(clock), .total_screens(4'd4), .curr_screen(screen), 
							.time_out(seconds), .end_of_game(EOG), .play_again(play_again),
							.selected_a_mode(selected_a_mode), .select_mode_screen(select_mode), 
							.logo(logo), .end_game_early(end_game_early), .end_tutorial(end_tutorial),
							.two_player_mode(two_player_mode), .snitch_powerup(snitch_powerup), .random(data_readReg5), .time_turner_on(time_turner_on));
							
							
	////////////////////// Processor /////////////////////////////////////////
   skeleton processor(clock, resetn, score_player1, score_player2, score_player3, score_player4, data_readReg1, data_readReg2,
	data_readReg3, data_readReg4, data_readReg5);	
	
	//player one readsG1, 2 S1, 3 H1,4 R1,
	/////////////////////// Score Calculation //////////////////////////////
	scoreCalc s1(clock, ir_in_p1, snitch_caught, time_turner_caught, score_player1);
   scoreCalc s2(clock, ir_in_p2, snitch_caught, time_turner_caught, score_player2);
//	scoreCalc s3(clock, ir_in_p1, snitch_caught, time_turner_caught, score_playerp3);
//	scoreCalc s4(clock, ir_in_p1, snitch_caught, time_turner_caught, score_playerp4);
	
	wire [31:0] digit0, digit1, digit2, digit3, digit4, digit5;
	wire [31:0] digitp0, digitp1, digitp2, digitp3, digitp4, digitp5;
	wire [31:0] digitg0, digitg1, digitg2, digitg3, digitg4, digitg5;
	wire [31:0] digith0, digith1, digith2, digith3, digith4, digith5;
	
   wire [31:0] digits0, digits1, digits2, digits3, digits4, digits5;
	wire [31:0] digitps0, digitps1, digitps2, digitps3, digitps4, digitps5;
	
   scoreToDigits convertp(clock,  score_player1, digits0, digits1, digits2, digits3, digits4, digits5);
	scoreToDigits convertp2(clock, score_player2, digitps0, digitps1, digitps2, digitps3, digitps4, digitps5);
    
	scoreToDigits convert(clock,  score_playerp1, digit0, digit1, digit2, digit3, digit4, digit5);
	scoreToDigits convert1(clock, score_playerp2, digitp0, digitp1, digitp2, digitp3, digitp4, digitp5);
	scoreToDigits convert2(clock, score_playerp3, digitg0, digitg1, digitg2, digitg3, digitg4, digitg5);
	scoreToDigits convert3(clock, score_playerp4, digith0, digith1, digith2, digith3, digith4, digith5);
	///PLAYER 1////
	mytri32 py1(.in(data_readReg1), .enable(G1), .out(score_playerp1));
	mytri32 py2(.in(data_readReg1), .enable(S1), .out(score_playerp2));
	mytri32 py3(.in(data_readReg1), .enable(H1), .out(score_playerp3));
	mytri32 py4(.in(data_readReg1), .enable(R1), .out(score_playerp4));
	///PLAYER 2////
	mytri32 py21(.in(data_readReg5), .enable(G1), .out(score_playerp1));
	mytri32 py22(.in(data_readReg5), .enable(S1), .out(score_playerp2));
	mytri32 py23(.in(data_readReg5), .enable(H1), .out(score_playerp3));
	mytri32 py24(.in(data_readReg5), .enable(R1), .out(score_playerp4));
//	// some LEDs that you could use for debugging if you wanted
	assign leds = 8'b00101011;
		
	// VGA
	wire end_game_early, end_tutorial, snitch_caught, time_turner_caught, time_turner_on;
	wire selected_a_mode;
	Reset_Delay			r0	(.iCLK(CLOCK_50),.oRESET(DLY_RST)	);
	VGA_Audio_PLL 		p1	(.areset(~DLY_RST),.inclk0(CLOCK_50),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);
	vga_controller vga_ins(
								 /*******VGA STUFF*******/
								 .iRST_n(DLY_RST),
								 .iVGA_CLK(VGA_CLK),
								 .oBLANK_n(VGA_BLANK),
								 .oHS(VGA_HS),
								 .oVS(VGA_VS),
								 .b_data(VGA_B),
								 .g_data(VGA_G),
								 .r_data(VGA_R),
								 /******IR READINGS******/
								 .ir_in_p1(ir_in_p1),
								 .ir_in_p2(ir_in_p2),
								 /*******PLAYER 1 HOUSE COLOR*******/
								 .gryffindor1(G1),
								 .slytherin1(S1),
								 .hufflepuff1(H1),
								 .ravenclaw1(R1),
								 /*****PLAYER 1 SCORE******/
								 .p1_score_ones(digits0),
								 .p1_score_tens(digits1),
								 .p1_score_hundreds(digits2),
								 .p1_score_thousands(digits3),
								 /*****PLAYER 2 SCORE******/
								 .p2_score_ones(digitps0),
								 .p2_score_tens(digitps1),
								 .p2_score_hundreds(digitps2),
								 .two_player_mode(two_player_mode),
								 /*****RAVENCLAW HOUSE SCORE*****/
								 .ravenclaw_score_ones(digitg0), 
								 .ravenclaw_score_tens(digitg1), 
								 .ravenclaw_score_hundreds(digitg2), 
								 .ravenclaw_score_thousands(digitg3),
								 /*****GRYFFINDOR HOUSE SCORE********/
								 .gryffindor_score_ones(digit0), 
								 .gryffindor_score_tens(digit1), 
								 .gryffindor_score_hundreds(digit2), 
								 .gryffindor_score_thousands(digit4),
								 /*****HUFFLEPUFF HOUSE SCORE********/
								 .hufflepuff_score_ones(digitp0), 
								 .hufflepuff_score_tens(digitp1), 
								 .hufflepuff_score_hundreds(digitp2), 
								 .hufflepuff_score_thousands(digitp3),
								/*****SLYTHERIN HOUSE SCORE********/
								 .slytherin_score_ones(digith0), 
								 .slytherin_score_tens(digith1), 
								 .slytherin_score_hundreds(digith2), 
								 .slytherin_score_thousands(digith3),
								/*******PLAYER 2 HOUSE COLOR*******/
								 .gryffindor2(G2),
								 .slytherin2(S2),
								 .hufflepuff2(H2),
								 .ravenclaw2(R2),
								 /*******POWERUPS*******/
								 .snitch_powerup(snitch_powerup),
								 .time_turner_powerup(time_turner_on), 
								 .lightning_powerup(1'b0), 
								 .broom_powerup(1'b1),
								 .snitch_caught(snitch_caught),
								 .time_turner_caught(time_turner_caught),
								 /*******CHANGING SCREENS*******/
								 .leaderboard(EOG | end_game_early), 
								 .play_again(play_again), 
								 .select_mode(select_mode),
								 .selected_a_mode(selected_a_mode),
								 .logo(logo),
								 /*******ENDING GAME EARLY*******/
								 .end_game_early(end_game_early),
								 .end_tutorial(end_tutorial),
								 .gameplay_trace(current_trace)
								 );
	
	
endmodule
