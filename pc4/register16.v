module register16(data_output, counter, data_input, ctrl_writeEnable, clear, clock);
	
	// register where we can read a specific dflipflop
	
   input clock, ctrl_writeEnable, clear;
	input [16:0] counter;
   input [16:0] data_input;
	
	wire [31:0] stored;
	
   output data_output;
	
	// process all DFFs
	genvar c;
	generate
		for(c=0; c<16; c=c+1) begin: dff_loop
			dflipflop dff1(data_input[c], clock, clear, 1'b1, ctrl_writeEnable, stored[c]);
			// only read value of dff corresponding to current cycle
			assign data_output = (counter[c] && ~counter[c+1]) ? stored[c] : 1'bz;
		end
	endgenerate
	

endmodule 