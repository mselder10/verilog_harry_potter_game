module booth(shift, sub, nothing, lsb_multiplier);
	
	input [2:0] lsb_multiplier;
	
	wire n0, n1, n2;
	wire [7:0] action;
	
	output shift, sub, nothing;
	
	not not0(n0, lsb_multiplier[0]);
	not not1(n1, lsb_multiplier[1]);
	not not2(n2, lsb_multiplier[2]);
	
	// logic for action to be taken based on Booth's algorithm
	and and0(action[0], n2, 					n1, 					 n0					);
	and and1(action[1], n2, 					n1, 					 lsb_multiplier[0]);
	and and2(action[2], n2, 					lsb_multiplier[1], n0					);
	and and3(action[3], n2, 					lsb_multiplier[1], lsb_multiplier[0]);
	and and4(action[4], lsb_multiplier[2], n1, 					 n0					);
	and and5(action[5], lsb_multiplier[2], n1, 					 lsb_multiplier[0]);
	and and6(action[6], lsb_multiplier[2], lsb_multiplier[1], n0					);
	and and7(action[7], lsb_multiplier[2], lsb_multiplier[1], lsb_multiplier[0]);
	
	// assign control bits out
	or or_nothing(nothing, action[0], action[7]);
	or or_sub(sub, action[4], action[5], action[6]);
	or or_shift(shift, action[3], action[4]);

endmodule 