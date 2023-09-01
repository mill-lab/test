`timescale 1ns / 1ps
module nanaseg16bit_tb;

    reg RST, CLK;
    reg [3:0] VAL;
    wire [7:0] SEG;

Decoder_7seg uut (
    .VAL(VAL),
    .SEG(SEG)
);
  
always #5 CLK <= ~CLK;

initial begin
      RST <= 1;
      VAL <= 0;

      #100
      RST <= 0;

      #10
      VAL <= 4'b0011;

      #10
      VAL <= 4'b1111;
      
      #100
      $stop;
   end

endmodule
