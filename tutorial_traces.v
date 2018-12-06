module tutorial_traces(learn_mode, trace_to_display, clk, p1_traced, trace_screen_on, end_game_early, trace_count);
	
	input trace_screen_on, clk, learn_mode;
	input [15:0] p1_traced;
	
	output reg [5:0] trace_count;
	reg [15:0] trace0, trace1, trace2, trace3, trace4;
	
	output reg [15:0] trace_to_display;
	output reg end_game_early;
	
	initial begin
		trace_count <= 0;
		trace_to_display <= 16'b0000011001100000; // (in excel 2)
		end_game_early <= 0;
		trace1 <= 16'b1111100110011111; // (in excel 1)
		trace2 <= 16'b0000110011001111; // (in excel 3)
		trace3 <= 16'b1110001000110111; // (in excel 5)
		trace4 <= 16'b0001001101100100; // (in excel 9)
	end
	
	always@(posedge clk & trace_screen_on & learn_mode)
	begin
		// if user trace and trace display are the same, change the trace displayed
		if((p1_traced & trace_to_display)==trace_to_display)
		begin
			trace_count = trace_count + 1;
			if(trace_count == 1)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace1;
			end
			else if (trace_count == 2)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace2;
			end
			else if (trace_count == 3)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace3;
			end
			else if (trace_count == 4)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace4;
			end
			else if (trace_count == 5)
			begin
				trace_count <= 0;
				end_game_early <= 1;
			end
		end
		
	end

endmodule 