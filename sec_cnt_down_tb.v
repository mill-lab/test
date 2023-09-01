`timescale 1ns/1ps
module sec_cnt_down_tb;

    reg RST, CLK, EN;
    reg [3:0] VAL_SET;
    wire [3:0] VAL;
    wire EN_SEC;

sec_cnt_down uut (
    .RST(RST),
    .CLK(CLK),
    .EN(EN),
    .VAL_SET(VAL_SET),
    .VAL(VAL),
    .EN_SEC(EN_SEC)
);
  
always #5 CLK <= ~CLK;

initial begin
      CLK <= 0;
      RST <= 1;
      EN <= 0;

      #100
      RST <= 0;

      #5
      VAL_SET <= 5;
      EN <= 1;

      #200
      EN <= 0;

      #200
      EN <= 1;
      
      #500
      RST <= 1;
      
      #5000
      $stop;
   end

endmodule
