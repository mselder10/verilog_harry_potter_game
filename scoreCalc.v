module scoreCalc(clock, inTrace, powerUp1, powerUp4, result);


input clock, inTrace;
input powerUp1, powerUp4;
//output [31:0] score;

reg [31:0] positive_points, negative_points;
output reg [31:0]result;
integer counter =0;
initial begin
result <= 0;
positive_points <= 32'd300;
negative_points <= 32'd100;
end

always @(posedge clock /*|| scoreOption || powerUp1 || powerUp4*/) begin

   if(inTrace==1'b1 && counter>=500000000) begin //update every half a second
	    counter <=0;
	    if(powerUp1>=1'b1) 
	      result <= result + positive_points + 32'd150;
		 else if(powerUp4==1'b1)
			result <= result + 2*positive_points;
		 else
			result <= result + positive_points;
	end	  
   else if (inTrace == 1'b0 && counter>=500000000) begin
	   if(result<=negative_points)
				result <= 32'b0;
		else
		      result <= result - negative_points;
		  
	   counter<=0;
	end	  
   counter <= counter +1;
end

endmodule
