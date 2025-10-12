library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm3bhv is 
    port( xin : out std_logic;
          clk : in std_logic; 
          y_out0 : out std_logic; 
          y_out1 : out std_logic ); 
end fsm3bhv; 

architecture bhv of fsm3bhv is 
    signal q : std_logic_vector(4 downto 0) := (others => '0'); 
    

begin 
    
    y_out0 <= q(2);
    y_out1 <= q(0); 

    ffs : process(clk, xin)
    begin 
        if rising_edge(clk) then 
            if xin = '0' then 
                q(4) <= '1'; 
                q(3) <= q(4); 
                q(2) <= q(3); 
                q(1) <= q(2); 
                q(0) <= q(1);
            elsif q(2) = q(0) then 
                q(4) <= '1'; 
                q(3 downto 0) <= q(4 downto 1); 
                
            end if; 
        end if; 
    end process ffs; 
end bhv; 