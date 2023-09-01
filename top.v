`default_nettype none

module FPGA_TOP (
  input   wire          RESET,
  input   wire          SW1,
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

  wire SEG_W, SEG_T;

deccnt_top dt (
    .RESET(RESET | ~SW1),
    .CLK(CLK),
    .BTNU(BTNU),
    .BTNL(BTNL),
    .BTNC(BTNC),
    .BTNR(BTNR),
    .BTND(BTND),
    .SEG(SEG_W),
    .LED()
);

cnt_down_top uut (
    .RESET(RESET | SW1),
    .CLK(CLK),
    .BTNU(BTNU),
    .BTNL(BTNL),
    .BTNC(BTNC),
    .BTNR(BTNR),
    .BTND(BTND),
    .SEG(SEG_T),
    .LED()
);

assign SEG = SW1 ? SEG_T : SEG_W;
assign LED[15:0] = 16'd0;

endmodule

`default_nettype wire
