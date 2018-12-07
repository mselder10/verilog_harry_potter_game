module mini_ALU(data_result,data_operandA, data_operandB, opcode, isLessThan, isNotZero, overflow);

	input [31:0] data_operandA, data_operandB;
	input [1:0] opcode;
	
	// operation control bits
	wire SUB, NOTHING, ZERO, ADD;
	
	// outputs of alu operations
	wire [31:0] ADD_out, AND_out, XOR_out, ZERO_out;
	
	wire [31:0] b;
	wire w1, overflow_add;
	
	output [31:0] data_result;
	output isNotZero, isLessThan, overflow;
	
	// check is operands are 0
	operandsZero zero(ZERO, data_operandA, data_operandB);
	
	// decode op
	minidecode op(ADD, SUB, NOTHING, opcode, ZERO);
	
	// and
	and32 andab(AND_out, data_operandA, b);
	
	// invert B for subtraction?
	xorB bis(b, data_operandB, SUB);

	// xor for adder propogate bits
	xor32 xorab(XOR_out, data_operandA, b);
	
	// add
	add32 addab(ADD_out, overflow_add, XOR_out, AND_out, SUB);
	
	// pick output
	mytri32 out0(data_result, data_operandA, NOTHING);
	mytri32 out1(data_result, ADD_out, ADD);
	mytri32 out2(data_result, ADD_out, SUB);
	mytri32 out3(data_result, 32'h00000000, ZERO);
	
	// control flag logic
	notZero ine(isNotZero, ADD_out);
	and (isNotEqual, isNotZero, ~ZERO);
	or ilt(isLessThan, ADD_out[31], overflow);
	and andovf(overflow, overflow_add, ~ZERO);
	
endmodule 