library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm2 is 
    port(
        x_in : in std_logic; 
        clk : in std_logic; 
        y_out : out std_logic_vector(1 downto 0)
    ); 
end fsm2; 

architecture bhv of fsm2 is 
    signal q : std_logic_vector(1 downto 0) := (others => '0');  
begin 
    y_out(0) <= q(0); 
    y_out(1) <= q(2); 

    --sequential process 
    seq_p : process(clk)
    begin 
        if rising_edge(clk) then 
            if x_in = '0' then 
                q(4) <= '1'; 
                q(3) <= q(4); 
                q(2) <= q(3); 
                q(1) <= q(2); 
                q(0) <= q(1); 
            elsif q(2) = q(0) then 
                q(4) <= '0'; 
                q(3 downto 0) <= q(4 downto 1); 
            else 
                q(4) <= '1'; 
                q(3 downto 0) <= q(4 downto 1); 
            end if; 
        end if; 
    end process seq_p; 
end bhv; 
