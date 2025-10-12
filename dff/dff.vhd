library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity dff is 
    port ( clk, reset, d : in std_logic;  
           q : out std_logic); 
end entity; 


architecture bhv of dff is 

begin 

    process(clk, reset)
    begin 
        if clk'event AND clk = '1' then 
            if reset = '1' then
                q <= '0'; 
            else 
                q <= d; 
            end if; 
        end if; 
    end process; 

end bhv; 