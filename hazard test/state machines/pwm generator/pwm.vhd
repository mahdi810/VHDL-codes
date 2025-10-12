library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

--this vhdl code generates a pwm signal
entity pwm is 
	port( start : in std_logic; 
		  clk : in std_logic; 
		  duty : in std_logic_vector(3 downto 0); 
		  y : out std_logic
		); 
end pwm; 

architecture behavioural of pwm is 
	signal temp : std_logic_vector(3 downto 0):= "0000"; 
begin 
	--making the counter
	counter : process
	begin 
		if (start = '1') then 
			temp <= temp + 1; 
		else 
			temp <= x"0"; 
		end if; 
	end process counter;



end behavioural; 