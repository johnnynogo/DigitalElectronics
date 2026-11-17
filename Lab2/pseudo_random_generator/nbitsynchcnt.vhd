library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbitsynchcnt is
    generic (
        N : positive := 16
    );
    port (
        clk       : in  std_logic;
        rst_n     : in  std_logic;
        clear     : in  std_logic;
        load      : in  std_logic;
        enable    : in  std_logic;
        up_dn     : in  std_logic;
        init_val  : in  unsigned(N - 1 downto 0);
        count_val : out unsigned(N - 1 downto 0)
    );
end entity nbitsynchcnt;

architecture rtl of nbitsynchcnt is
    signal count_reg : unsigned(N - 1 downto 0);
begin
    process (clk, rst_n)
    begin
        if rst_n = '0' then
            count_reg <= (others => '0');
        elsif rising_edge(clk) then
            if clear = '1' then
                count_reg <= (others => '0');
            elsif load = '1' then
                count_reg <= init_val;
            elsif enable = '1' then
                if up_dn = '1' then
                    count_reg <= count_reg + 1;
                else
                    count_reg <= count_reg - 1;
                end if;
            end if;
        end if;
    end process;

    count_val <= count_reg;
end architecture rtl;