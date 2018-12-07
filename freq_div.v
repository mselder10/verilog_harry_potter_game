module freq_div(clk_in, clk_out);

	input clk_in;
	output reg clk_out;
	
	integer count;
	
	initial
		count = 0;
	
	always@(posedge clk_in)
		begin
			count = count + 1;
			
			if(count >= 5000000)
			begin
				count	 = 0;
				clk_out <= ~clk_out;
			end
			
		end

endmodule