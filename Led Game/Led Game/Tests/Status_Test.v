`define DELAY 1
`define DELAY1 2000
module Status_Test();
wire			splitter;
wire 	[6:0] point_msb,
				point_lsb,
				level_out;
wire	[9:0] led;
reg 			start, 
				reset,
				clock;
reg 	[9:0] switch;
reg	[16:0] i;

Status test (led, point_msb, point_lsb, level_out, splitter, start, reset, switch, clock);
initial
begin
	reset			= 1'b1;
	clock 		= 1'b0;
	switch		= 10'b0;
	start	= 1'b0;
	for(i = 0; i < 16'b000010000000; i = i + 1)
	begin
		#`DELAY
		clock = ~clock;
		#`DELAY
		clock = ~clock;
		$monitor("i = %1d, count = %1d, led = %d, point_msb = %1h, point_lsb = %1h, level_out = %1b",
				i, test.count, led, point_msb, point_lsb, level_out);
	end
	
	start = 1'b1;
	//switch = 10'b1000000000;
	while (test._current != 4'D0)
	begin
		#`DELAY
		clock = ~clock;
		#`DELAY
		clock = ~clock;
		$monitor("i = %1d, count = %1d, led = %d, point_msb = %1h, point_lsb = %1h, level_out = %1b",
				i, test.count, led, point_msb, point_lsb, test.level_in);
		//if(test._current == 4'd5)
		//	switch = led;
		//if(test._current == 4'D2)
		//	switch = 0;
		
	end
	reset = 1'b0;
	#`DELAY
	clock = ~clock;
	#`DELAY
	clock = ~clock;
	reset = 1'b1;
	start = 1'b0;
	#`DELAY
	clock = ~clock;
	#`DELAY
	clock = ~clock;
	start = 1'b0;
	while (test._current != 4'D0)
	begin
		#`DELAY
		clock = ~clock;
		#`DELAY
		clock = ~clock;
		$monitor("i = %1d, count = %1d, led = %d, point_msb = %1h, point_lsb = %1h, level_out = %1b",
				i, test.count, led, point_msb, point_lsb, test.level_in);
		if(test._current == 4'd5)
			switch = led;
		if(test._current == 4'D2)
			switch = 0;
	end
end
endmodule
