library ieee;
use ieee.std_logic_1164.all;

entity se_detector is
    port (
        CLK      : in  std_logic;
        RST_n    : in  std_logic;
        Button_n : in  std_logic;
        Level    : out std_logic;
        Pulse    : out std_logic
    );
end entity se_detector;

architecture rtl of se_detector is
    signal sync1 : std_logic;
    signal sync2 : std_logic;
    signal prev  : std_logic;
begin
    process (CLK, RST_n)
    begin
        if RST_n = '0' then
            sync1 <= '0';
            sync2 <= '0';
            prev  <= '0';

        elsif rising_edge(CLK) then
            sync1 <= not Button_n;
            sync2 <= sync1;
            prev  <= sync2;
        end if;
    end process;

    Level <= sync2;
    Pulse <= sync2 and not prev;
end architecture rtl;
