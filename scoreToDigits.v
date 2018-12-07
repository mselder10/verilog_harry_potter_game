module scoreToDigits(clock, score, digit0, digit1, digit2, digit3, digit4, digit5);
input clock;
input [31:0] score;
wire [31:0] result;

register31 r31(clock, 1'b1, 1'b0, result, score);
output reg [31:0] digit0, digit1, digit2, digit3, digit4, digit5;

reg [31:0] result1, result2, result3, result4, result5, result6;
integer counter = 0;
always @(posedge clock) begin
	if(counter >= 50000000) begin
	    counter = 0;
		 digit0 = result % 4'd10;
		 result1 = result / 4'd10;
		 digit1 = result1 %  4'd10;
		 result2 = result1 / 4'd10;

		 digit2 = result2 % 4'd10;
		 result3 = result2 / 4'd10;
		 digit3 = result3 %  4'd10;
		 result4 = result3 / 4'd10;

		 digit4 = result4 % 4'd10;
//		 result5 = result4 / 4'd10;
//		 digit5 = result5 %  4'd10;
//		 result6 = result5 / 4'd10;
	end
	else
		counter = counter+1;
end
//
//
//always @(score) begin
//result<=score;
//
////
////	for(i=0; i<6; i=i+1) begin
////	digit[0] <= result % 4'd10;
////	result <= result /4'd10;
////	i= i+1;
////	end
//end
//assign digit0 = digit[0];
//assign digit1 = digit[1];
//assign digit2 = digit[2];
//assign digit3 = digit[3];
//assign digit4 = digit[4];
//assign digit5 = digit[5];
endmodule