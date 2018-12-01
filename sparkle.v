module sparkle(clk, sparkle, sparkle_here, sparkle_pixel);

	input clk, sparkle_here;
	input [11:0] sparkle_pixel;
	reg [11:0] addr, ADDR0, ADDR1, ADDR2, ADDR3;
	reg [11:0] offset;
	reg [31:0] counter;
	output sparkle;
	
	sparkles sparkz(
		.address(sparkel_pixel),
		.clock(~clk),
		.q(sparkle));
	
	assign ADDR = offset + sparkle_pixel;
	
	always @(posedge clk)
	begin
		if(counter <= 32'd50000000)
			offset <= 0;
		else if(counter > 32'd50000000 && counter <= 32'd100000000)
			offset <= 400;
		else if(counter > 32'd100000000 && counter <= 32'd150000000)
			offset <= 800;
		else if(counter > 32'd100000000 && counter < 32'd150000000)
			offset <= 1200;
		
		if(sparkle_here)
		begin
			if(counter >= 150000000)
				counter <= 0;
			else
				counter = counter + 1;
		end
//		else if(counter > 32'd50000000 && counter <= 32'd100000000)
//		begin
//			offset <= 400;
//			ADDR1 <= ADDR1 + 1;
//			if(ADDR1 == 400)
//				ADDR1<= 0;
//			addr <= ADDR1;
//		end
//		else if(counter > 32'd100000000 && counter <= 32'd150000000)
//		begin
//			offset <= 800;
//			ADDR2 <= ADDR2 + 1;
//			if(ADDR2 == 400)
//				ADDR2<= 0;
//			addr <= ADDR2;
//		end
//		else if(counter > 32'd200000000 && counter <= 32'd250000000)
//		begin
//			offset <= 1200;
//			ADDR3 <= ADDR3 + 1;
//			if(ADDR3 == 400)
//				ADDR3<= 0;
//			addr <= ADDR3;
//		end
			
	end
	
endmodule 