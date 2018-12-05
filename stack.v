module stack(clk, d, q, full, empty, push, pop, reset, stack_out);

	input clk, push, pop, reset;
	input [DATA_WIDTH-1:0] d;
	
	parameter DATA_WIDTH = 4;
	parameter STACK_DEPTH = 64;
	
	reg [STACK_DEPTH-1:0] ptr;
	reg [DATA_WIDTH - 1:0] STACK [0:(1<<STACK_DEPTH) - 1];
	
	output reg full, empty;
	output reg [DATA_WIDTH-1:0] q;
	output [63:0] stack_out;
	
	initial
	begin
		ptr <= 0;
	end
	// move the stack pointer
	always @(posedge clk)
	begin
		if(reset)
			ptr = 0;
		else if(push)
			ptr = ptr + 1;
		else //pop
			ptr = ptr - 1;
	end
	
	// move data in and out of stack
	always @(posedge clk)
	begin
		if(push||pop)
		begin
			if(push)
				STACK[ptr] <= d;
			else
				q <= STACK[ptr-1];
		end
	end
	

endmodule 