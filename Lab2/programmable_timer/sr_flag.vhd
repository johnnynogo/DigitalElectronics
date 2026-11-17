library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sr_flag is
    port (
      CLK   : in std_logic;
      RST_n : in std_logic;
      set   : in std_logic;
      clear : in std_logic;
      q     : out std_logic
    );
end entity sr_flag;

architecture rtl of sr_flag is
    signal out_signal : std_logic;
begin
    process(CLK, RST_n) is
    begin
      if (RST_n = '0') then
        out_signal <= '0';
      elsif (rising_edge(CLK)) then
        if (clear = '1') then
          out_signal <= '0';
        elsif (set = '1') then
          out_signal <= '1';
        end if;
      end if;
    end process;
    q <= out_signal;
end architecture rtl;