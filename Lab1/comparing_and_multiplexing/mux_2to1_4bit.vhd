library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1_4bit is
    port (
        X : in  std_logic_vector(3 downto 0);
        Y : in  std_logic_vector(3 downto 0);
        S : in  std_logic;
        M : out std_logic_vector(3 downto 0)
    );
end entity mux_2to1_4bit;

architecture rtl of mux_2to1_4bit is
begin
    M <= X when S = '0' else Y;
end architecture rtl;
