module checkDown(clk, next, trace, order, current, row, col, index, next_out, order_out, index_out, current_out, dataRDY);
/*this module checks the neigbors of the block and if they are one it gives them order and adds them to the next,
    next acts as a stack to keep track of the connected blocks*/
input clk;
input [4:0] row, col, index, current;
input [24:0] trace;
input [124:0] next, order;
output [124:0] next_out, order_out;
output [4:0] index_out, current_out;
output dataRDY;

   /* Check above */
  reg [124:0] Order = 125'b0;
  reg [124:0] OrderBuf = 125'b0;
  reg [4:0] Current= 5'b0;
  reg [124:0] Next = 125'b0;
  reg [124:0] NextBuf = 125'b0;
  reg [4:0] Index=5'b0;

  reg  counter = 1'b1;
  reg  Counter = 1'b0;
  
  always @(posedge clk) begin
     counter <= counter+1'b1;
     if(row<5'd4 && trace[(row + 5'b1) * 5'd5 + col]==1'b1 && order[(((row + 7'b1) * 7'd5 + col)*7'd5+7'd4) -:5] == 5'b0) begin   
     Order[(((row + 5'b1) * 7'd5 + col)*7'd5+5'd4)-:5] <= current;
	  OrderBuf <= Order | order;
	  Current <= current+5'b1;
	  Next[index*7'd5+:5]<= ((row + 5'b1) * 5'd5 + col);
	  NextBuf <= Next | next;
	  Index <= index+5'd1;
    end
	 Counter <= counter + 1'b1;
  end

  assign dataRDY = Counter;
  assign current_out = Current;
  assign order_out = OrderBuf;
  assign index_out = Index;
  assign next_out = NextBuf;
   
endmodule