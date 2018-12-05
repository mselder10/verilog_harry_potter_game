module mult(product, clock, reset_counter, ctrl_MULT, ctrl_resultRDY, data_exception, multiplicand, multiplier);

	input [31:0] multiplier, multiplicand;
	input ctrl_MULT, clock, reset_counter;
	
	wire notZero, isLessThan, reset_counter;
	wire [31:0] M;
	wire [31:0] shifted_M;
	wire [1:0] opcode;
	wire [63:0] ALU_out, product_read;
	wire SHIFT, SUB, NOTHING;
	wire overflow_ALU, overflow_max, overflow_sign, overflow;
	wire sign1, sign2, sign3, multd0, multr0, op0, maxA, maxB;
	wire [16:0] counter;
	
	output ctrl_resultRDY, data_exception;
	output [31:0] product;
	
	
	// select between M and shifted M
	shift_32bit_leftby_1 shiftM(shifted_M, multiplicand);
	mux21 MormS(SHIFT, shifted_M, multiplicand, M);
	
	// initialize 16 clock cycle counter
	count_16 count(counter, ctrl_resultRDY, clock, reset_counter, ctrl_MULT);
	
	// get booth controls
	control booth(SHIFT, SUB, NOTHING, counter, multiplier);
	
	// instantiate ALU opcode
	assign opcode[0] = SUB;
	assign opcode[1] = NOTHING;
	
	// reassign lower bits of 64 bit register to previously read value
	assign ALU_out [31:0] = product_read[31:0];
	
	// instantiante ALU
	mini_ALU alu(ALU_out[63:32], product_read[63:32], M, opcode, isLessThan, notZero, overflow_alu);
	
	// instantiate shifting 64 bit register
	register64_mult prod(product_read, ALU_out, ~ctrl_resultRDY, ctrl_MULT, clock);
	
	// write product
	mytri32 out(product, product_read[31:0], ctrl_resultRDY);
	
	// save overflow found during sequential additions
	dflipflop ovf(1'b1, clock, ctrl_MULT, 1'b0, overflow_ALU || overflow_max, overflow);
	
	// check for sign overflow
	notZero A(multd0, multiplicand);
	notZero B(multr0, multiplier);
	or in0(op0, ~multd0, ~multr0);
	
	and and1(sign1, product[31], multiplier[31], multiplicand[31]);
	and and2(sign2, product[31], ~multiplier[31], ~multiplicand[31]);
	and and3(sign3, ~product[31], multiplier[31]^multiplicand[31]);
	or sign_ovflw(overflow_sign, sign1, sign2, sign3);
	
	// special case: multiplying max positive integer * max positive integer
	assign maxA = ~multiplier[31] && (&multiplier[30:0]);
	assign maxB = ~multiplicand[31] && (&multiplicand[30:0]);
	and ovfw_max(overflow_max, maxA, maxB);
	
	or data_ex(data_exception, overflow, overflow_sign && ~op0, overflow_max);
	
endmodule 