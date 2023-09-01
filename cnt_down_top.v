`default_nettype none

module cnt_down_top (
  input   wire          RESET,
  input   wire          CLK,
  // push button input
  input   wire          BTNU,
  input   wire          BTNL,
  input   wire          BTNC,
  input   wire          BTNR,
  input   wire          BTND,
  //
  output  wire  [11:0]  SEG,
  output  wire  [15:0]  LED
  ) ;

parameter [31:0] CNT_FULL = 100_000;
//parameter [31:0] CNT_FULL = 10;

  wire BTNCQ, BTNRQ;
  wire [15:0] VAL;
  wire DONE;

btnflt bfc_uut (
    .RST(RESET), // I
    .CLK(CLK),   // I
    .BTN(BTNC),  // I
    .BTNQ(BTNCQ) // O
);

btnflt bfr_uut (
    .RST(RESET), // I
    .CLK(CLK),   // I
    .BTN(BTNR),  // I
    .BTNQ(BTNRQ) // O
);

wire SW_COUT0, SW_COUT1, SW_COUT2;
wire [15:0] VAL_SET;

SW_digit0 SWdig0(
    .RST(RESET),    // I
    .CLK(CLK),      // I
    .BTN(BTNRQ),     // I
    .VAL(VAL_SET[3:0]), // O
    .COUT0(SW_COUT0)   // O
);

SW_digit1 SWdig1(
    .RST(RESET),     // I
    .CLK(CLK),       // I
    .COUT0(SW_COUT0),   // I
    .VAL(VAL_SET[7:4]),  // O
    .COUT1(SW_COUT1)    // O
);

SW_digit2 SWdig2(
    .RST(RESET),     // I
    .CLK(CLK),       // I
    .COUT0(SW_COUT0),   // I
    .COUT1(SW_COUT1),   // I
    .VAL(VAL_SET[11:8]), // O
    .COUT2(SW_COUT2)    // O
);

SW_digit3 SWdig3(
    .RST(RESET),      // I
    .CLK(CLK),        // I
    .COUT0(SW_COUT0),    // I
    .COUT1(SW_COUT1),    // I
    .COUT2(SW_COUT2),    // I
    .VAL(VAL_SET[15:12])  // O
);

wire CDD_COUT0, CDD_COUT1, CDD_COUT2, BUSY;
assign DONE = ((VAL == 0) & BUSY);

cnt_down_digit0 cddig0(
    .RST(RESET),    // I
    .CLK(CLK),      // I
    .BTN(BTNCQ),    // I
    .DONE(DONE),
    .VAL_SET(VAL_SET[3:0]), // I
    .VAL(VAL[3:0]), // O
    .COUT0(CDD_COUT0),   // O
    .BUSY(BUSY)
);

cnt_down_digit1 cddig1(
    .RST(RESET),     // I
    .CLK(CLK),       // I
    .COUT0(CDD_COUT0),   // I
    .BUSY(BUSY),
    .VAL_SET(VAL_SET[7:4]), // I
    .VAL(VAL[7:4]),  // O
    .COUT1(CDD_COUT1)    // O
);

cnt_down_digit2 cddig2(
    .RST(RESET),     // I
    .CLK(CLK),       // I
    .COUT0(CDD_COUT0),   // I
    .COUT1(CDD_COUT1),   // I
    .BUSY(BUSY),
    .VAL_SET(VAL_SET[11:8]), // I
    .VAL(VAL[11:8]), // O
    .COUT2(CDD_COUT2)    // O
);

cnt_down_digit3 cddig3(
    .RST(RESET),      // I
    .CLK(CLK),        // I
    .COUT0(CDD_COUT0),    // I
    .COUT1(CDD_COUT1),    // I
    .COUT2(CDD_COUT2),    // I
    .BUSY(BUSY),
    .VAL_SET(VAL_SET[15:12]), // I
    .VAL(VAL[15:12])  // O
);

wire [7:0] SEG0, SEG1, SEG2, SEG3;

Decoder_7seg D7_1(
    .VAL(VAL[3:0]),        // I
    .SEG(SEG0)             // O
);

Decoder_7seg D7_2(
    .VAL(VAL[7:4]),        // I
    .SEG(SEG1)             // O
);

Decoder_7seg D7_3(
    .VAL(VAL[11:8]),       // I
    .SEG(SEG2)             // O
);

Decoder_7seg D7_4(
    .VAL(VAL[15:12]),      // I
    .SEG(SEG3)             // O
);

reg [3:0] ANODE = 4'b1110;
reg [31:0] CNT;

always @ (posedge CLK) begin // Anode control
    if (RESET) begin
        ANODE <= 4'b1110;
        CNT <= 0;
    end else begin
        CNT <= CNT + 1;
        if (CNT == CNT_FULL) begin
            ANODE <= {ANODE[2:0], ANODE[3]};
            CNT <= 0;
        end
    end
end

assign SEG[7:0] = ~ANODE[0] ? SEG0 :
                  ~ANODE[1] ? SEG1 :
                  ~ANODE[2] ? SEG2 :
                  ~ANODE[3] ? SEG3 : 0;
assign SEG[11:8] = ANODE;

endmodule

`default_nettype wire
