LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY two_to_one_mux IS
  PORT (
    SW   : IN STD_LOGIC_VECTOR(9 DOWNTO 0);    -- X is SW[3:0] and Y is SW[7:4] and S is SW[8]
    LEDR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)    -- M IS LEDR[3:0]
  );
END two_to_one_mux;


ARCHITECTURE Behavior OF two_to_one_mux IS
BEGIN 
  LEDR(3 DOWNTO 0) <= SW(3 DOWNTO 0) WHEN (SW(8) = '0') ELSE SW(7 DOWNTO 4);
END Behavior;
