module random_trace_generation(RBG, clk, trace, save_trace, CLK_5Hz/*, trace_saved*/);

input RBG, clk;
//input trace_saved;
integer k;
integer trace_count;

output reg [15:0] trace;
output reg save_trace;

output CLK_5Hz;

initial
begin
	k = 0;
	save_trace = 0;
end

freq_div	my_freq_div(.clk_in(clk), .clk_out(CLK_5Hz));


always@(posedge CLK_5Hz & ~save_trace)
	begin
		// reset counter and stop data gathering until trace is saved
		if(k == 16)
		begin
			k = 0;
			trace_count = trace_count + 1;
			save_trace = 1;
		end
		// if row 0
		
		trace[k] <= RBG;
		/*
		else if(k/4==0)
			trace[k] <= RBG;
		// if row 1
		else if (k/4 == 1)
			begin
				if(trace[k-4] == 1 & RBG)
					trace[k] <= 1;
				else if (k != 4 & trace[k-1] == 1 & RBG)
					trace[k] <= 1;
				else
					trace[k] <= 0;
			end
		else if (k/8 == 1)
			begin
				if(trace[k-4] == 1 & RBG)
					trace[k] <= 1;
				else if (k != 8 & trace[k-1] == 1 & RBG)
					trace[k] <= 1;
				else
					trace[k] <= 0;
			end
		else if (k/12 == 1)
			begin
				if(trace[k-4] == 1 & RBG)
					trace[k] <= 1;
				else if (k != 12 & trace[k-1] == 1 & RBG)
					trace[k] <= 1;
				else
					trace[k] <= 0;
			end
		*/
		
		k = k + 1;

	end

endmodule