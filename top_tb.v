module top_tb;

    reg RST, CLK, BTN;
    wire [15:0] LED;

FPGA_TOP uut (
    .RESET(),
    .CLK(CLK),
    .BTNU(),
    .BTNL(),
    .BTNC(RST),
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

      #1
      BTN <= 1;

      #200
      BTN <= 0;
      
      #500
      RST <= 1;
      
      #500
      $stop;
   end

endmodule
