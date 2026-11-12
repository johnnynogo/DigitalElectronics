library ieee;
use ieee.std_logic_1164.all;

entity controlling_leds is
    port (
        SW   : in  std_logic_vector(9 downto 0);
        LEDR : out std_logic_vector(9 downto 0)
    );
end entity controlling_leds;

architecture rtl of controlling_leds is
begin
    LEDR <= SW;
end architecture rtl;
