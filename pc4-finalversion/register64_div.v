module register64_div(data_output, data_input, new_lsb, ctrl_writeEnable, clear, clock);

   input clock, ctrl_writeEnable, clear, new_lsb;
   input [63:0] data_input;
	
   output [63:0] data_output;
	
	// 64 bit register that shifts input data left by 1
	
	// insert either 1 or 0 in LSB
	dflipflop dff1(new_lsb, clock, clear, 1'b1, ctrl_writeEnable, data_output[0]);
	
	genvar c;
	generate
		for(c=0; c<63; c=c+1) begin: dff_loop
			dflipflop dff2(data_input[c], clock, clear, 1'b1, ctrl_writeEnable, data_output[c+1]);
		end
	endgenerate

endmodule