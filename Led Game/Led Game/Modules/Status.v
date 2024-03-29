module Status(	output [9:0] led, 
					output [6:0] point_msb, 
					output [6:0] point_lsb, 
					output [6:0] point_llsb, 
					output [6:0] level_out, 
					output splitter, 
					input start, 
					input reset, 
					input [9:0] switch, 
					input clock);
	wire	 		[3:0] _current;
	reg					in,
							t_lvl,
							t_lvl_i,
							t_inp,
							t_cnt,
							t_led;
	reg			[3:0] buffer,
							level_in;
	reg			[11:0] point_in;
	reg			[9:0] led_in;
	reg			[31:0] count;
	
	
	localparam	IDLE 				= 4'D0,
					INIT 				= 4'D1,
					TEST_LEVEL		= 4'D2,
					INIT_LED			= 4'D3,
					INIT_COUNT		= 4'D4,
					TEST_COUNT		= 4'D5,
					NEG_COUNT		= 4'D6,
					TEST_INPUT		= 4'D7,
					UPDATE			= 4'D8,
					TEST_LVL_1		= 4'D9,
					NEG_LEVEL		= 4'D10,
					TEST_LED			= 4'D11,
					SHIFT_RIGHT		= 4'D12;
	 
					
	assign _current = buffer;			
	assign led = led_in;
	assign splitter = 1'b0;
	
	initial 
	begin
		buffer	<= 4'b0;
		level_in	<= 4'b0;
		point_in	<= 12'b0;
		led_in 	<= 1;
		count		<= 49999999;
	end
	always @(posedge(clock))
	begin
		if(reset == 1'b0) 
			buffer = IDLE;
		else
			case(_current) 
				IDLE:
				begin
					if(start == 1'b1) 
							buffer = IDLE;
					else	buffer = INIT;
				end
				INIT: 
				begin
					buffer = TEST_LEVEL;
				end
				TEST_LEVEL: 
				begin
					if (in == 1'b1)
							buffer = TEST_LEVEL;
					else
					begin
						if(t_lvl == 1'b0)
							buffer = INIT_LED;
						else 
							buffer = IDLE;
					end
				end
				INIT_LED:
				begin
						buffer = INIT_COUNT;
				end
				INIT_COUNT: 
				begin
						buffer = TEST_COUNT;
				end
				TEST_COUNT: 
				begin
					if (in == 1'b0)
					begin
						if(t_cnt == 1'b0) 
							buffer = NEG_COUNT;
						else
							buffer = TEST_LED;
					end
					else	buffer = TEST_INPUT;
				end
				NEG_COUNT:	
				begin
						buffer = TEST_COUNT;
				end
				TEST_INPUT:
				begin
					if(t_inp == 1'b0)
								buffer = TEST_LVL_1;
					else		buffer = UPDATE;
				end
				UPDATE:
				begin
							buffer = TEST_LEVEL;
				end
				TEST_LVL_1:
				begin
					if(t_lvl_i == 1'b0)
								buffer = NEG_LEVEL;
					else
								buffer = TEST_LEVEL;
				end		
				NEG_LEVEL:	
				begin
							buffer = TEST_LEVEL;
				end	
				TEST_LED:
				begin
					if(t_led == 1'b1)	
								buffer = TEST_LVL_1;
					else
								buffer = SHIFT_RIGHT;
				end		
				SHIFT_RIGHT:
				begin
							buffer = INIT_COUNT;
				end	
				default: 
								buffer = IDLE;
			endcase
	end

	always @( * )
	begin
		t_inp 	<= (switch == led_in);
		t_lvl 	<= (level_in == 4'b1111);
		in  		<= ((switch[9] ^ switch[8] ^ switch[7] ^ switch[6] ^ switch[5] ^ switch[4] ^ switch[3] ^ switch[2] ^ switch[1] ^ switch[0]) == 1'b1);
		t_cnt		<= (count == 1'b0);
		t_lvl_i 	<= (level_in == 4'b0);
		t_led 	<= (led_in == 1);
	end

	always @(negedge(clock))
		begin
			case (_current)
				IDLE: 
				;
				INIT:
				begin
					level_in		= 4'b0;
					point_in		= 12'b0;
				end
				TEST_LEVEL:
				;
				INIT_LED:
					led_in 		= 10'b1000000000;
				INIT_COUNT:
				begin
						
						count 	<= ((4'b1110 - level_in) + 1) << 20;
				end 
				TEST_COUNT:
				;
				NEG_COUNT:
					count			= count - 10'b1;
				TEST_INPUT:
					;
				UPDATE:
				begin
					point_in 	= point_in + level_in + 1'b1;
					level_in 	= level_in + 4'b1;
				end
				TEST_LVL_1:
				;
				NEG_LEVEL:
				begin
					point_in		= point_in - level_in;
					level_in 	= level_in - 4'b1;
				end
				TEST_LED:
				;
				SHIFT_RIGHT:
					led_in = led_in >> 1;
				default:
				;
			endcase
	
		end
	Segmenter segment_level		(level_out, level_in);
	Segmenter segment_pointLLSB (point_llsb, point_in[3:0]);
	Segmenter segment_pointLSB (point_lsb, point_in[7:4]);
	Segmenter segment_pointMSB (point_msb, point_in[11:8]);
	
endmodule

	