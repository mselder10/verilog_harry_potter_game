module control(SHIFT_out, SUB_out, NOTHING_out, counter, multiplier);

	input [31:0] multiplier;
	input [16:0] counter;
	
	wire [15:0] SHIFT, SUB, NOTHING;
	
	output SHIFT_out, SUB_out, NOTHING_out;
	
	booth_ctrl booth(SHIFT, SUB, NOTHING, multiplier);
	
	genvar c;
	generate
		for(c=0; c<16; c= c+1) begin: loop
			assign SHIFT_out = counter[c] ? SHIFT[c] : 1'bz;
			assign SUB_out = counter[c] ? SUB[c] : 1'bz;
			assign NOTHING_out = counter[c] ? NOTHING[c] : 1'bz;
		end
	endgenerate

endmodule