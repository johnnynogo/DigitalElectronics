library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is
end entity tb_top;

architecture sim of tb_top is
    signal clock_50_tb : std_logic;
    signal key_tb      : std_logic_vector(3 downto 0);
    signal sw_tb       : std_logic_vector(9 downto 0);
    signal ledr_tb     : std_logic_vector(9 downto 0);
begin
    uut : entity work.pseudo_random_generator
        generic map (
            T_WAIT => 4
        )
        port map (
            CLOCK_50 => clock_50_tb,
            KEY      => key_tb,
            SW       => sw_tb,
            LEDR     => ledr_tb
        );

    clk_gen : process
    begin
        clock_50_tb <= '0';
        wait for 10 ns;
        clock_50_tb <= '1';
        wait for 10 ns;
    end process clk_gen;

    stimulus : process
    begin
        -- reset, seed on switches
        key_tb <= "1110";
        sw_tb  <= "1000000001";
        wait for 60 ns;

        -- release reset, press KEY(1): load seed
        key_tb(0) <= '1';
        key_tb(1) <= '0';
        wait for 60 ns;
        key_tb(1) <= '1';
        wait for 60 ns;

        -- press KEY(2): start
        key_tb(2) <= '0';
        wait for 40 ns;
        key_tb(2) <= '1';
        wait for 400 ns;

        -- press KEY(2): stop
        key_tb(2) <= '0';
        wait for 40 ns;
        key_tb(2) <= '1';
        wait for 200 ns;

        wait;
    end process stimulus;
end architecture sim;