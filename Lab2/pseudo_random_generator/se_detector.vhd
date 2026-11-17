library ieee;
use ieee.std_logic_1164.all;

entity se_detector is
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        button_n : in  std_logic;
        level    : out std_logic;
        pulse    : out std_logic
    );
end entity se_detector;

architecture rtl of se_detector is
    signal sync1 : std_logic;
    signal sync2 : std_logic;
    signal prev  : std_logic;
begin
    process (clk, rst_n)
    begin
        if rst_n = '0' then
            sync1 <= '0';
            sync2 <= '0';
            prev  <= '0';
        elsif rising_edge(clk) then
            sync1 <= not button_n;
            sync2 <= sync1;
            prev  <= sync2;
        end if;
    end process;

    level <= sync2;
    pulse <= sync2 and not prev;
end architecture rtl;