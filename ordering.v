module ordering(clock, trace, order);
input [24:0] trace;
input clock;
output order;
reg [4:0] array [24:0];
reg [124:0] next;
reg [4:0] row, col;
reg [4:0] index =0;

//function [9:0] checkOrder; 
//	 input [4:0] r, c, i;
//    reg [4:0] S, COUT; 
//    begin 
//	  @(negedge clock)
//	   begin
//		
//	    S = r+c+i;
//	    COUT =r;	 
//      checkOrder = {COUT, S};
//	 
//	  end 
//    end 
//  endfunction 
endmodule