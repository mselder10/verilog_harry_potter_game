module display_trace(row, col, trace, trace_color, clk);

	input clk;
	input [8:0] row;
	input [9:0] col;
	input [15:0] trace;
	
	output reg trace_color;

	always@(posedge clk)
	begin
	// ROW 0
		// box 0
		if      (row >= 40 & row < 140 & 
					col >= 120 & col < 220)
			begin
				trace_color <= trace[0];
			end
		// box 1
		else if (row >= 40 & row < 140 & 
					col >= 220 & col < 320)
			begin
				trace_color <= trace[1];
			end
		// box 2
		else if (row >= 40 & row < 140 & 
					col >= 320 & col < 420)
			begin
				trace_color <= trace[2];
			end
		// box 3
		else if (row >= 40 & row < 140 & 
					col >= 420 & col < 520)
			begin
				trace_color <= trace[3];
			end
	// ROW 1
		// box 4
		else if  (row >= 140 & row < 240 & 
					col >= 120 & col < 220)
			begin
				trace_color <= trace[4];
			end
		// box 5
		else if (row >= 140 & row < 240 & 
					col >= 220 & col < 320)
			begin
				trace_color <= trace[5];
			end
		// box 6
		else if (row >= 140 & row < 240 & 
					col >= 320 & col < 420)
			begin
				trace_color <= trace[6];
			end
		// box 7
		else if (row >= 140 & row < 240 & 
					col >= 420 & col < 520)
			begin
				trace_color <= trace[7];
			end
	// ROW 2
		// box 8
		else if  (row >= 240 & row < 340 & 
					col >= 120 & col < 220)
			begin
				trace_color <= trace[8];
			end
		// box 9
		else if (row >= 240 & row < 340 & 
					col >= 220 & col < 320)
			begin
				trace_color <= trace[9];
			end
		// box 10
		else if (row >= 240 & row < 340 & 
					col >= 320 & col < 420)
			begin
				trace_color <= trace[10];
			end
		// box 11
		else if (row >= 240 & row < 340 & 
					col >= 420 & col < 520)
			begin
				trace_color <= trace[11];
			end
	// ROW 3
		// box 12
		else if  (row >= 340 & row < 440 & 
					col >= 120 & col < 220)
			begin
				trace_color <= trace[12];
			end
		// box 13
		else if (row >= 340 & row < 440 & 
					col >= 220 & col < 320)
			begin
				trace_color <= trace[13];
			end
		// box 14
		else if (row >= 340 & row < 440 & 
					col >= 320 & col < 420)
			begin
				trace_color <= trace[14];
			end
		// box 15
		else if (row >= 340 & row < 440 & 
					col >= 420 & col < 520)
			begin
				trace_color <= trace[15];
			end
		else 
			trace_color <= 1'b0;
			
	end
	
endmodule 