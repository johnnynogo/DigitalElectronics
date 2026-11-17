library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pseudo_random_generator is
    generic (
        N      : integer := 27;
        T_WAIT : integer := 100_000_000
    );
    port (
        CLOCK_50 : in  std_logic;
        KEY      : in  std_logic_vector(3 downto 0);
        SW       : in  std_logic_vector(9 downto 0);
        LEDR     : out std_logic_vector(9 downto 0)
    );
end entity pseudo_random_generator;

architecture rtl of pseudo_random_generator is
    constant LIMIT : unsigned(N - 1 downto 0) := to_unsigned(T_WAIT - 1, N);
    constant ZERO  : unsigned(N - 1 downto 0) := (others => '0');

    signal load       : std_logic;
    signal key2_pulse : std_logic;
    signal run        : std_logic;
    signal tick       : std_logic;
    signal count      : unsigned(N - 1 downto 0);
begin
    sync_k1 : entity work.se_detector
        port map (
            clk      => CLOCK_50,
            rst_n    => KEY(0),
            button_n => KEY(1),
            level    => load,
            pulse    => open
        );

    sync_k2 : entity work.se_detector
        port map (
            clk      => CLOCK_50,
            rst_n    => KEY(0),
            button_n => KEY(2),
            level    => open,
            pulse    => key2_pulse
        );

    u_tff : entity work.toggle_ff
        port map (
            clk   => CLOCK_50,
            rst_n => KEY(0),
            t     => key2_pulse,
            q     => run
        );

    u_cnt : entity work.nbitsynchcnt
        generic map (
            N => N
        )
        port map (
            clk       => CLOCK_50,
            rst_n     => KEY(0),
            clear     => tick,
            load      => '0',
            enable    => run,
            up_dn     => '1',
            init_val  => ZERO,
            count_val => count
        );

    u_cmp : entity work.ucmp
        generic map (
            N => N
        )
        port map (
            a  => count,
            b  => LIMIT,
            lt => open,
            eq => tick,
            gt => open
        );

    u_lfsr : entity work.lfsr
        port map (
            clk     => CLOCK_50,
            rst_n   => KEY(0),
            load    => load,
            sw_seed => SW,
            enable  => tick,
            q       => LEDR
        );
end architecture rtl;