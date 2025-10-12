library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

--pwm testbench file 
entity pwm_tb is 
end pwm_tb; 

architecture behavioural of pwm_tb is 
    component pwm is 
        port(   start : in std_logic; 
		        clk : in std_logic; 
		        duty : in std_logic_vector(3 downto 0); 
		        y : out std_logic
        )
    end component pwm; 
    signal start, clk, y : std_logic := '0'; 
    signal duty : std_logic_vector(3 downto 0):= x"0"; 
    constant clk_periode : time := 10 ns; 

begin 
    clk_p : process 
    begin 
        clk <= '0'; 
        wait for clk_periode; 
        clk <= '1'; 
        wait for clk_periode;
    end process clk_p; 

    uut : pwm 
        port map( start => start, 
                  clk => clk, 
                  duty => duty, 
                  y =>y ); 

    stim_p : process
    begin 
        duty <= x"4"; 
        start <= '1'; 
        wait for clk_periode * 10; 
        start <= '0'; 
        
    end process stim_p; 

end behavioural; 