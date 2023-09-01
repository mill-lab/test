module btnflt_tb;

    reg RST, CLK, BTN;
    wire BTNQ;

btnflt uut (
    .RST(RST),
    .CLK(CLK),
    .BTN(BTN),
    .BTNQ(BTNQ)
);
  
always #5 CLK <= ~CLK;

initial begin
      CLK <= 0;
      RST <= 1;
      BTN <= 0;

      #20
      RST <= 0;

      #1 // button on
      BTN <= 1;

      #5 // chattering
      BTN <= 0;
      
      #5
      BTN <= 1;
      
      #5
      BTN <= 0;
      
      #5
      BTN <= 1;

      #300 // button off
      BTN <= 0;

      #5 // chattering
      BTN <= 1;
      
      #5
      BTN <= 0;

      #5
      BTN <= 1;
      
      #5
      BTN <= 0;

      #500
      $stop;
   end

endmodule
