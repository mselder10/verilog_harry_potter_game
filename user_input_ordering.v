module user_input_ordering(clk, ir_in, trace_order, next, now, tutorial, initial_block);

	input clk, tutorial, initial_block;
	//input [3:0] trace_ADDR;
	input [63:0] trace_order;
	input [15:0] ir_in;
	
	reg [15:0] counter0, counter1, counter2, counter3, counter4, counter5, counter6, counter7, counter8,
				  counter9, counter10, counter11, counter12, counter13, counter14, counter15;
	
	output reg [3:0] next;
	output reg [3:0] now;
	
	initial
	begin	
		now <= initial_block;
		counter0  <= 1;
		counter1  <= 1;
		counter2  <= 1;
		counter3  <= 1;
		counter4  <= 1;
		counter5  <= 1;
		counter6  <= 1;
		counter7  <= 1;
		counter8  <= 1;
		counter9  <= 1;
		counter10 <= 1;
		counter11 <= 1;
		counter12 <= 1;
		counter13 <= 1;
		counter14 <= 1;
		counter15 <= 1;
	end
	
	always @(posedge clk)
	begin
		// box 0
		if(counter0 == trace_order[63:60] & ir_in[0] & now == 0)
		begin
			now <= next;
			next <= 0;
			counter0 <= counter0 + 1;
		end
		else
			counter0 <= counter0 + 1;
		
		// box 1
		if(counter1 == trace_order[59:56])
		begin
			now <= next;
			next <= 1;
			counter1 <= counter1 + 1;
		end
		else
			counter1 <= counter1 + 1;
		
		// box 2
		if(counter2 == trace_order[55:52])
		begin
			now <= next;
			next <= 2;
			counter2 <= counter2 + 1;
		end
		else
			counter2 <= counter2 + 1;
		
		// box 3
		if(counter3 == trace_order[51:48])
		begin
			now <= next;
			next <= 3;
			counter3 <= counter3 + 1;
		end
		else
			counter3 <= counter3 + 1;
		
		// box 4
		if(counter4 == trace_order[47:44])
		begin
			now <= next;
			next <= 4;
			counter4 <= counter4 + 1;
		end
		else
			counter4 <= counter4 + 1;
		
		// box 5
		if(counter5 == trace_order[43:40])
		begin
			now <= next;
			next <= 5;
			counter5 <= counter5 + 1;
		end
		else
			counter5 <= counter5 + 1;
		
		// box 6
		if(counter6 == trace_order[39:36])
		begin
			now <= next;
			next <= 6;
			counter6 <= counter6 + 1;
		end
		else
			counter6 <= counter6 + 1;
		
		// box 7
		if(counter7 == trace_order[35:32])
		begin
			now <= next;
			next <= 7;
			counter7 <= counter7 + 1;
		end
		else
			counter7 <= counter7 + 1;
		
		// box 8
		if(counter8 == trace_order[31:28])
		begin
			now <= next;
			next <= 8;
			counter8 <= counter8 + 1;
		end
		else
			counter8 <= counter8 + 1;
		
		// box 9
		if(counter9 == trace_order[27:24])
		begin
			now <= next;
			next <= 9;
			counter9 <= counter9 + 1;
		end
		else
			counter9 <= counter9 + 1;
		
		// box 10
		if(counter10 == trace_order[23:20])
		begin
			now <= next;
			next <= 10;
			counter10 <= counter10 + 1;
		end
		else
			counter10 <= counter10 + 1;
		
		// box 11
		if(counter11 == trace_order[19:16])
		begin
			now <= next;
			next <= 11;
			counter11 <= counter11 + 1;
		end
		else
			counter11 <= counter11 + 1;
		
		// box 12
		if(counter12 == trace_order[15:12])
		begin
			now <= next;
			next <= 12;
			counter12 <= counter12 + 1;
		end
		else
			counter12 <= counter12 + 1;
		
		// box 13
		if(counter13 == trace_order[11:8])
		begin
			now <= next;
			next <= 13;
			counter13 <= counter13 + 1;
		end
		else
			counter13 <= counter13 + 1;
		
		// box 16
		if(counter14 == trace_order[7:4])
		begin
			now <= next;
			next <= 14;
			counter14 <= counter14 + 1;
		end
		else
			counter14 <= counter14 + 1;
		
		// box 15
		if(counter15 == trace_order[3:0])
		begin
			now <= next;
			next <= 15;
			counter15 <= counter15 + 1;
		end
		else
			counter15 <= counter15 + 1;
			
	end

endmodule 