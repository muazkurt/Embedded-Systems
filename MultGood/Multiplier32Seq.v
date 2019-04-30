
module Multiplier32Seq(hex0, hex1, multiplier, multiplicand, clk, rst);

output	[6:0]		hex0, hex1;
input 	[31:0]	multiplier, multiplicand;
input 				clk, rst;

wire 		[63:0]	product;



Mult32 i1(.mlier(multiplier), .mcand(multiplicand), .product(product), .clk(clk), .rst(rst));

Dec2Seg i2(.decNum(product[3:0]), .seg7(hex0));
Dec2Seg i3(.decNum(product[7:4]), .seg7(hex1));


endmodule

