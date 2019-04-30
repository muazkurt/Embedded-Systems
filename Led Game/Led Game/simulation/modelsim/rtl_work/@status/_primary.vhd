library verilog;
use verilog.vl_types.all;
entity Status is
    port(
        \_next\         : out    vl_logic_vector(3 downto 0);
        \_inputs\       : in     vl_logic_vector(6 downto 0);
        \_current\      : in     vl_logic_vector(3 downto 0);
        clock           : in     vl_logic
    );
end Status;
