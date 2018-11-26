module house_points(score, leaderboard, clk, ones, tens, hundreds, thousands, tthousands, hthousands);
	
	input leaderboard;
	input [24:0] score;

	output [4:0] ones, tens, hundreds, thousands, tthousands, hthousands;

	always@(posedge clk)
	begin
	if(~leaderboard)
		begin
			hthousands <= score/100000;
			tthousands <= (score-hthousands*100000)/10000;
			thousands <= (score-hthousands*100000-tthousands*10000)/1000;
			hundreds <= (score-hthousands*100000-tthousands*10000-thousands*1000)/100;
			tens <= (score-hthousands*100000-tthousands*10000-thousands*1000-hundreds*100)/10;
			ones <= (score-hthousands*100000-tthousands*10000-thousands*1000-hundreds*100-tens*10);
		end
	end

endmodule