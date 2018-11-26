module count_16(counter, data_resultRDY, clk, reset, ctrl_MULT);

	input clk, reset, ctrl_MULT;
	
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, wa, wb, wc, wd, we, wf, wg, wh;
	
	output data_resultRDY;
	output[16:0] counter;
	
	dflipflop dff1(1'b1, clk, 1'b0, 1'b0, ctrl_MULT,w1);
	dflipflop dff2(w1, clk, reset, 1'b0, ~ctrl_MULT, w2);
	dflipflop dff3(w2, clk, reset, 1'b0, ~ctrl_MULT, w3);
	dflipflop dff4(w3, clk, reset, 1'b0, ~ctrl_MULT, w4);
	dflipflop dff5(w4, clk, reset, 1'b0, ~ctrl_MULT, w5);
	dflipflop dff6(w5, clk, reset, 1'b0, ~ctrl_MULT, w6);
	dflipflop dff7(w6, clk, reset, 1'b0, ~ctrl_MULT, w7);
	dflipflop dff8(w7, clk, reset, 1'b0, ~ctrl_MULT, w8);
	dflipflop dff9(w8, clk, reset, 1'b0, ~ctrl_MULT, w9);
	dflipflop dffa(w9, clk, reset, 1'b0, ~ctrl_MULT, wa);
	dflipflop dffb(wa, clk, reset, 1'b0, ~ctrl_MULT, wb);
	dflipflop dffc(wb, clk, reset, 1'b0, ~ctrl_MULT, wc);
	dflipflop dffd(wc, clk, reset, 1'b0, ~ctrl_MULT, wd);
	dflipflop dffe(wd, clk, reset, 1'b0, ~ctrl_MULT, we);
	dflipflop dfff(we, clk, reset, 1'b0, ~ctrl_MULT, wf);
	dflipflop dffg(wf, clk, reset, 1'b0, ~ctrl_MULT, wg);
	dflipflop dffh(wg, clk, reset, 1'b0, ~ctrl_MULT, wh);
	
	assign data_resultRDY = wh ? 1'b1 : 1'b0;
	
	assign counter[0] =  w1 && ~w2 ? 1'b1 : 1'b0;
	assign counter[1] =  w2 && ~w3 ? 1'b1 : 1'b0;
	assign counter[2] =  w3 && ~w4 ? 1'b1 : 1'b0;
	assign counter[3] =  w4 && ~w5 ? 1'b1 : 1'b0;
	assign counter[4] =  w5 && ~w6 ? 1'b1 : 1'b0;
	assign counter[5] =  w6 && ~w7 ? 1'b1 : 1'b0;
	assign counter[6] =  w7 && ~w8 ? 1'b1 : 1'b0;
	assign counter[7] =  w8 && ~w9 ? 1'b1 : 1'b0;
	assign counter[8] =  w9 && ~wa ? 1'b1 : 1'b0;
	assign counter[9] =  wa && ~wb ? 1'b1 : 1'b0;
	assign counter[10] = wb && ~wc ? 1'b1 : 1'b0;
	assign counter[11] = wc && ~wd ? 1'b1 : 1'b0;
	assign counter[12] = wd && ~we ? 1'b1 : 1'b0;
	assign counter[13] = we && ~wf ? 1'b1 : 1'b0;
	assign counter[14] = wf && ~wg ? 1'b1 : 1'b0;
	assign counter[15] = wg && ~wh ? 1'b1 : 1'b0;
	assign counter[16] = wh ? 1'b1 : 1'b0;
	
endmodule 