`timescale 1ns/1ps
module top_tb;

    reg RST, CLK, BTN;
    wire [11:0] SEG;

FPGA_TOP uut (
    .RESET(RST),
    .CLK(CLK),
    .BTNU(),
    .BTNL(),
    .BTNC(),
    .BTNR(BTN),
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
      
      #500
      RST <= 1;
      
      #5000
      $stop;
   end

endmodule
