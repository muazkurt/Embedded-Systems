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
	reg			[9:0] led_in,
							switch_old;
	reg			[10:0] count;
	
	
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
	
	initial 
	begin
		buffer	<= 4'b0;
		level_in	<= 4'b0;
		point_in	<= 8'b0;
		led_in 	<= 10'b0;
	end
	always @(posedge(clock))
	begin
		case(_current) 
			IDLE:
			begin
				if(start == 1'b0) 
						buffer = IDLE;
				else	buffer = INIT;
			end
			INIT: 
						buffer = TEST_LEVEL;
			
			TEST_LEVEL: 
			begin
				if(t_lvl == 1'b0)
						buffer = INIT_LED;
				else 	buffer = IDLE;
			end
			INIT_LED:	
						buffer = INIT_COUNT;
			
			INIT_COUNT: 
							buffer = TEST_COUNT;
			
			TEST_COUNT: 
			begin
				if(t_cnt == 1'b0) 
				begin
					if (in == 1'b0)
						buffer = NEG_COUNT;
					else	
						buffer = TEST_INPUT;
				end 
				else		buffer = TEST_LED;
			end
			NEG_COUNT:	
							buffer = TEST_COUNT;
							
			TEST_INPUT:
			begin
				if(t_inp == 1'b0)
							buffer = TEST_LVL_1;
				else		buffer = UPDATE;
			end
			UPDATE:
							buffer = TEST_LEVEL;
							
			TEST_LVL_1:
			begin
				if(t_lvl_i == 1'b0)
							buffer = NEG_LEVEL;
				else
							buffer = TEST_LEVEL;
			end		
			NEG_LEVEL:	
							buffer = TEST_LEVEL;
							
			TEST_LED:
			begin
				if(t_led == 1'b1)	
							buffer = TEST_LVL_1;
				else
							buffer = SHIFT_RIGHT;
			end		
			SHIFT_RIGHT:
							buffer = INIT_COUNT;
							
			default: 
							buffer = IDLE;
		endcase
	end
	

	always @( * )
	if(clock == 1'b0)
		begin
			if(in == 1'b1 && switch == led_in)
				t_inp <= 1'b1;
			else
				t_inp <= 1'b0;
			if(level_in == 4'b1111)
				t_lvl <= 1'b1;
			else
				t_lvl <= 1'b0;
			if(switch != switch_old)
			begin
				switch_old <= switch;
				if(switch > 10'd0)
					in <= 1'b1;
				else
					in <= 1'b0;
			end
			if(count == 1'b0 && in == 1'b0)
				t_cnt <= 1'b1;
			else
				t_cnt <= 1'b0;
			if(level_in == 4'b0)
				t_lvl_i <= 1'b1;
			else
				t_lvl_i <= 1'b0;
			if(led_in == 10'd1)
				t_led <= 1'b1;
			else
				t_led <= 1'b0;
			case (_current)
				IDLE: 
				begin
							in 		<= 0;
							t_lvl		<= 0;
							t_lvl_i	<= 0;
							t_inp		<= 0;
							t_cnt		<= 0;
							t_led		<= 0;
				end
				INIT:
				begin
					level_in		= 4'b0;
					point_in		= 8'b0;
					switch_old	<= 10'b0;
				end
				TEST_LEVEL:
				;
				INIT_LED:
					led_in 		= 10'b1000000000;
				INIT_COUNT:
				begin
					count 		= (4'b1110 - level_in) << 6;
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
					level_in 	= level_in - 4'b1;
				TEST_LED:
				;
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

	