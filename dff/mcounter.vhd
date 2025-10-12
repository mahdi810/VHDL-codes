library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity mcounter is 
    generic (N : integer := 4; 
             M : integer := 10); 
    port ( clk, reset :in std_logic; 
           max_tick : out std_logic; 
           q : out std_logic_vector(N-1 downto 0) ); 
end entity; 

architecture bhv of mcounter is 
signal r_reg : unsigned(N-1 downto 0) := (others => '0'); 

begin 





end bhv; 