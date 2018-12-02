module register64_mult(data_output, data_input, ctrl_writeEnable, clear, clock);

   input clock, ctrl_writeEnable, clear;
   input [63:0] data_input;
	
   output [63:0] data_output;
	
	// 64 bit register that shifts input data by 2
	genvar c;
	generate
		for(c=0; c<62; c=c+1) begin: dff_loop
			dflipflop dff1(data_input[c+2], clock, clear, 1'b1, ctrl_writeEnable, data_output[c]);
		end
	endgenerate
	
	// sign extend 64th and 63rd bit
	dflipflop dff62(data_input[63], clock, clear, 1'b1, ctrl_writeEnable, data_output[62]);
	dflipflop dff63(data_input[63], clock, clear, 1'b1, ctrl_writeEnable, data_output[63]);

endmodule