`default_nettype none
module sec_cnt(
    input wire CLK, RST, EN,
    output wire [3:0] VAL,
    output wire EN_SEC
);

parameter [31:0] CNT_FULL = 1_000_000;
//parameter [31:0] CNT_FULL = 10;

reg [3:0] VALr;
reg [31:0] CNT;

always @ (posedge CLK) begin
    if (RST) begin
        CNT <= 0;
        VALr <= 0;
    end else begin
        if (EN) begin
            CNT <= CNT + 1;
            if (CNT == CNT_FULL) begin
                if (VALr == 9) begin
                    VALr <= 0;
                end else begin
                    VALr <= VALr + 1;
                    CNT <= 0;
                end
            end
        end
    end
end

assign EN_SEC = (CNT == CNT_FULL) ? 1 : 0;
assign VAL = VALr;

endmodule
`default_nettype wire