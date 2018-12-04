module count_32(counter, data_resultRDY, clk, reset, ctrl_DIV);

	input clk, reset, ctrl_DIV;
	
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, wa, wb, wc, wd, we, wf, wg, wh;
	wire wi, wj, wk, wl, wm, wn, wo, wp, wq, wr, ws, wt, wu, wv, ww, wx, wy ,wz, W;
	
	output data_resultRDY;
	output[35:0] counter;
	
	dflipflop dff1(1'b1, clk, 1'b0, 1'b0, ctrl_DIV,w1);
	dflipflop dff2(w1, clk, reset, 1'b0, ~ctrl_DIV, w2);
	dflipflop dff3(w2, clk, reset, 1'b0, ~ctrl_DIV, w3);
	dflipflop dff4(w3, clk, reset, 1'b0, ~ctrl_DIV, w4);
	dflipflop dff5(w4, clk, reset, 1'b0, ~ctrl_DIV, w5);
	dflipflop dff6(w5, clk, reset, 1'b0, ~ctrl_DIV, w6);
	dflipflop dff7(w6, clk, reset, 1'b0, ~ctrl_DIV, w7);
	dflipflop dff8(w7, clk, reset, 1'b0, ~ctrl_DIV, w8);
	dflipflop dff9(w8, clk, reset, 1'b0, ~ctrl_DIV, w9);
	dflipflop dffa(w9, clk, reset, 1'b0, ~ctrl_DIV, wa);
	dflipflop dffb(wa, clk, reset, 1'b0, ~ctrl_DIV, wb);
	dflipflop dffc(wb, clk, reset, 1'b0, ~ctrl_DIV, wc);
	dflipflop dffd(wc, clk, reset, 1'b0, ~ctrl_DIV, wd);
	dflipflop dffe(wd, clk, reset, 1'b0, ~ctrl_DIV, we);
	dflipflop dfff(we, clk, reset, 1'b0, ~ctrl_DIV, wf);
	dflipflop dffg(wf, clk, reset, 1'b0, ~ctrl_DIV, wg);
	dflipflop dffh(wg, clk, reset, 1'b0, ~ctrl_DIV, wh);
	
	dflipflop dffi(wh, clk, reset, 1'b0, ~ctrl_DIV, wi);
	dflipflop dffj(wi, clk, reset, 1'b0, ~ctrl_DIV, wj);
	dflipflop dffk(wj, clk, reset, 1'b0, ~ctrl_DIV, wk);
	dflipflop dffl(wk, clk, reset, 1'b0, ~ctrl_DIV, wl);
	dflipflop dffm(wl, clk, reset, 1'b0, ~ctrl_DIV, wm);
	dflipflop dffn(wm, clk, reset, 1'b0, ~ctrl_DIV, wn);
	dflipflop dffo(wn, clk, reset, 1'b0, ~ctrl_DIV, wo);
	dflipflop dffp(wo, clk, reset, 1'b0, ~ctrl_DIV, wp);
	dflipflop dffq(wp, clk, reset, 1'b0, ~ctrl_DIV, wq);
	dflipflop dffr(wq, clk, reset, 1'b0, ~ctrl_DIV, wr);
	dflipflop dffs(wr, clk, reset, 1'b0, ~ctrl_DIV, ws);
	dflipflop dfft(ws, clk, reset, 1'b0, ~ctrl_DIV, wt);
	dflipflop dffu(wt, clk, reset, 1'b0, ~ctrl_DIV, wu);
	dflipflop dffv(wu, clk, reset, 1'b0, ~ctrl_DIV, wv);
	dflipflop dffw(wv, clk, reset, 1'b0, ~ctrl_DIV, ww);
	dflipflop dffx(ww, clk, reset, 1'b0, ~ctrl_DIV, wx);
	dflipflop dffy(wx, clk, reset, 1'b0, ~ctrl_DIV, wy);
	dflipflop dffz(wy, clk, reset, 1'b0, ~ctrl_DIV, wz);
	dflipflop dffW(wz, clk, reset, 1'b0, ~ctrl_DIV, W);
	
	//assign data_resultRDY = wy ? 1'b1 : 1'b0;
	assign data_resultRDY = W ? 1'b1 : 1'b0;
	
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
	assign counter[16] = wh && ~wi ? 1'b1 : 1'b0;
	
	assign counter[17] =  wi && ~wj ? 1'b1 : 1'b0;
	assign counter[18] =  wj && ~wk ? 1'b1 : 1'b0;
	assign counter[19] =  wk && ~wl ? 1'b1 : 1'b0;
	assign counter[20] =  wl && ~wm ? 1'b1 : 1'b0;
	assign counter[21] =  wm && ~wn ? 1'b1 : 1'b0;
	assign counter[22] =  wn && ~wo ? 1'b1 : 1'b0;
	assign counter[23] =  wo && ~wp ? 1'b1 : 1'b0;
	assign counter[24] =  wp && ~wq ? 1'b1 : 1'b0;
	assign counter[25] =  wq && ~wr ? 1'b1 : 1'b0;
	assign counter[26] =  wr && ~ws ? 1'b1 : 1'b0;
	assign counter[27] =  ws && ~wt ? 1'b1 : 1'b0;
	assign counter[28] =  wt && ~wu ? 1'b1 : 1'b0;
	assign counter[29] =  wu && ~wv ? 1'b1 : 1'b0;
	assign counter[30] =  wv && ~ww ? 1'b1 : 1'b0;
	assign counter[31] =  ww && ~wx ? 1'b1 : 1'b0;
	assign counter[32] =  wx && ~wy ? 1'b1 : 1'b0;
	//assign counter[33] =  wy;
	assign counter[33] =  wy && ~wz ? 1'b1 : 1'b0;
	assign counter[34] =  wz && ~W  ? 1'b1 : 1'b0;
	assign counter[35] =  W;
	
endmodule 