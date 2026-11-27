library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_timing is
    generic (
        H_DISPLAY : positive := 640;
        H_FP      : positive := 16;
        H_SYNC    : positive := 96;
        H_BP      : positive := 48;
        V_DISPLAY : positive := 480;
        V_FP      : positive := 10;
        V_SYNC    : positive := 2;
        V_BP      : positive := 33;
        CNT_W     : positive := 10
    );

    port (
        clk    : in std_logic;
        rst_n  : in std_logic;
        hcount : out unsigned(CNT_W-1 downto 0);
        vcount : out unsigned(CNT_W-1 downto 0);
        active : out std_logic;
        hs_n   : out std_logic;
        vs_n   : out std_logic
    );
end entity vga_timing;


architecture rtl of vga_timing is
    signal h_cnt     : unsigned(CNT_W-1 downto 0);
    signal v_cnt     : unsigned(CNT_W-1 downto 0);
    constant H_TOTAL : positive := H_DISPLAY + H_FP + H_SYNC + H_BP;
    constant V_TOTAL : positive := V_DISPLAY + V_FP + V_SYNC + V_BP;
begin
    process (clk, rst_n)
    begin
        if rst_n = '0' then
            h_cnt <= (others => '0');
            v_cnt <= (others => '0');

        elsif rising_edge(clk) then
            h_cnt <= h_cnt + 1;

            if h_cnt = H_TOTAL - 1 then
                h_cnt <= (others => '0');
                v_cnt <= v_cnt + 1;

                if v_cnt = V_TOTAL - 1 then
                    v_cnt <= (others => '0');
                end if;
            end if;
        end if;
    end process;

    active <= '1' when (h_cnt < H_DISPLAY and v_cnt < V_DISPLAY) else '0';
    hs_n   <= '0' when (h_cnt >= H_DISPLAY + H_FP and h_cnt < H_DISPLAY + H_FP + H_SYNC) else '1';
    vs_n   <= '0' when (v_cnt >= V_DISPLAY + V_FP and v_cnt < V_DISPLAY + V_FP + V_SYNC) else '1';

    hcount <= h_cnt;
    vcount <= v_cnt;
end architecture rtl;
