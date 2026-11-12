library ieee;
use ieee.std_logic_1164.all;

entity two_to_one_mux is
    port (
        SW   : in  std_logic_vector(9 downto 0);
        LEDR : out std_logic_vector(3 downto 0)
    );
end entity two_to_one_mux;

architecture rtl of two_to_one_mux is
begin
    LEDR <= SW(3 downto 0) when SW(8) = '0'
            else SW(7 downto 4);
end architecture rtl;
