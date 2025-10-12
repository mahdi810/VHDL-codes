library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm1bhv is 
    port( y : in std_logic; 
          x : out std_logic; 
          clk : in std_logic ); 
end fsm1bhv; 

architecture bhv of fsm1bhv is 
    signal Q : std_logic_vector(3 downto 0) := (others => '0'); 
    

begin 
   
    fsm : process(clk)
    begin 
        if rising_edge(clk) then 
            if y = '0' then 
                Q <= Q(2 downto 1) & (Q(3) XOR Q(2)); 
            else
                Q <= Q(2 downto 1) & '1'; 
            end if; 
        end if; 
    end process fsm; 
end bhv; 