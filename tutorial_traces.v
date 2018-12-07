module tutorial_traces(learn_mode, trace_to_display, trace_order, trace_boxes, 
								clk, p1_traced, trace_screen_on, end_game_early, trace_count,
								initial_row, initial_col);
	
	input trace_screen_on, clk, learn_mode;
	input [15:0] p1_traced;
	
	output reg [5:0] trace_count;
	reg [15:0] trace0, trace1, trace2, trace3, trace4;
	
	reg [63:0] trace1_order, trace2_order, trace3_order, trace4_order;
	reg [5:0] trace1_boxes, trace2_boxes, trace3_boxes, trace4_boxes;
	reg [8:0] initial_row1;
	reg [9:0] initial_col1, initial_col3;
	
	output reg [7:0] initial_row;
	output reg [8:0] initial_col;
	output reg [5:0] trace_boxes;
	output reg [63:0] trace_order;
	output reg [15:0] trace_to_display;
	output reg end_game_early;
	
	initial begin
		trace_count <= 0;
		end_game_early <= 0;
		// preset traces
		trace_to_display <= 16'b0000011001100000; // (in excel 2)
		trace1 <= 16'b1111100110011111; // (in excel 1)
		trace2 <= 16'b0000110011001111; // (in excel 3)
		trace3 <= 16'b1110001000110111; // (in excel 5)
		trace4 <= 16'b0001001101100100; // (in excel 9)
		// trace ordering
		trace_order <= 64'b0000000000000000000000010010000000000100001100000000000000000000;
		trace1_order <= 64'b0001001000110100110000000000010110110000000001101010100110000111;
		trace2_order <= 64'b0001001000110100000000001000010100000000011101100000000000000000;
		trace3_order <= 64'b0011001000010000010001010000000000000110000000000000011110001001;
		trace4_order <= 64'b0000000000010000000000110010000001010100000000000110000000000000;
		// trace box numbers
		trace_boxes <= 6'd4;
		trace1_boxes <= 6'd12;
		trace2_boxes <= 6'd8;
		trace3_boxes <= 6'd9;
		trace4_boxes <= 6'd6;
		// inital row/col
		initial_row <= 8'd190;
		initial_row1 <= 8'd90;
		initial_col <= 9'd270;
		initial_col1 <= 9'd170;
		initial_col3 <= 9'd370;
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
				trace_order <= trace1_order;
				trace_boxes <= trace1_boxes;
				initial_row <= initial_row1;
				initial_col <= initial_col1;
			end
			else if (trace_count == 2)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace2;
				trace_order <= trace2_order;
				trace_boxes <= trace2_boxes;
			end
			else if (trace_count == 3)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace3;
				trace_order <= trace3_order;
				trace_boxes <= trace3_boxes;
				initial_col <= initial_col3;
			end
			else if (trace_count == 4)
			begin
				//previous_trace_displayed <= trace_to_display;
				trace_to_display <= trace4;
				trace_order <= trace4_order;
				trace_boxes <= trace4_boxes;
			end
			else if (trace_count == 5)
			begin
				trace_count <= 0;
				end_game_early <= 1;
			end
		end
		
	end

endmodule 