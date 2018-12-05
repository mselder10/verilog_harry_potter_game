module trace_change(trace_number, clk, p1_traced, p2_traced);

	reg [15:0] trace0, trace1, trace2, trace3, trace4;
	assign wire [15:0] trace0 = 16'h0231;
	assign wire [15:0] trace1 = 16'h0075;
	assign wire [15:0] trace2 = 16'h8ca9;	
	assign wire [15:0] trace3 = 16'h8f23;
	assign wire [15:0] trace4 = 16'hd9be;
	
	assign wire trace = (trace == 0) ? trace0 : 8'bz;
	assign wire trace = (trace == 1) ? trace1 : 8'bz;
	assign wire trace = (trace == 2) ? trace2 : 8'bz;
	assign wire trace = (trace == 3) ? trace3 : 8'bz;
	assign wire trace = (trace == 4) ? trace4 : 8'bz;

endmodule 