library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
    port (
        clk     : in  std_logic;
        rst_n   : in  std_logic;
        load    : in  std_logic;
        sw_seed : in  std_logic_vector(9 downto 0);
        enable  : in  std_logic;
        q       : out std_logic_vector(9 downto 0)
    );
end entity lfsr;

architecture rtl of lfsr is
    signal lfsr_reg : std_logic_vector(9 downto 0);
begin
    process (clk, rst_n)
    begin
        if rst_n = '0' then
            lfsr_reg <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                lfsr_reg <= sw_seed;
            elsif enable = '1' then
                lfsr_reg <= lfsr_reg(0) &
                            lfsr_reg(9 downto 8) &
                            (lfsr_reg(7) xor lfsr_reg(0)) &
                            lfsr_reg(6 downto 1);
            end if;
        end if;
    end process;

    q <= lfsr_reg;
end architecture rtl;