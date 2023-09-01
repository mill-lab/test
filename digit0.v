`default_nettype none
    module digit0(
        input wire CLK, RST, BTN,
        output wire [3:0] VAL,
        output wire COUT     
    );

    sec_cnt sc (
        .CLK(CLK),
        .RST(RST),
        .EN(BTNr),
        .VAL(VAL)
    );

    reg BTNr;

always @ (posedge CLK) begin
    if (RST) begin
        BTNr <= 0;
    end else if (BTN) begin
        BTNr <= ~BTNr;
    end
end

    assign COUT = (VAL == 9) ? 1 : 0;

    endmodule
`default_nettype wire