library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm1bhv_tb is 
end fsm1bhv_tb; 

architecture bhv of fsm1bhv_tb is 
    component fsm1bhv is 
        port( y : in std_logic; 
            x : out std_logic; 
            clk : in std_logic ); 
    end component fsm1bhv; 
    signal y, x, clk : std_logic := '0'; 

    constant clk_periode : time := 10 ns; 

begin 

    --clock generation 
    clk_p : process 
    begin 
        clk <= '0'; 
        wait for clk_periode/2; 
        clk <= '1'; 
        wait for clk_periode/2; 
    end process clk_p; 

    uut : fsm1bhv
        port map( clk =>  clk, 
                  x => x, 
                  y => y); 

    stim_p : process 
    begin 
        y <= '0'; 
        wait for clk_periode;
        y <=  '1'; 
        wait for clk_periode; 
    end process stim_p; 



end bhv; 