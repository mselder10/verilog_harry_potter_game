module dflipflop(d, clk, clr, prn, ena, q);
    input d, clk, ena, clr, prn;
    wire pr;

    output q;
    reg q;

    assign pr = ~prn;

    initial
    begin
        q = 1'b0;
    end

    always @(posedge clk) begin
        if (q == 1'bx) begin
            q <= 1'b0;
        end else if (clr) begin
            q <= 1'b0;
        end else if (ena) begin
            q <= d;
        end
    end
endmodule