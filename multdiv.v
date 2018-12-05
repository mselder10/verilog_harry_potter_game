module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;
	
	 wire [31:0] MULT_out, DIV_out;
	 wire mult_RDY, div_RDY;
	 wire mult_ctrl, div_ctrl, data_exception_div, data_exception_mult;
	 wire ovf1, ovf2, w1, AnotZero, w2, BnotZero, reset_counter;

    output [31:0] data_result;
    output data_exception, data_resultRDY;	
	
	 or reset(reset_counter, ctrl_DIV, ctrl_MULT);
	 
	 // save ctrl_MULT signal, rewrite if ctrl_DIV high
	 dflipflop MULT(ctrl_MULT, clock, ctrl_DIV | data_resultRDY, 1'b0, ctrl_MULT, mult_ctrl);
	 // multiplication
	 wire [4:0] r;
    mult multiply(MULT_out, clock, reset_counter, ctrl_MULT, mult_RDY, data_exception_mult, data_operandA, data_operandB);
	 
	 // save ctrl_DIV signal, rewrite if ctrl_MULT high
	 dflipflop DIV(ctrl_DIV, clock, ctrl_MULT | data_resultRDY, 1'b0, ctrl_DIV, div_ctrl);
	 // division
	 div divide(DIV_out, data_operandA, data_operandB, ctrl_DIV, data_exception_div, div_RDY, clock, reset_counter);
	
	 // write data_result
	 mytri32 mult_out(data_result, MULT_out, mult_ctrl && mult_RDY);
	 mytri32 div_out(data_result, DIV_out, div_ctrl && div_RDY);
	 
	 // write data_excepetion
	 assign data_exception = (data_exception_mult && mult_ctrl) || (data_exception_div && div_ctrl);
	 
	 // write data_resultRDY
	 or rdy(data_resultRDY, (div_RDY && div_ctrl), (mult_RDY && mult_ctrl));
	 	 
endmodule