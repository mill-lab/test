`default_nettype none
    module btnflt(
        input wire CLK, RST, BTN,
        output wire BTNQ
    );

    parameter [31:0] CNT_FULL = 1_000_000;
    //parameter [31:0] CNT_FULL = 10;

    reg [2:0] STAT;
    reg BTNQr;
    reg [31:0] CNT;

    always @ (posedge CLK) begin
        if (RST) begin
            STAT <= 3'b001;
            CNT <= 0;
            BTNQr <= 0;
        end else begin
            case (STAT)
            3'b001: begin
               BTNQr <= 0;
                if (BTN) begin
                    STAT <= 3'b010;
                end
            end

            3'b010: begin
               BTNQr <= BTN;
               STAT <= 3'b100;
            end

            3'b100: begin
               CNT <= CNT + 1;
               BTNQr <= 0;
               if (CNT==CNT_FULL) begin
                CNT <= 0;
                if (BTN==0) begin
                    STAT <= 3'b001;
                end
               end
            end

            default: begin
                STAT <= 3'b001;
                BTNQr <= 0;
            end
            endcase
        end
    end

    assign BTNQ = BTNQr;

    endmodule
`default_nettype wire