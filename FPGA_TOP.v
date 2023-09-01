`default_nettype none

module FPGA_TOP (
  input   wire          RESET,
  input   wire          CLK,
  // プッシュボタン入力
  input   wire          BTNU,
  input   wire          BTNL,
  input   wire          BTNC,
  input   wire          BTNR,
  input   wire          BTND,
  //
  output  wire  [11:0]  SEG,
  output  wire  [15:0]  LED
  ) ;

  wire BTNQ;

btnflt bf_uut (
    .RST(BTNC), // I
    .CLK(CLK),  // I
    .BTN(BTNR), // I
    .BTNQ(BTNQ) // O
);

cnt cnt_uut(
    .RST(BTNC), // I
    .CLK(CLK),  // I
    .BTN(BTNQ), // I
    .VAL(LED)   // O
);

assign SEG = 12'd0;


endmodule

`default_nettype wire
