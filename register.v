module register(
    clock,
    ctrl_writeEnable,
    clear, data_input, data_output
);

   input clock, ctrl_writeEnable, clear;
   input [31:0] data_input;
	
   output [31:0] data_output;
	
	// process all DFFs
	genvar c;
	generate
		for(c=0; c<32; c=c+1) begin: dff_loop
			dffe_ref dffe1(.q(data_output[c]), 
								.d(data_input[c]), 
								.clk(clock), 
								.en(ctrl_writeEnable), 
								.clr(clear));
		end
	endgenerate

endmodule