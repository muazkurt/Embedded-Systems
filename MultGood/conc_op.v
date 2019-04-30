`timescale 1ps/1ps
module conc_op();
  
  reg 	[31:0]	multiplier;
  reg 	[31:0]	multiplicand;
  wire 	[63:0]	product;
  
  reg clk, rst;
  reg		[31:0]	counter;
  //reg 	[7:0] 	swsim;
  //wire 	[6:0] 	hexsim0, hexsim1;
 
  
  //Multiplier32Seq i1(.hex0(hexsim0), .hex1(hexsim1), .multiplier({28'd0, swsim[3:0]}), .multiplicand({28'd0, swsim[7:4]}), .clk(clk), .rst(rst));

  Mult32 i1(.mlier(multiplier), .mcand(multiplicand), .product(product), .clk(clk), .rst(rst));
  
  always 
	begin
			#5 clk <= ~clk;
	end
  
  initial begin
	 counter = 0;
	 clk = 0;
    multiplier = 32'd100;
	 multiplicand = 32'd25;
	 //swsim[3:0] = 4'b0011;
	 //swsim[7:4] = 4'b0110;
	 //en = 1'b1;
	 rst = 1'b1;
  end
  
  always @(negedge clk) begin
	
	$display("STATE = %d", i1.state);
	$display("ITERATION = %d", i1.it);
	
	counter <= counter + 1;
	
	if(counter % 128 == 5) rst <= 1'b0;
	
	if(counter % 128 == 0) begin 
		rst <= 1'b1;
		//swsim[3:0] = swsim[3:0] + 1;
		//swsim[7:4] = swsim[7:4] + 1;
		multiplier <= multiplier + 32'd5;
		multiplicand <= multiplicand + 32'd5;
	end
		
end 
  
 endmodule
 