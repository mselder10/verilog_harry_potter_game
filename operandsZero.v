module operandsZero(flag, a, b);

	input [31:0] a, b;
	
	wire a_not_0, b_not_0;
	wire a_zero, b_zero;
	
	output flag;
	
	notZero a0(a_not_zero, a);
	notZero b0(b_not_zero, b);
	
	nor f(flag, a_not_zero, b_not_zero);

endmodule 