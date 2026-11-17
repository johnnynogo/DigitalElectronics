library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbitsynchcnt is
    generic (
        N : positive := 16
    );
    port (
        CLK       : in  std_logic;
        RST_n     : in  std_logic;
        Clear     : in  std_logic;
        Enable    : in  std_logic;
        UDn       : in  std_logic;
        Count_val : out unsigned(N - 1 downto 0);
        Init_val  : in  unsigned(N - 1 downto 0);
        Load      : in  std_logic
    );
end entity nbitsynchcnt;

architecture rtl of nbitsynchcnt is
    signal count_reg : unsigned(N - 1 downto 0);
begin
    process (CLK, RST_n)
    begin
        if RST_n = '0' then
            count_reg <= (others => '0');

        elsif rising_edge(CLK) then
            if Clear = '1' then
                count_reg <= (others => '0');

            elsif Load = '1' then
                count_reg <= Init_val;

            elsif Enable = '1' then
                if UDn = '1' then
                    count_reg <= count_reg + 1;
                else
                    count_reg <= count_reg - 1;
                end if;
            end if;
        end if;
    end process;

    Count_val <= count_reg;
end architecture rtl;
