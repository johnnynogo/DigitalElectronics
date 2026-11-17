library ieee;
use ieee.std_logic_1164.all;

entity tff is
    port (
        CLK   : in  std_logic;
        RST_n : in  std_logic;
        T     : in  std_logic;
        Q     : out std_logic
    );
end entity tff;

architecture rtl of tff is
    signal q_reg : std_logic;
begin
    process (CLK, RST_n)
    begin
        if RST_n = '0' then
            q_reg <= '0';

        elsif rising_edge(CLK) then
            if T = '1' then
                q_reg <= not q_reg;
            end if;
        end if;
    end process;

    Q <= q_reg;
end architecture rtl;
