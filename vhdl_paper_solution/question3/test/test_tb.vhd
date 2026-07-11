library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity test_tb is 
end test_tb; 

architecture behavioral of test_tb is
    component test is 
        port(clk : in std_logic); 
    end component; 
    signal clk : std_logic := '0'; 

    signal clk_period : time := 10 ns; 
begin

    --clock generation 
    clk <= NOT clk after clk_period/2; 

    --unit under test 
    uut : test
    port map(clk => clk); 
    
    --stimulus test 
    stim_p: process
    begin
        wait for clk_period*10;  

        wait; 
    end process stim_p;
    
    
    
end architecture behavioral;