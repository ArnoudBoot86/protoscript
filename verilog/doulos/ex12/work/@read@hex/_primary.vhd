library verilog;
use verilog.vl_types.all;
entity ReadHex is
    generic(
        Amax            : integer := 100
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Amax : constant is 1;
end ReadHex;
