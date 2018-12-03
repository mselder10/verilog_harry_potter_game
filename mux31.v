module mux31(out, e0, e1, e2, 
						in0, in1, in2);

	input e0, e1, e2;
	input [31:0] in0, in1, in2;
	output [31:0] out;
	
	mytri32 tria(out, in0, e0);
	mytri32 trib(out, in1, e1);
	mytri32 tric(out, in2, e2);

endmodule 
