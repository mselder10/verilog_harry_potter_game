`timescale 1 ns / 100 ps

module skeleton_tb();

	// inputs into skeleton
	reg clock;
	wire reset;
	
	// testing
	integer errors;
	
	skeleton  the_works(clock, reset);
	
	initial

    begin
        $display($time, "<< Starting the Simulation >>");
        clock = 1'b0;    // at time 0
        errors = 0;
		  
		  $display("test 1: starting (addi)");
		  
	 end
	 
	 // Clock generator
    always
         #10     clock = ~clock;

endmodule 