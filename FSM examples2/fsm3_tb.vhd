library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm3_tb is 
end fsm3_tb; 

architecture bhv of fsm3_tb is 
    component fsm3 is 
        port( s : in std_logic; 
              x : out std_logic_vector(1 downto 0); 
              clk : in std_logic ); 
    end component fsm3; 
    signal s, clk : std_logic := '0';
    signal x : std_logic_vector(1 downto 0) := (others => '0'); 

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

    uut : fsm3
        port map( clk =>  clk, 
                  s => s, 
                  x => x); 

    stim_p : process 
    begin 
        s <= '0'; 
        wait for clk_periode;
        s <=  '1'; 
        wait for clk_periode; 
    end process stim_p; 



end bhv; 