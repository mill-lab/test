`default_nettype none
    module deccnt(
        input wire CLK, RST, BTN,
        output wire [15:0] VAL     
    );

    parameter [31:0] CNT_FULL = 100_000_000;
    //parameter [31:0] CNT_FULL = 10;

    reg STAT;
    reg [15:0] VALr;
    reg [31:0] CNT;

    always @ (posedge CLK) begin
        if (RST) begin
            STAT <= 0;
            CNT <= 0;
            VALr <= 0;
        end else begin
            case (STAT)
            0: begin // idle STAT
                if (BTN) begin
                    STAT <= 1;
                end
            end

            1: begin // count any time and count up value
                CNT <= CNT + 1;
                if (CNT==CNT_FULL) begin
                    VALr <= VALr + 1;
                    CNT <= 0;
                end
                if (BTN) begin // count stop
                    STAT <= 0;
                end
            end

            default: begin
                STAT <= 0;
                VALr <= 0;
            end
            endcase
        end
    end

    reg [15:0] DEC;

    assign VAL = VALr;

    endmodule
`default_nettype wire