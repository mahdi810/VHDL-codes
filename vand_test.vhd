library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity vand_test is 
    port ( a : in std_logic; 
           b : in std_logic; 
           c : out std_logic ); 
end entity; 

architecture rtl of vand_test is 

begin 
    c <= a AND b; 

end rtl; 