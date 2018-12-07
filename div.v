module div(data_result, data_opA, data_opB, ctrl_DIV, data_exception, ctrl_resultRDY, clock, reset_counter);

	input [31:0] data_opA, data_opB;
	input ctrl_DIV, clock, reset_counter;
	
	wire [31:0] divisor, dividend, quotient, Qplus1;
	wire [31:0] Aminus1, Bminus1;
	wire [63:0] reg_in, reg_out;
	wire [31:0] ALU_out, ALU_in;
	wire neg_quotient, new_lsb, isLessThan, isNotZero, w1, w2, w3, w4, w5, w6, AnotZero, BnotZero, QnotZero;
	wire [35:0] counter;
	wire data_exception_div, data_exception_0;
	
	output [31:0] data_result;
	output ctrl_resultRDY, data_exception;
	
	// flag if an operand is negative
	xor negate_quotient(neg_quotient, data_opA[31], data_opB[31]);
	
	// flag divide by 0
	notZero divideby0(data_exception_0, data_opB);
	
	// instantiate 32 cycle counter 
	// (actally 34 cycles, +1 to negate operands, +1 to negate quotient if necessary) 
	count_32 count(counter, ctrl_resultRDY, clock, reset_counter, ctrl_DIV);
	
	// invert operands if negative flag high
	mini_ALU ALUA(Aminus1, data_opA, 1'b1, 2'b01, w1, AnotZero, w2);
	mux21 mux_dividend(data_opA[31], ~Aminus1, data_opA, dividend);
	
	mini_ALU ALUB(Bminus1, data_opB, 1'b1, 2'b01, w3, BnotZero, w4);
	mux21 mux_divisor(data_opB[31], ~Bminus1, data_opB, divisor);
	
	// construct value to be written to 64 bit shifting register
	mux21 mux_reg_in(counter[1], dividend, reg_out[31:0], reg_in[31:0]);
	mux31 mux_remainder(reg_in[63:32], counter[1], (~isLessThan || ~isNotZero) && ~counter[1], isLessThan && ~counter[1],
												  32'h00000000, 				  ALU_out, 					  		 reg_out[63:32]);
	mux21 mux_lsb(counter[1], 1'b0, ~isLessThan || ~isNotZero, new_lsb);
	
	// instantiate 64 bit register
	register64_div reg64(reg_out, reg_in, new_lsb, ~ctrl_resultRDY && ~counter[0] && ~counter[34] && ~counter[35], ctrl_DIV, clock);
	
	// instantiate ALU
	mini_ALU subtract(ALU_out, reg_out[63:32], divisor, 2'b01, isLessThan, isNotZero, data_exception_div);
	
	// read quotient from register on second to last clock cycle
	mux21 quot(counter[34], reg_out[31:0], quotient, quotient);
	
	// negate result if negative flag high
	mini_ALU ALUquot(Qplus1, ~quotient, 1'b1, 2'b00, w5, QnotZero, w6);
	mux21 muxQ(neg_quotient, Qplus1, quotient, data_result); 
	
	// write data_exception
	not exception(data_exception, data_exception_0);

endmodule 