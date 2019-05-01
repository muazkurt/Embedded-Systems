library verilog;
use verilog.vl_types.all;
entity Segmenter is
    port(
        s_segment       : out    vl_logic_vector(6 downto 0);
        \_points\       : in     vl_logic_vector(3 downto 0)
    );
end Segmenter;
