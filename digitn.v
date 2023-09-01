`default_nettype none
module digit0(
    input wire CLK, RST, BTN,
    output wire [3:0] VAL,
    output wire COUT0     
);

reg BTNr;
wire EN;

sec_cnt sc (
    .CLK(CLK),
    .RST(RST),
    .EN(BTNr),
    .VAL(VAL),
    .EN_SEC(EN)
);

always @ (posedge CLK) begin
    if (RST) begin
        BTNr <= 0;
    end else if (BTN) begin
        BTNr <= ~BTNr;
    end
end

assign COUT0 = ((VAL == 9) & EN) ? 1 : 0;

endmodule

module digit1(
    input wire CLK, RST, COUT0,
    output wire [3:0] VAL,
    output wire COUT1     
);

reg [3:0] VALr;

always @ (posedge CLK) begin
    if (RST) begin
        VALr <= 0;
    end else if (COUT0) begin
        VALr <= VALr + 1;
        if (VALr == 9) begin
            VALr <= 0;
        end
    end
end

assign VAL = VALr;
assign COUT1 = (VAL == 9) ? 1 : 0;

endmodule

module digit2(
    input wire CLK, RST, COUT0, COUT1,
    output wire [3:0] VAL,
    output wire COUT2     
);

reg [3:0] VALr;

always @ (posedge CLK) begin
    if (RST) begin
        VALr <= 0;
    end else if (COUT0 & COUT1) begin
        VALr <= VALr + 1;
        if (VALr == 9) begin
            VALr <= 0;
        end
    end
end

assign VAL = VALr;
assign COUT2 = (VAL == 9) ? 1 : 0;

endmodule

module digit3(
    input wire CLK, RST, COUT0, COUT1, COUT2,
    output wire [3:0] VAL
);

reg [3:0] VALr;

always @ (posedge CLK) begin
    if (RST) begin
        VALr <= 0;
    end else if (COUT0 & COUT1 & COUT2) begin
        VALr <= VALr + 1;
        if (VALr == 9) begin
            VALr <= 0;
        end
    end
end

assign VAL = VALr;

endmodule
`default_nettype wire