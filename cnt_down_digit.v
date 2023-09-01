`default_nettype none
module cnt_down_digit0(
    input wire CLK, RST, BTN, DONE,
    input wire [3:0] VAL_SET,
    output wire [3:0] VAL,
    output wire COUT0, BUSY  
);

reg BTNr;
wire EN;

sec_cnt_down scd (
    .CLK(CLK),
    .RST(RST),
    .EN(BTNr),
    .DONE(DONE),
    .VAL_SET(VAL_SET),
    .VAL(VAL),
    .EN_SEC(EN),
    .BUSY(BUSY)
);

always @ (posedge CLK) begin
    if (RST) begin
        BTNr <= 0;
    end else if (BTN) begin
        BTNr <= ~BTNr;
    end
end

assign COUT0 = ((VAL == 0) & EN) ? 1 : 0;

endmodule

module cnt_down_digit1(
    input wire CLK, RST, COUT0, BUSY,
    input wire [3:0] VAL_SET,
    output wire [3:0] VAL,
    output wire COUT1     
);

reg [3:0] VALr;

always @ (posedge CLK) begin
    if (RST) begin
        VALr <= 0;
    end else begin
        if (COUT0) begin
            if (VALr == 0) begin
                VALr <= 9;
            end else begin
                VALr <= VALr - 1;
            end
        end else begin
            if (~BUSY) begin
                VALr <= VAL_SET;
            end
        end
    end
end

assign VAL = VALr;
assign COUT1 = (VAL == 0) ? 1 : 0;

endmodule

module cnt_down_digit2(
    input wire CLK, RST, COUT0, COUT1, BUSY,
    input wire [3:0] VAL_SET,
    output wire [3:0] VAL,
    output wire COUT2     
);

reg [3:0] VALr;

always @ (posedge CLK) begin
    if (RST) begin
        VALr <= 0;
    end else begin
        if (COUT0 & COUT1) begin
            if (VALr == 0) begin
                VALr <= 9;
            end else begin
                VALr <= VALr - 1;
            end
        end else begin
            if (~BUSY) begin
                VALr <= VAL_SET;
            end
        end
    end
end

assign VAL = VALr;
assign COUT2 = (VAL == 0) ? 1 : 0;

endmodule

module cnt_down_digit3(
    input wire CLK, RST, COUT0, COUT1, COUT2, BUSY,
    input wire [3:0] VAL_SET,
    output wire [3:0] VAL
);

reg [3:0] VALr;

always @ (posedge CLK) begin
    if (RST) begin
        VALr <= 0;
    end else begin
        if (COUT0 & COUT1 & COUT2) begin
            if (VALr == 0) begin
                VALr <= 9;
            end else begin
                VALr <= VALr - 1;
            end
        end else begin
            if (~BUSY) begin
                VALr <= VAL_SET;
            end
        end
    end
end

assign VAL = VALr;

endmodule
`default_nettype wire