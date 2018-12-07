module trace_change(trace_to_display, clk, p1_traced, p2_traced, trace_screen_on, end_game_early, trace_count, previous_trace_displayed, two_player_mode);
	
	input trace_screen_on, clk, two_player_mode;
	input [15:0] p1_traced, p2_traced;
	
	output reg [5:0] trace_count;
	reg [15:0] trace0, trace1, trace2, trace3, trace4, trace5, trace6, trace7, trace8, trace9,
					trace10, trace11, trace12, trace13, trace14, trace15, trace16, trace17, trace18, trace19,
					trace20, trace21, trace22, trace23, trace24, trace25, trace26, trace27, trace28, trace29;
	
	output reg [15:0] trace_to_display, previous_trace_displayed;
	output reg end_game_early;
	
	initial begin
		trace_count <= 0;
		trace_to_display <= 16'h0231;
		end_game_early <= 0;
		trace1 <= 16'h0075;
		trace2 <= 16'h8ca9;	
		trace3 <= 16'h8f23;
		trace4 <= 16'hd9be;
		trace5 <= 16'b1000000101111110;
		trace6 <= 16'b0111010101111010;	
		trace7 <= 16'b1010101100010100;
		trace8 <= 16'b0111001010110110;
		trace9 <= 16'b1000000101111110;
		trace10 <= 16'b1111011010101010;	
		trace11 <= 16'b0110000010010110;
		trace12 <= 16'b1111001100111100;
		trace13 <= 16'b1101111111110110;
		trace14 <= 16'b1000101011100100;	
		trace15 <= 16'b1110001101110000;
		trace16 <= 16'b0011011001010000;
		trace17 <= 16'b0111101010101110;	
		trace18 <= 16'b1111001111010100;
		trace19 <= 16'b1010101001011100;
		trace20 <= 16'b1101111111110110;
		trace21 <= 16'b0101001011100010;	
		trace22 <= 16'b0010000111110110;
		trace23 <= 16'b1000010111110000;
		trace24 <= 16'b0001100100111010;	
		trace25 <= 16'b0000110111001110;
		trace26 <= 16'b0010100001011010;
		trace27 <= 16'b0110111001101010;	
		trace28 <= 16'b1101101000010110;
		trace29 <= 16'b0000111000101100;

	end
	
	always@(posedge clk & trace_screen_on)
	begin
		// if user trace and trace display are the same, change the trace displayed
		if((p1_traced & trace_to_display)==trace_to_display || (((p2_traced & trace_to_display)==trace_to_display) & two_player_mode))
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
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace5;
			end
			else if (trace_count == 6)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace6;
			end
			else if (trace_count == 7)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace7;
			end
			else if (trace_count == 8)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace8;
			end
			else if (trace_count == 9)
				begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace9;
			end
			else if (trace_count == 10)
				begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace10;
			end
			else if (trace_count == 11)
				begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace11;
			end
			else if (trace_count == 12)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace12;
			end
			else if (trace_count == 13)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace13;
			end
			else if (trace_count == 14)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace14;
			end
			else if (trace_count == 15)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace15;
			end
			else if (trace_count == 16)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace16;
			end
			else if (trace_count == 17)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace17;
			end
			else if (trace_count == 18)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace18;
			end
			else if (trace_count == 19)
				begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace19;
			end
			else if (trace_count == 20)
				begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace20;
			end
			else if (trace_count == 21)
				begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace21;
			end
			else if (trace_count == 22)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace22;
			end
			else if (trace_count == 23)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace23;
			end
			else if (trace_count == 24)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace24;
			end
			else if (trace_count == 25)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace25;
			end
			else if (trace_count == 26)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace26;
			end
			else if (trace_count == 27)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace27;
			end
			else if (trace_count == 28)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace28;
			end
			else if (trace_count == 29)
				begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace29;
			end
			else if(trace_count == 30)
			begin
				trace_count <= 0;
				end_game_early <= 1;
			end
		end
		
	end

endmodule 