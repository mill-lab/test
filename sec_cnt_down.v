`default_nettype none
module sec_cnt_down(
    input wire CLK, RST, EN, DONE,
    input wire [3:0] VAL_SET,
    output wire [3:0] VAL,
    output wire EN_SEC,
    output wire BUSY
);

parameter [31:0] CNT_FULL = 100_000_000;
//parameter [31:0] CNT_FULL = 10;

reg [3:0] STAT;
reg [3:0] VALr;
reg [31:0] CNT;

always @ (posedge CLK) begin
    if (RST) begin
        STAT <= 4'b0001;
        CNT <= 0;
        VALr <= VAL_SET;
    end else begin
        case (STAT)
        4'b0001: begin
            VALr <= VAL_SET;
            if (EN) begin
                STAT <= 4'b0010;
            end
        end

        4'b0010: begin
            CNT <= CNT + 1;
            if (CNT == CNT_FULL) begin
                if (VALr == 0) begin
                    CNT <= 0;
                    VALr <= 9;
                end else begin
                    VALr <= VALr - 1;
                    CNT <= 0;
                end
            end
            if (~EN) begin
                STAT <= 4'b0100;
            end
            if (DONE) begin
                STAT <= 4'b1000;
            end
        end

        4'b0100: begin
            if (EN) begin
                STAT <= 4'b0010;
            end
        end

        4'b1000: begin
            if (~EN) begin
                STAT <= 4'b0001;
            end
        end

        default : begin
            STAT <= 4'b0001;
            CNT <= 0;
            VALr <= 0;
        end
        endcase
    end
end

assign EN_SEC = (CNT == CNT_FULL) ? 1 : 0;
assign VAL = VALr;
assign BUSY = ~STAT[0];

endmodule
`default_nettype wire