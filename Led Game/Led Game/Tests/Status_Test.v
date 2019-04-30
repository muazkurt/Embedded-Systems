`define DELAY 20
module Status_Test();
wire	[3:0]		_next;
reg				clock;
reg 	[3:0]		_current;
reg 	[6:0]		_inputs;


Status test (_next, _inputs, _current, clock);
initial
begin
	clock 		= 1'b0;
	_inputs		= 6'b0;
	for(_current = 4'b0; _current < 4'b1010; _current = _current + 4'b1)
	begin
		#`DELAY
		clock = ~clock;
		_current = _next;
	end

	
	
	
end

initial begin
	 $monitor("clock = %1b, next = %1b, _current = %1b, _inputs = %1b",
								clock, _next, _current, _inputs);
								
end

endmodule
