`default_nettype none

module SW_top (
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

  wire BTNQ;
  wire [15:0] VAL;

btnflt bf_uut (
    .RST(RESET), // I
    .CLK(CLK),   // I
    .BTN(BTNC),  // I
    .BTNQ(BTNQ)  // O
);

wire COUT0, COUT1, COUT2;

SW_digit0 SWdig0(
    .RST(RESET),    // I
    .CLK(CLK),      // I
    .BTN(BTNQ),     // I
    .VAL(VAL[3:0]), // O
    .COUT0(COUT0)   // O
);

SW_digit1 SWdig1(
    .RST(RESET),     // I
    .CLK(CLK),       // I
    .COUT0(COUT0),   // I
    .VAL(VAL[7:4]),  // O
    .COUT1(COUT1)    // O
);

SW_digit2 SWdig2(
    .RST(RESET),     // I
    .CLK(CLK),       // I
    .COUT0(COUT0),   // I
    .COUT1(COUT1),   // I
    .VAL(VAL[11:8]), // O
    .COUT2(COUT2)    // O
);

SW_digit3 SWdig3(
    .RST(RESET),      // I
    .CLK(CLK),        // I
    .COUT0(COUT0),    // I
    .COUT1(COUT1),    // I
    .COUT2(COUT2),    // I
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
assign LED[0] = RESET;
assign LED[15:1] = 15'd0;

endmodule

`default_nettype wire
