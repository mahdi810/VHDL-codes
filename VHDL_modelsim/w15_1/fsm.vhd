library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm is 
    port(
        x_in : in std_logic; 
        clk, reset : in std_logic; 
        y_out : out std_logic_vector(1 downto 0)
    ); 
end fsm; 

architecture structural of fsm is 
    signal q : std_logic_vector(4 downto 0) := (others => '0');  
    signal a, b : std_logic := '0'; 
begin 

    y_out(0) <= q(2); 
    y_out(1) <= q(0); 
    a <= q(2) XOR q(0); 
    b <= x_in NAND a; 


    --flipflops 
    ff : process(clk)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                q <= (others => '0'); 
            else 
                q(0) <= q(1); 
                q(1) <= q(2); 
                q(2) <= q(3); 
                q(3) <= q(4);  
                q(4) <= b; 
            end if; 
        end if; 
    end process ff; 


end structural; 