LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY controlling_leds IS
  PORT ( 
    SW   : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END controlling_leds;


ARCHITECTURE Behavior OF controlling_leds IS
BEGIN
  LEDR <= SW;
END Behavior;