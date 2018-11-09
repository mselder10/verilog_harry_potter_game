module alu(data_operandA, data_operandB, ctrl_ALUopcode,
ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

	input [31:0] data_operandA, data_operandB;
	input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
	
	// operation control bits
	wire ADD, SUB, AND, OR, SLL, SRA, ZERO;
	
	// outputs of alu operations
	wire [31:0] ADD_out, AND_out, OR_out, SLL_out, SRA_out, XOR_out, ZERO_out;
	
	wire [31:0] b;
	wire w1, isNotZero, overflow_add;
	
	output [31:0] data_result;
	output isNotEqual, isLessThan, overflow;
	
		// check is operands are 0
	operandsZero zero(ZERO, data_operandA, data_operandB);
	
	// decode opcode
	opdecode opc(ADD, SUB, AND, OR, SLL, SRA, ctrl_ALUopcode);
	
	// and
	and32 andab(AND_out, data_operandA, b);
	
	// or
	or32 orab(OR_out, data_operandA, data_operandB);
	
	// invert B for subtraction?
	xorB bis(b, data_operandB, SUB);

	// xor for adder propogate bits
	xor32 xorab(XOR_out, data_operandA, b);
	
	// add
	add32 addab(ADD_out, overflow_add, XOR_out, AND_out, SUB);
	
	// right arithmetic shift
	sra32 sraa(SRA_out, data_operandA, ctrl_shiftamt);
	
	// left arithmetic shift
	sll32 slla(SLL_out, data_operandA, ctrl_shiftamt);
	
	// pick output
	mytri32 out0(data_result, AND_out, AND);
	mytri32 out2(data_result, OR_out , OR );
	mytri32 out3(data_result, SRA_out, SRA);
	mytri32 out4(data_result, SLL_out, SLL);
	mytri32 out5(data_result, ADD_out, ADD);
	mytri32 out1(data_result, ADD_out, SUB);
	mytri32 out6(data_result, 32'h00000000, ZERO);
	
	// control flag logic
	notZero ine(w1, ADD_out);
	not nZ(isNotZero, ZERO);
	and (isNotEqual, w1, isNotZero);
	or ilt(isLessThan, ADD_out[31], overflow);
	and andovf(overflow, overflow_add, isNotZero);
	
endmodule 