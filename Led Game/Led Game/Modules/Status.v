module Status(output [9:0] led, output [6:0] point_msb, output [6:0] point_lsb, output [6:0] level_out, output splitter, input start, input [9:0] switch, input clock);
	wire	 		[3:0] _current;
	reg					in,
							t_lvl,
							t_lvl_i,
							t_inp,
							t_cnt,
							t_led;
	reg			[3:0] buffer,
							level_in;
	reg			[7:0] point_in;
	reg			[9:0] led_in;
	reg			[15:0] count;
	
	
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
	assign splitter = 1'b1;
	
	initial buffer	<= 4'b0;
	always @(posedge(clock))
	begin
		case(_current) 
			IDLE: 
				if(start == 1'b0) 
						buffer = IDLE;
				else	buffer = INIT;
				
			INIT: 
						buffer = TEST_LEVEL;
			
			TEST_LEVEL: 
				if(t_lvl == 1'b0)
						buffer = INIT_LED;
				else 	buffer = IDLE;
				
			INIT_LED:	
						buffer = INIT_COUNT;
			
			INIT_COUNT: 
							buffer = TEST_COUNT;
			
			TEST_COUNT: 
				if(t_cnt == 1'b0) 
				begin
					if (in == 1'b0)
						buffer = NEG_COUNT;
					else	
						buffer = TEST_INPUT;
				end 
				else		buffer = TEST_LED;
				
			NEG_COUNT:	
							buffer = TEST_COUNT;
							
			TEST_INPUT:
				if(t_inp == 1'b0)
							buffer = TEST_LVL_1;
				else		buffer = UPDATE;
				
			UPDATE:		
							buffer = TEST_LEVEL;
							
			TEST_LVL_1:
				if(t_lvl_i == 1'b0)
							buffer = NEG_LEVEL;
				else
							buffer = TEST_LEVEL;
							
			NEG_LEVEL:	
							buffer = TEST_LEVEL;
							
			TEST_LED:
				if(t_led == 1'b0)	
							buffer = NEG_LEVEL;
				else
							buffer = SHIFT_RIGHT;
							
			SHIFT_RIGHT:
							buffer = INIT_COUNT;
							
			default: 
							buffer = IDLE;
		endcase
	end
	

	always @( * )
	if(clock == 1'b1)
		begin
			case (_current)
				IDLE: 
				;
				INIT:
				begin
					level_in	= 6'b0;
					point_in	= 7'b0;
				end
				TEST_LEVEL:
					if(level_in == 4'b1111)
						t_lvl = 1;
					else
						t_lvl = 0;
				INIT_LED:
					led_in = 9'b1000000000;
				INIT_COUNT:
					count = (6'b111111 - level_in) << 10;
				TEST_COUNT:
					if(count == 16'b0)
						t_cnt = 1;
					else
					begin
						if(switch > 10'b0 && (switch[9] ^ switch[8] ^ switch[7] ^ switch[6] ^ switch[5] ^ switch[4] ^ switch[3] ^ switch[2] ^ switch[1] ^ switch[0]))
							in = 1'b1;
						else
							in = 1'b0;
						t_cnt = 0;
					end
				NEG_COUNT:
					count = count - 1;
				TEST_INPUT:
					if(switch == led_in)
						t_inp = 1'b1;
					else
						t_inp = 1'b0;
				UPDATE:
				begin
					point_in = point_in + level_in + 1'b1;
					level_in = level_in + 6'b1;
				end
				TEST_LVL_1:
					if(level_in == 4'b0)
						t_lvl_i = 1'b1;
					else
						t_lvl_i = 1'b0;
				NEG_LEVEL:
					level_in = level_in - 6'b1;
				TEST_LED:
					if(led_in == 10'b1)
						t_led = 1'b1;
					else
						t_led = 1'b0;
				SHIFT_RIGHT:
					led_in = led_in >> 1;
				default:
				;
			endcase
		end
	
	Segmenter segment_level		(level_out, level_in);
	Segmenter segment_pointLSB (point_lsb, point_in[3:0]);
	Segmenter segment_pointMSB (point_msb, point_in[7:4]);
	
endmodule

	