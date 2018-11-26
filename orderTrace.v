module orderTrace(clock, inTrace, order);
input clock;
input [24:0] inTrace;
output [124:0] order;
//output [24:0] order;
reg [124:0] trackingArray;
reg [4:0] trackA[24:0];
wire [4:0] index;

wire [4:0] counter = 5'b0;
integer count;
integer i;

//Calculates how many ones there are in the trace
initial begin
count =0;
for (i = 0; i < 24; i = i +1) begin
   if(inTrace[i]==1'b1)
		 count=count+1;
end
end

reg [4:0] x;
integer row;
integer col;
integer track[24:0];
integer k;
//reg [24:0] o;
//initial begin
// for(k=0; k<24; k=k+1) begin
//    track[k] = 0;
//	 o[k] <= track[k];
// end
//end 

initial 
begin 
  x = 4'd0;
  row=0;
  col=0; 
  
  while( x < 4'd10 ) 
  begin 
    trackA[row] = x;
	 x=x+4'd1;
	 row=row+1;
	 $display("TrackA: %2d", trackA[row]);
  end 
end 
//initial begin
//trackA[0] <= 4'd0;
//trackA[1] <= 4'd1;
//trackA[2] <= 4'd2;
//end
assign order[4:0] = trackA[0];
assign order[9:5] = trackA[1];
assign order[14:10] = trackA[2];
assign order[19:15] = trackA[3];
assign order[24:20] = trackA[4];
assign order[29:25] = trackA[5];
assign order[34:30] = trackA[6];
assign order[39:35] = trackA[7];
assign order[44:40] = trackA[8];
assign order[49:45] = trackA[9];
assign order[54:50] = trackA[10];
assign order[59:55] = trackA[11];
assign order[64:60] = trackA[12];
assign order[69:65] = trackA[13];
assign order[74:70] = trackA[14];
assign order[79:75] = trackA[15];
assign order[84:80] = trackA[16];
assign order[89:85] = trackA[17];
assign order[94:90] = trackA[18];
assign order[99:95] = trackA[19];
assign order[104:100] = trackA[20];
assign order[109:105] = trackA[21];
assign order[114:110] = trackA[22];
assign order[119:115] = trackA[23];
assign order[124:120] = trackA[24];
endmodule