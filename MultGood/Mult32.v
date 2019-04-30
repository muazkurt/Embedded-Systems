module Mult32(product, mcand, mlier, clk, rst);

output 		[63:0]	product;
input			[31:0]	mcand, mlier;
input 					clk, rst;

reg 			[1:0]		state, nextstate;

wire 			[5:0]		it;
reg ldrstcounter, ldp, ldlier, ldcand, ldsum, ldshift, ldencounter;

MultCirc i1(
.product(product), 
.counter(it), 
.multiplier(mlier), 
.multiplicand(mcand), 
.clk(clk), 
.ldrstcounter(ldrstcounter),
.ldencounter(ldencounter), 
.ldp(ldp), 
.ldlier(ldlier), 
.ldcand(ldcand), 
.ldsum(ldsum), 
.ldshift(ldshift));


localparam STATE_IDLE 	= 2'd0;
localparam STATE_TEST 	= 2'd1;
localparam STATE_ADD 	= 2'd2;
localparam STATE_SHIFT 	= 2'd3;


//Design Sequential Logic
always @ (posedge clk) begin
	if(rst) state <= STATE_IDLE;
	else 	  state <= nextstate;	
end


//Deisgn Combinational Logic
always @(*) begin

	case(state) 
		
		STATE_IDLE: begin
			nextstate = STATE_TEST;				
		end
		
		STATE_TEST: begin
			if(it == 32) begin 
				nextstate = STATE_TEST;
				end
			else begin
				if(product[0]) nextstate = STATE_ADD;
				else nextstate = STATE_SHIFT;
			end
		end
		
		STATE_ADD: begin
			nextstate = STATE_SHIFT;
		end
		
		STATE_SHIFT: begin
			nextstate = STATE_TEST;
		end
			

	endcase

end



//Design FSM Outputs
always@(state) begin

	case(state) 
		
		STATE_IDLE: begin
			ldrstcounter = 1;
			ldencounter = 0;
			ldp = 1;
			ldlier = 1; 
			ldcand = 1; 
			ldsum = 0; 
			ldshift = 0;		
		end
		
		STATE_TEST: begin
			ldrstcounter = 0;
			ldencounter = 0;
			ldp = 0;
			ldlier = 0; 
			ldcand = 0; 
			ldsum = 0; 
			ldshift = 0;
		end
		
		STATE_ADD: begin
			ldrstcounter = 0;
			ldencounter = 0;
			ldp = 1;
			ldlier = 0; 
			ldcand = 0; 
			ldsum = 1; 
			ldshift = 0;
		end
		
		STATE_SHIFT: begin
			ldrstcounter = 0;
			ldencounter = 1;
			ldp = 0;
			ldlier = 0; 
			ldcand = 0; 
			ldsum = 0; 
			ldshift = 1;		
		end
			

	endcase

end

endmodule


	