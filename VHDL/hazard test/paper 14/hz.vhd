library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity hz0 is 
port(
      a, b, c, d : in std_logic; 
      y : out std_logic
); 
end hz0; 

architecture structural of hz0 is 
signal x, z : std_logic := '0'; 
begin 
    x <= a or (not c) or (not d); 
    z <= (not b) or (not c) or d; 
    y <= x and z; 
end structural; 