`timescale 1ns/1ps
module deccnt_top_tb;

    reg RST, CLK, BTN;
    wire [11:0] SEG;

deccnt_top uut (
    .RESET(RST),
    .CLK(CLK),
    .BTNU(),
    .BTNL(),
    .BTNC(BTN),
    .BTNR(),
    .BTND(),
    .SEG(SEG),
    .LED(LED)
);
  
always #5 CLK <= ~CLK;

initial begin
      CLK <= 0;
      RST <= 1;
      BTN <= 0;

      #100
      RST <= 0;

      #5
      BTN <= 1;

      #200
      BTN <= 0;

      #200
      BTN <= 1;

      #200
      BTN <= 0;
      
      #5000
      $stop;
   end

endmodule
