library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ucmp is
    generic (
        N : positive := 27
    );
    port (
        A  : in  unsigned(N - 1 downto 0);
        B  : in  unsigned(N - 1 downto 0);
        LT : out std_logic;
        EQ : out std_logic;
        GT : out std_logic
    );
end entity ucmp;

architecture rtl of ucmp is
begin
    LT <= '1' when A < B else '0';
    EQ <= '1' when A = B else '0';
    GT <= '1' when A > B else '0';
end architecture rtl;
