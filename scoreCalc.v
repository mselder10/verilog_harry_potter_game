module scoreCalc(clock, inTrace, powerUp1, powerUp4, result1);


input clock;
input [15:0]  inTrace;
input powerUp1, powerUp4;
//output [31:0] score;

reg [31:0] positive_points, negative_points, max;
output reg [31:0]result1;
reg [31:0] result, res1, res2, res3, res4, res5, res6, res7, res8;
initial begin
result <= 0;
positive_points <= 32'd100;
negative_points <= 32'd10;
max <=32'd9900;
end
integer counter =0;
integer i;
always @( posedge clock /*|| scoreOption || powerUp1 || powerUp4*/) begin
   if(counter>=500000000) begin //10000 50000000
			counter<=0;
	    if(inTrace[0]>=1'b1) begin 
		  if(result1>=max)
					result1<=32'd9999;
	     result1 <= result1 + positive_points;
		  end
		 else if(inTrace[1]==1'b1)
			if(result1>=max)
					result1<=32'd9999;
	     result1 <= result1 + positive_points + 32'd50;
		  end
		 else if(inTrace[2]==1'b1) begin
			if(result1>=max)
					result1<=32'd9999;
	     result1 <= result1 + positive_points + 32'd75;
		  end
	
       else if(inTrace[3]==1'b1) begin //100000
			if(result1<=negative_points)
					result1<=32'b0;
			else
				   result1 <= result1 - negative_points;
	
	    end
		  else if(inTrace[4]==1'b1) begin //100000
			if(result1<=negative_points)
					result1<=32'b0;
			else
				   result1 <= result1 - negative_points -32'd50;
	
	    end
	
	else 
		 counter<=counter+1;
	  
end	  
	  
//	  
//	  if(inTrace[0]==1'b1 && trace[0] ==1'b1) begin
//			result1 <= result1 + positive_points;
//	  end
//	  else if(inTrace[0]==1'b1 && ~trace[0] ==1'b0) begin
//	      if( result <= negative_points)
//					result1=0;
//			result1 <= result1 - negative_points;
//	  end
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
    // end
//	end  
//	  
//   for(i=0; i<16; i=i+1) begin
//	  if(inTrace[i] == trace[i])
//			result <= result + positive_points;
//		else
//	      result <= result - negative_points;	
//	end
// end	
	
//   if(inTrace==1'b1 && counter>=100000) begin
//	      counter<=0;
//			
////	    if(powerUp1>=1'b1) 
////	     result <= result + positive_points + 32'd150;
////		 else if(powerUp4==1'b1)
////			result <= result + 2*positive_points;
////		 else
//			result <= result + positive_points;
//	end
//   else if(inTrace==1'b0 && counter>=100000) begin
//			if(result<=negative_points)
//					result<=32'b0;
//			else
//				   result <= result - negative_points;
//			counter<=0;	
//	end
//	counter<=counter+1;
//	
//end

endmodule