module register32(data_output, data_input, ctrl_writeEnable, clear, clock);

   input clock, ctrl_writeEnable, clear;
   input [31:0] data_input;
	
   output [31:0] data_output;
	
	// process all DFFs
	genvar c;
	generate
		for(c=0; c<32; c=c+1) begin: dff_loop
			dflipflop dff1(data_input[c], clock, clear, 1'b1, ctrl_writeEnable, data_output[c]);
		end
	endgenerate

endmodule 