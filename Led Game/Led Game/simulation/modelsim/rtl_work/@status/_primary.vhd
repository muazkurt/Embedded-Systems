library verilog;
use verilog.vl_types.all;
entity Status is
    port(
        led             : out    vl_logic_vector(9 downto 0);
        point_msb       : out    vl_logic_vector(6 downto 0);
        point_lsb       : out    vl_logic_vector(6 downto 0);
        level_out       : out    vl_logic_vector(6 downto 0);
        splitter        : out    vl_logic;
        start           : in     vl_logic;
        switch          : in     vl_logic_vector(9 downto 0);
        clock           : in     vl_logic
    );
end Status;
