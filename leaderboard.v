module leaderboard(G, H, R, S, row, col, clk, leaderboard, crest, crest_ADDR, logo, score, score_ADDR/*, 
	 one, ten, hundred, thousand, tthousand, hthousand, ones_val, tens_val, hundreds_val, thousands_val, tthousands_val, hthousands_val,*/
	 /*pixel, G_HP, R_HP, H_HP, S_HP*/);
	
	input clk, leaderboard, logo;
	//input [24:0] G_HP, R_HP, H_HP, S_HP;
	input [8:0] row;
	input [9:0] col;

	reg Gr, Hr, Rr, Sr, leader_crest;
	reg [2:0] scores;
	reg [18:0] leader_crest_pixel;
	reg [12:0] gryffindor_house_score_pixel, slytherin_house_score_pixel, ravenclaw_house_score_pixel, hufflepuff_house_score_pixel;
	
	output G, H, R, S;
	output crest;
	output [2:0] score;
	output [18:0] crest_ADDR;
	output [12:0] score_ADDR;
	
	// assign outputs
	assign G = Gr;
	assign H = Hr;
	assign S = Sr;
	assign R = Rr;
	assign crest = leader_crest;
	assign crest_ADDR = leader_crest_pixel;
	assign score_ADDR = (row>= 75 & row < 105)  ? gryffindor_house_score_pixel : 12'bz;
	assign score_ADDR = (row>= 175 & row < 205) ? slytherin_house_score_pixel  : 12'bz;
	assign score_ADDR = (row>= 275 & row < 305) ? ravenclaw_house_score_pixel  : 12'bz;
	assign score_ADDR = (row>= 375 & row < 405) ? hufflepuff_house_score_pixel  : 12'bz;
	assign score = scores;

	always@(posedge clk)
	begin
	
	// crests
	if(leaderboard & (col >=120 && col < 220) & (row >=40 & row < 440))
		leader_crest <= 1'b1;
	else 
		leader_crest <= 1'b0;
		
	if((leader_crest & ~logo))
		leader_crest_pixel <= leader_crest_pixel + 1;
	
	if((col == 120) & (row == 40 | row == 140 | row == 240 | row == 340))
		leader_crest_pixel <= 0;
	
	if (~leaderboard)
		begin
			Gr <= 1'b0;
			Hr <= 1'b0;
			Sr <= 1'b0;
			Rr <= 1'b0;
		end
	if (leaderboard & (row >=40 && row < 140))
		begin
			Gr <= 1'b1;
			Hr <= 1'b0;
			Sr <= 1'b0;
			Rr <= 1'b0;
		end
	if (leaderboard & (row >=140 && row < 240))
		begin
			Sr <= 1'b1;
			Gr <= 1'b0;
			Hr <= 1'b0;
			Rr <= 1'b0;
		end
	if (leaderboard & (row >=240 && row < 340))
		begin
			Rr <= 1'b1;
			Gr <= 1'b0;
			Hr <= 1'b0;
			Sr <= 1'b0;
		end
	if (leaderboard & (row >=340 && row < 440))
		begin
			Hr <= 1'b1;
			Gr <= 1'b0;
			Sr <= 1'b0;
			Rr <= 1'b0;
		end
		
	// scores
	//gryffindor
	if((row>= 75 & row < 105) & leaderboard)
	begin
		if (col>=280 & col < 310) // hundred thousands
			begin
				scores <= 3'b110; //
				gryffindor_house_score_pixel <= gryffindor_house_score_pixel + 1;
				if((((gryffindor_house_score_pixel+1) % 30) == 0) || col == 280)
					gryffindor_house_score_pixel <= (row%75)*30;
			end
		if (col>=310 & col < 340) // ten thousands
			begin
				scores <= 3'b101; //
				gryffindor_house_score_pixel <= gryffindor_house_score_pixel + 1;
				if((((gryffindor_house_score_pixel+1) % 30) == 0) || col == 310)
					gryffindor_house_score_pixel <= (row%75)*30;
			end
		if (col>=340 & col < 370) // thousands
			begin
				scores <= 3'b100; //
				gryffindor_house_score_pixel <= gryffindor_house_score_pixel + 1;
				if((((gryffindor_house_score_pixel+1) % 30) == 0) || col == 340)
					gryffindor_house_score_pixel <= (row%75)*30;
			end
		if (col>=370 & col < 400)
			begin 
				scores <= 3'b011; // hundreds
				gryffindor_house_score_pixel <= gryffindor_house_score_pixel + 1;
				if((((gryffindor_house_score_pixel+1) % 30) == 0) || col == 370)
					gryffindor_house_score_pixel <= (row%75)*30;
			end
		if (col>=400 & col < 430) // tens
			begin 
				scores <= 3'b010;
				gryffindor_house_score_pixel <= gryffindor_house_score_pixel + 1;
				if((((gryffindor_house_score_pixel+1) % 30) == 0) || col == 400)
					gryffindor_house_score_pixel <= (row%75)*30;
			end
		if (col>=430 & col < 460) // ones
			begin 
				scores <= 3'b001;
				gryffindor_house_score_pixel <= gryffindor_house_score_pixel + 1;
				if((((gryffindor_house_score_pixel+1) % 30) == 0) || col == 430)
					gryffindor_house_score_pixel <= (row%75)*30;
			end
	end
	else if((row>= 175 & row < 205) & leaderboard)
	begin
		if (col>=280 & col < 310) // hundred thousands
			begin
				scores <= 3'b110; //
				slytherin_house_score_pixel <= slytherin_house_score_pixel + 1;
				if((((slytherin_house_score_pixel+1) % 30) == 0 || col == 280))
					slytherin_house_score_pixel <= (row%175)*30;
			end
		if (col>=310 & col < 340) // ten thousands
			begin
				scores <= 3'b101; //
				slytherin_house_score_pixel <= slytherin_house_score_pixel + 1;
				if((((slytherin_house_score_pixel+1) % 30) == 0 || col == 310))
					slytherin_house_score_pixel <= (row%175)*30;
			end
		if (col>=340 & col < 370) // thousands
			begin
				scores <= 3'b100; //
				slytherin_house_score_pixel <= slytherin_house_score_pixel + 1;
				if((((slytherin_house_score_pixel+1) % 30) == 0 || col == 340))
					slytherin_house_score_pixel <= (row%175)*30;
			end
		if (col>=370 & col < 400)
			begin 
				scores <= 3'b011; // hundreds
				slytherin_house_score_pixel <= slytherin_house_score_pixel + 1;
				if((((slytherin_house_score_pixel+1) % 30) == 0 || col == 370))
					slytherin_house_score_pixel <= (row%175)*30;
			end
		if (col>=400 & col < 430) // tens
			begin 
				scores <= 3'b010;
				slytherin_house_score_pixel <= slytherin_house_score_pixel + 1;
				if((((slytherin_house_score_pixel+1) % 30) == 0 || col == 400))
					slytherin_house_score_pixel <= (row%175)*30;
			end
		if (col>=430 & col < 460) // ones
			begin 
				scores <= 3'b001;
				slytherin_house_score_pixel <= slytherin_house_score_pixel + 1;
				if((((slytherin_house_score_pixel+1) % 30) == 0 || col == 430))
					slytherin_house_score_pixel <= (row%175)*30;
			end
	end
	else if((row>= 275 & row < 305) & leaderboard)
	begin
		if (col>=280 & col < 310) // hundred thousands
			begin
				scores <= 3'b110; //
				ravenclaw_house_score_pixel <= ravenclaw_house_score_pixel + 1;
				if((((ravenclaw_house_score_pixel+1) % 30) == 0) || col == 280)
					ravenclaw_house_score_pixel <= (row%275)*30;
			end
		if (col>=310 & col < 340) // ten thousands
			begin
				scores <= 3'b101; //
				ravenclaw_house_score_pixel <= ravenclaw_house_score_pixel + 1;
				if((((ravenclaw_house_score_pixel+1) % 30) == 0) || col == 310)
					ravenclaw_house_score_pixel <= (row%275)*30;
			end
		if (col>=340 & col < 370) // thousands
			begin
				scores <= 3'b100; //
				ravenclaw_house_score_pixel <= ravenclaw_house_score_pixel + 1;
				if((((ravenclaw_house_score_pixel+1) % 30) == 0) || col == 340)
					ravenclaw_house_score_pixel <= (row%275)*30;
			end
		if (col>=370 & col < 400)
			begin 
				scores <= 3'b011; // hundreds
				ravenclaw_house_score_pixel <= ravenclaw_house_score_pixel + 1;
				if((((ravenclaw_house_score_pixel+1) % 30) == 0) || col == 370)
					ravenclaw_house_score_pixel <= (row%275)*30;
			end
		if (col>=400 & col < 430) // tens
			begin 
				scores <= 3'b010;
				ravenclaw_house_score_pixel <= ravenclaw_house_score_pixel + 1;
				if((((ravenclaw_house_score_pixel+1) % 30) == 0) || col == 400)
					ravenclaw_house_score_pixel <= (row%275)*30;
			end
		if (col>=430 & col < 460) // ones
			begin 
				scores <= 3'b001;
				ravenclaw_house_score_pixel <= ravenclaw_house_score_pixel + 1;
				if((((ravenclaw_house_score_pixel+1) % 30) == 0) || col == 430)
					ravenclaw_house_score_pixel <= (row%275)*30;
			end
	end
	else if((row>= 375 & row < 405) & leaderboard)
	begin
		if (col>=280 & col < 310) // hundred thousands
			begin
				scores <= 3'b110; //
				hufflepuff_house_score_pixel <= hufflepuff_house_score_pixel + 1;
				if((((hufflepuff_house_score_pixel+1) % 30) == 0) || col == 280)
					hufflepuff_house_score_pixel <= (row%375)*30;
			end
		if (col>=310 & col < 340) // ten thousands
			begin
				scores <= 3'b101; //
				hufflepuff_house_score_pixel <= hufflepuff_house_score_pixel + 1;
				if((((hufflepuff_house_score_pixel+1) % 30) == 0) || col == 310)
					hufflepuff_house_score_pixel <= (row%375)*30;
			end
		if (col>=340 & col < 370) // thousands
			begin
				scores <= 3'b100; //
				hufflepuff_house_score_pixel <= hufflepuff_house_score_pixel + 1;
				if((((hufflepuff_house_score_pixel+1) % 30) == 0) || col == 340)
					hufflepuff_house_score_pixel <= (row%375)*30;
			end
		if (col>=370 & col < 400)
			begin 
				scores <= 3'b011; // hundreds
				hufflepuff_house_score_pixel <= hufflepuff_house_score_pixel + 1;
				if((((hufflepuff_house_score_pixel+1) % 30) == 0) || col == 370)
					hufflepuff_house_score_pixel <= (row%375)*30;
			end
		if (col>=400 & col < 430) // tens
			begin 
				scores <= 3'b010;
				hufflepuff_house_score_pixel <= hufflepuff_house_score_pixel + 1;
				if((((hufflepuff_house_score_pixel+1) % 30) == 0) || col == 400)
					hufflepuff_house_score_pixel <= (row%375)*30;
			end
		if (col>=430 & col < 460) // ones
			begin 
				scores <= 3'b001;
				hufflepuff_house_score_pixel <= hufflepuff_house_score_pixel + 1;
				if((((hufflepuff_house_score_pixel+1) % 30) == 0) || col == 430)
					hufflepuff_house_score_pixel <= (row%375)*30;
			end
	end
	else
		scores <= 3'b0;
	end
	
endmodule