library ieee;
use ieee.std_logic_1164.all;

entity toggle_ff is
    port (
        clk   : in  std_logic;
        rst_n : in  std_logic;
        t     : in  std_logic;
        q     : out std_logic
    );
end entity toggle_ff;

architecture rtl of toggle_ff is
    signal q_reg : std_logic;
begin
    process (clk, rst_n)
    begin
        if rst_n = '0' then
            q_reg <= '0';
        elsif rising_edge(clk) then
            if t = '1' then
                q_reg <= not q_reg;
            end if;
        end if;
    end process;

    q <= q_reg;
end architecture rtl;