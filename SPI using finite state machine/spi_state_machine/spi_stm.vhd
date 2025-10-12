library ieee;
use ieee.STD_LOGIC_1164.all;

entity spi_stm is
port map (
  reset   => in std_logic; 
  start   => in std_logic; 
  bclk    => in std_logic;  
  done    => in std_logic; 
  sndData => in std_logic_vector(7 downto 0);  
  rcvData => in std_logic_vector(7 downto 0); 
); 