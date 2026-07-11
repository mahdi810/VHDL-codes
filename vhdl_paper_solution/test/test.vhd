library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity test is 
    port(clk : in std_logic); 
end test; 

architecture behavioral of test is
    signal k : signed(31 downto 0) := to_signed(234881024, 32);  
    signal p : signed(15 downto 0); 
begin
    p <= k(28 downto 13); 
    
    
    
end architecture behavioral;