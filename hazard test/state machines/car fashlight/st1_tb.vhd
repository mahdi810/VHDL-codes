library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 


--state machine to for the flash light of a car, if b is pressed once then the car should flash three times and if the person keeps the button pressed then the flash should keep lighted. 
-- b buton 
--clk clock 
-- f flash 

entity st1_tb is 
end st1_tb; 

architecture behavioural of st1_tb is 
	component st1 is 
		port( b, clk, reset : in std_logic; 
              f : out std_logic ); 
	end component st1; 
	signal b, clk, reset, f : std_logic := '0'; 
	constant clk_periode : time := 10 ns; 
	
begin 

	clk_p : process
	begin 
		clk <= '0'; 
		wait for clk_periode; 
		clk <= '1'; 
		wait for clk_periode; 
	end process clk_p; 
	
	uut : st1
		port map( b => b, 
				  clk => clk, 
				  reset => reset, 
				  f => f ); 
				  
	stim_p : process
	begin 
		b <= '1'; 
		wait for clk_periode; 
		b <= '0'; 
		wait for clk_periode*10; 
		wait; 
	end process stim_p; 
end behavioural; 