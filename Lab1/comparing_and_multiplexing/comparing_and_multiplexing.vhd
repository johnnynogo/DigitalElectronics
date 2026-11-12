
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparing_and_multiplexing is
    port (
        SW   : in  std_logic_vector(9 downto 0);
        HEX1 : out std_logic_vector(0 to 6);
        HEX0 : out std_logic_vector(0 to 6);
        LEDR : out std_logic_vector(5 downto 0)
    );
end entity comparing_and_multiplexing;

architecture rtl of comparing_and_multiplexing is
    signal a_mux : std_logic_vector(3 downto 0);
    signal b_mux : std_logic_vector(3 downto 0);
begin
    mux_a : entity work.mux_2to1_4bit
        port map (
            X => SW(7 downto 4),
            Y => "1000",
            S => SW(9),
            M => a_mux
        );

    mux_b : entity work.mux_2to1_4bit
        port map (
            X => SW(3 downto 0),
            Y => "1101",
            S => SW(8),
            M => b_mux
        );

    hex1_decoder : entity work.ssd
        port map (
            SW   => a_mux,
            HEX0 => HEX1
        );

    hex0_decoder : entity work.ssd
        port map (
            SW   => b_mux,
            HEX0 => HEX0
        );

    unsigned_comparator : entity work.ucmp
        port map (
            A  => unsigned(a_mux),
            B  => unsigned(b_mux),
            LT => LEDR(0),
            EQ => LEDR(1),
            GT => LEDR(2)
        );

    signed_comparator : entity work.scmp
        port map (
            A  => signed(a_mux),
            B  => signed(b_mux),
            LT => LEDR(3),
            EQ => LEDR(4),
            GT => LEDR(5)
        );
end architecture rtl;
