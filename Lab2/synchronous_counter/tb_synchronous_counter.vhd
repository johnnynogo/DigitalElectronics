library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_up_down_counter is
end entity tb_up_down_counter;

architecture sim of tb_up_down_counter is
    constant N : integer := 16;

    signal clk_tb       : std_logic;
    signal rst_n_tb     : std_logic;
    signal clear_tb     : std_logic;
    signal load_tb      : std_logic;
    signal enable_tb    : std_logic;
    signal up_dn_tb     : std_logic;
    signal init_val_tb  : unsigned(N-1 downto 0);
    signal count_val_tb : unsigned(N-1 downto 0);
begin
    uut : entity work.synchronous_counter
        generic map (
            N => N
        )
        port map (
            clk       => clk_tb,
            rst_n     => rst_n_tb,
            clear     => clear_tb,
            load      => load_tb,
            enable    => enable_tb,
            up_dn     => up_dn_tb,
            init_val  => init_val_tb,
            count_val => count_val_tb
        );

    clk_gen : process
    begin
        clk_tb <= '0';
        wait for 10 ns;
        clk_tb <= '1';
        wait for 10 ns;
    end process clk_gen;

    stimulus : process
    begin
        -- reset
        rst_n_tb    <= '0';
        clear_tb    <= '0';
        load_tb     <= '0';
        enable_tb   <= '0';
        up_dn_tb    <= '0';
        init_val_tb <= to_unsigned(7, N);
        wait for 25 ns;

        -- count up: 0 -> 1 -> 2
        rst_n_tb  <= '1';
        enable_tb <= '1';
        up_dn_tb  <= '1';
        wait for 40 ns;

        -- clear and load together: clear wins -> 0
        clear_tb    <= '1';
        load_tb     <= '1';
        init_val_tb <= to_unsigned(5, N);
        wait for 20 ns;

        -- load -> 5
        clear_tb <= '0';
        wait for 20 ns;

        -- hold -> 5
        load_tb   <= '0';
        enable_tb <= '0';
        wait for 20 ns;

        -- count down: 5 -> 4 -> 3
        enable_tb <= '1';
        up_dn_tb  <= '0';
        wait for 40 ns;

        enable_tb <= '0';
        wait;
    end process stimulus;
end architecture sim;