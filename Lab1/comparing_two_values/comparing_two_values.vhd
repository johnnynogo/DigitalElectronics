library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparing_two_values is
    port (
        SW   : in  std_logic_vector(7 downto 0);
        HEX1 : out std_logic_vector(0 to 6);
        HEX0 : out std_logic_vector(0 to 6);
        LEDR : out std_logic_vector(5 downto 0)
    );
end entity comparing_two_values;

architecture rtl of comparing_two_values is
begin
    hex1_decoder : entity work.ssd
        port map (
            SW   => SW(7 downto 4),
            HEX0 => HEX1
        );

    hex0_decoder : entity work.ssd
        port map (
            SW   => SW(3 downto 0),
            HEX0 => HEX0
        );

    unsigned_comparator : entity work.ucmp
        port map (
            A  => unsigned(SW(7 downto 4)),
            B  => unsigned(SW(3 downto 0)),
            LT => LEDR(0),
            EQ => LEDR(1),
            GT => LEDR(2)
        );

    signed_comparator : entity work.scmp
        port map (
            A  => signed(SW(7 downto 4)),
            B  => signed(SW(3 downto 0)),
            LT => LEDR(3),
            EQ => LEDR(4),
            GT => LEDR(5)
        );
end architecture rtl;
