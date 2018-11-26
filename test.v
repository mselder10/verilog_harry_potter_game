module test(clk, input1, output1);
input clk;
input [4:0] input1;
output [4:0] output1;

reg [4:0] in = 4'b0;
always @(posedge clk) begin
in<=input1;
 if(in>4'b0) begin
  in <= in+4'b1;
 end
end

assign output1 = in;
endmodule