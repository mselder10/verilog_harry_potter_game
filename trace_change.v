module trace_change(trace_to_display, clk, p1_traced, p2_traced, trace_screen_on, 
							end_game_early, trace_count, two_player_mode, TRACE_GEN, random_bit_pin);
	
	input trace_screen_on, clk, two_player_mode, random_bit_pin, TRACE_GEN;
	input [15:0] p1_traced, p2_traced;
	
	output reg [5:0] trace_count;
	reg [15:0] trace0, trace1, trace2, trace3, trace4;
	
	output [15:0] trace_to_display;
	output reg end_game_early;
	reg [15:0] trace_on_screen;
	reg [15:0] random_trace_reg;
	
	initial begin
		trace_count <= 0;
		trace_on_screen <= 16'h0231;
		end_game_early <= 0;
//		trace1 <= 16'h0075;
//		trace2 <= 16'h8ca9;	
//		trace3 <= 16'h8f23;
//		trace4 <= 16'hd9be;
	end
	
	wire save_trace;
	wire [15:0] random_trace;
	random_trace_generation randomz(.RBG(random_bit_pin), .clk(clk), 
												.trace(random_trace), .save_trace(save_trace) /*, trace_saved*/);
	always@(posedge clk & TRACE_GEN & ~trace_screen_on)
	begin
	
		if(save_trace)
			random_trace_reg <= random_trace;
		
	end
	
	assign trace_to_display = TRACE_GEN & save_trace ? random_trace_reg : trace_on_screen;
	
	always@(posedge clk & trace_screen_on & ~TRACE_GEN)
	begin
		// if user trace and trace display are the same, change the trace displayed
		if((p1_traced & trace_to_display)==trace_to_display || (((p2_traced & trace_to_display)==trace_to_display) & two_player_mode))
		begin
			trace_count = trace_count + 1;
			if(trace_count == 1)
			begin
				//previous_trace_displayed <= trace_to_display;
				/*trace_to_display*/ trace_on_screen <= trace1;
			end
			else if (trace_count == 2)
			begin
				//previous_trace_displayed <= trace_to_display;
				/*trace_to_display*/ trace_on_screen <= trace2;
			end
			else if (trace_count == 3)
			begin
				//previous_trace_displayed <= trace_to_display;
				/*trace_to_display*/ trace_on_screen <= trace3;
			end
			else if (trace_count == 4)
			begin
				//previous_trace_displayed <= trace_to_display;
				/*trace_to_display*/ trace_on_screen <= trace4;
			end
			else if (trace_count == 5)
			begin
				trace_count <= 0;
				end_game_early <= 1;
			end
		end
		
	end

endmodule 