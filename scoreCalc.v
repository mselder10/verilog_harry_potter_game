module scoreCalc(inTrace, scoreOption, powerUp1, powerUp4, result);


input inTrace, scoreOption;
input powerUp1, powerUp4;
//output [31:0] score;

reg [31:0] positive_points, negative_points;
output reg [31:0]result;
initial begin
result <= 32'b0;
positive_points <= 32'd300;
negative_points <= 32'd100;
end

always @(inTrace || scoreOption || powerUp1 || powerUp4) begin
   if(inTrace) begin
	    if(powerUp1>=1'b1) 
	     result <= result + positive_points + 32'd150;
		 else if(powerUp4==1'b1)
			result <= result + 2*positive_points;
		 else
			result <= result + positive_points;
	end	  
   else if (inTrace == 1'b0 && result<=negative_points)
	     result <= 32'b0;
   else
		  result <= result - negative_points;
end

endmodule