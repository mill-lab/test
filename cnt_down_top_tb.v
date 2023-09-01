`timescale 1ns/1ps
module cnt_down_top_tb;

    reg RST, CLK, BTNC, BTNR;
    wire [11:0] SEG;

cnt_down_top uut (
    .RESET(RST),
    .CLK(CLK),
    .BTNU(),
    .BTNL(),
    .BTNC(BTNC),
    .BTNR(BTNR),
    .BTND(),
    .SEG(SEG),
    .LED(LED)
);
  
always #5 CLK <= ~CLK;

initial begin
      CLK <= 0;
      RST <= 1;
      BTNC <= 0;
      BTNR <= 0;

      #100
      RST <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNC <= 1;

      #100
      BTNC <= 0;

      #500
      RST <= 1;

      #100
      RST <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;

      #200
      BTNR <= 1;

      #20
      BTNR <= 0;
      
      #50000
      $stop;
   end

endmodule
