// Takes 4 bit decimal digit shows on the 7 segment
/*
Common Anode
0 = 01
1 = 4F
2 = 12
3 = 06
4 = 4C
5 = 24
6 = 20
7 = 0F
8 = 00
9 = 04

*/

module Dec2Seg(decNum, seg7);

input 		[3:0]		decNum;
output 		[6:0]		seg7;

reg			[6:0]		seg7reg;

assign seg7 = seg7reg;


always @(*) begin

	case(decNum) 
		4'h0: seg7reg = 7'b1000000;
		4'h1: seg7reg = 7'b1111001;
		4'h2: seg7reg = 7'b0100100;
		4'h3: seg7reg = 7'b0110000;
		4'h4: seg7reg = 7'b0011001;
		4'h5: seg7reg = 7'b0010010;
		4'h6: seg7reg = 7'b0000010;
		4'h7: seg7reg = 7'b1111000;
		4'h8: seg7reg = 7'b0000000;
		4'h9: seg7reg = 7'b0010000;
		4'hA: seg7reg = 7'b0001000;
		4'hB: seg7reg = 7'b0000011;
		4'hC: seg7reg = 7'b1000110;
		4'hD: seg7reg = 7'b0100001;
		4'hE: seg7reg = 7'b0000110;
		4'hF: seg7reg = 7'b0001110;
		
		default: seg7reg = 7'b1111111;
	endcase
end



endmodule
	
