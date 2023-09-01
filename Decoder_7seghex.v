`timescale 1ns / 1ps
`default_nettype none
module Decoder_7seg(
    input wire [3:0] VAL,
    output wire[7:0] SEG
    );

	reg [7:0] buff;
	
	always @(VAL)
	begin
		case (VAL)
			4'b0000:buff <= 8'b1_1000000; //0
			4'b0001:buff <= 8'b1_1111001; //1
			4'b0010:buff <= 8'b1_0100100; //2
			4'b0011:buff <= 8'b1_0110000; //3
			4'b0100:buff <= 8'b1_0011001; //4
			4'b0101:buff <= 8'b1_0010010; //5
			4'b0110:buff <= 8'b1_0000010; //6
			4'b0111:buff <= 8'b1_1011000; //7
			4'b1000:buff <= 8'b1_0000000; //8
			4'b1001:buff <= 8'b1_0010000; //9
            4'b1010:buff <= 8'b1_0001000; //A
			4'b1011:buff <= 8'b1_0000011; //b
			4'b1100:buff <= 8'b1_0100111; //c
			4'b1101:buff <= 8'b1_0100001; //d
			4'b1110:buff <= 8'b1_0000110; //E
			4'b1111:buff <= 8'b1_0001110; //F
			default:buff <= 8'b1_1111111; //����
		endcase
	end
	
	assign SEG = buff;
	
endmodule

`default_nettype wire