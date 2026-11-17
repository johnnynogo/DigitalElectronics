library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ucmp is
    generic (
        N : positive := 27
    );
    port (
        a  : in  unsigned(N - 1 downto 0);
        b  : in  unsigned(N - 1 downto 0);
        lt : out std_logic;
        eq : out std_logic;
        gt : out std_logic
    );
end entity ucmp;

architecture rtl of ucmp is
begin
    lt <= '1' when a < b else '0';
    eq <= '1' when a = b else '0';
    gt <= '1' when a > b else '0';
end architecture rtl;