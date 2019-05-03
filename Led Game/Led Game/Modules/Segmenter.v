module Segmenter(output reg	[6:0] s_segment,
						input 		[3:0] _points);
											//6543210
	localparam	hex_o				= 7'b1000000,
					hex_i				= 7'b1111001,
					hex_ii			= 7'b0100100,
					hex_iii			= 7'b0110000,
					hex_iv			= 7'b0011001,
					hex_v				= 7'b0010010,
					hex_vi			= 7'b0000010,
					hex_vii			= 7'b1111000,
					hex_viii			= 7'b0000000,
					hex_ix			= 7'b0010000,
					hex_a				= 7'b0001000,
					hex_b				= 7'b0000011,
					hex_c				= 7'b1000110,
					hex_d				= 7'b0100001,
					hex_e				= 7'b0000110,
					hex_f				= 7'b0001110;
					
	always @( * )
	begin
		case (_points)
			4'd0:		s_segment = hex_o;
			4'd1:		s_segment = hex_i;
			4'd2:		s_segment = hex_ii;
			4'd3:		s_segment = hex_iii;
			4'd4:		s_segment = hex_iv;
			4'd5:		s_segment = hex_v;
			4'd6:		s_segment = hex_vi;
			4'd7:		s_segment = hex_vii;
			4'd8:		s_segment = hex_viii;
			4'd9:		s_segment = hex_ix;
			4'd10:	s_segment = hex_a;
			4'd11:	s_segment = hex_b;
			4'd12:	s_segment = hex_c;
			4'd13:	s_segment = hex_d;
			4'd14:	s_segment = hex_e;
			4'd15:	s_segment = hex_f;
		endcase
	end
endmodule
