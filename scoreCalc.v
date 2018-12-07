module scoreCalc(clock, inTrace, scoreOption, powerUp1, powerUp4, result);


input clock, inTrace, scoreOption;
input powerUp1, powerUp4;
//output [31:0] score;

reg [31:0] positive_points, negative_points;
output reg [31:0]result;
initial begin
result <= 0;
positive_points <= 32'd300;
negative_points <= 32'd100;
end

always @(posedge clock /*|| scoreOption || powerUp1 || powerUp4*/) begin
   if(inTrace==1'b1) begin
// 	   if(inTrace[0]==1'b1 && trace[0] ==1'b1) begin
// 			result1 <= result1 + positive_points;
// 	  end
// 	  else if(inTrace[0]==1'b1 && ~trace[0] ==1'b0) begin
// 	      if( result <= negative_points)
// 					result1=0;
// 			result1 <= result1 - negative_points;
// 	  end
//	  if(inTrace[1]==1'b1 && trace[1] ==1'b1) begin
//			res1 = result + positive_points;
//	  end
//	  else if(inTrace[1]==1'b1 & ~trace[1] ==1'b0) begin
//			if( result <= negative_points)
//					res1=0;
//			res1 = result - negative_points;
//	  end
//	  if(inTrace[2]==1'b1 && trace[2] ==1'b1) begin
//			res2 = res1 + positive_points;
//	  end
//	  else if(inTrace[2]==1'b1 && ~trace[2] ==1'b0) begin
//		  if( res1 <= negative_points)
//						res2=0;
//			res2 = res1 - negative_points;
//	  end
//	  if(inTrace[3]==1'b1 && trace[3] ==1'b1) begin
//			res3 = res2 + positive_points;
//	  end
//	  else if(inTrace[3]==1'b1 && ~trace[3] ==1'b0) begin
//		  if(res2 <= negative_points)
//					res3=0;
//			res3 = res2 - negative_points;
//	  end
//	   if(inTrace[4]==1'b1 & trace[4] ==1'b1) begin
//			result1 = res3 + positive_points;
//	  end
//	  else if(inTrace[4]==1'b1 & ~trace[4] ==1'b0) begin
//			if(res3 <= negative_points)
//					result1=0;
//			result1 = res3 - negative_points;
     end
//	end  
//	  
//   for(i=0; i<16; i=i+1) begin
//	  if(inTrace[i] == trace[i])
//			result <= result + positive_points;
//		else
//	      result <= result - negative_points;	
//	end
// end	
	
//	    if(powerUp1>=1'b1) 
//	     result <= result + positive_points + 32'd150;
//		 else if(powerUp4==1'b1)
//			result <= result + 2*positive_points;
//		 else
			result <= result + positive_points;
	end	  
//   else if (inTrace == 1'b0 && result<=negative_points)
//	     result <= 32'b0;
   else
		  result <= result - negative_points;
end

endmodule
