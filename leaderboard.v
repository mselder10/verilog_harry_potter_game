module leaderboard(G, H, R, S, row, col, clk, leaderboard, crest, crest_ADDR, logo/*, 
	 one, ten, hundred, thousand, tthousand, hthousand, ones_val, tens_val, hundreds_val, thousands_val, tthousands_val, hthousands_val,*/
	 /*pixel, G_HP, R_HP, H_HP, S_HP*/);
	
	input clk, leaderboard, logo;
	//input [24:0] G_HP, R_HP, H_HP, S_HP;
	input [8:0] row;
	input [9:0] col;

	reg Gr, Hr, Rr, Sr, leader_crest;
	reg [18:0] leader_crest_pixel;
	
	output G, H, R, S;
	output crest;
	output [18:0] crest_ADDR;
	// assign outputs
	assign G = Gr;
	assign H = Hr;
	assign S = Sr;
	assign R = Rr;
	assign crest = leader_crest;
	assign crest_ADDR = leader_crest_pixel;

	always@(posedge clk)
	begin

	if(leaderboard & (col >=120 && col < 220) & (row >=40 & row < 440) & leaderboard)
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
	end
	
endmodule