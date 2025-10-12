library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity vand_test_tb is 
end entity; 

architecture rtl of vand_test_tb is
    component vand_test is 
        port ( a : in std_logic; 
               b : in std_logic; 
               c : out std_logic ); 
    end component vand_test; 
    signal a, b, c : std_logic := '0'; 
    constant clk_periode : time := 10 ns; 

begin 
    uut : entity work.vand_test 
        port map( a => a, 
                  b => b, 
                  c => c) ;
stim_p : process 
begin 
    a <= '0'; 
    b <= '0'; 
    wait for clk_periode; 
    a <= '1'; 
    b <= '0'; 
    wait for clk_periode; 
    a <= '0'; 
    b <= '1'; 
    wait for clk_periode; 
    a <= '1'; 
    b <= '1'; 
    wait for clk_periode; 

    wait; 
end process stim_p; 


end rtl; 