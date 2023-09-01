module cnt_tb;

    reg RST, CLK, BTN;
    wire [15:0] VAL;

cnt uut (
    .RST(RST),
    .CLK(CLK),
    .BTN(BTN),
    .VAL(VAL)
);
  
always #5 CLK <= ~CLK;

initial begin
      CLK <= 0;
      RST <= 1;
      BTN <= 0;

      #20
      RST <= 0;

      #1
      BTN <= 1;

      #30
      BTN <= 0;
      
      #500
      RST <= 1;
      
      #100
      $stop;
   end

endmodule
