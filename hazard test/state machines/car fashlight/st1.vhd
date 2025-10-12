library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 


--state machine to for the flash light of a car, if b is pressed once then the car should flash three times and if the person keeps the button pressed then the flash should keep lighted. 
-- b buton 
--clk clock 
-- f flash 


entity st1 is 
    port( 
          b, clk, reset : in std_logic; 
          f : out std_logic
    ); 
end st1; 

architecture behavioural of st1 is
	type my_state is (idle, st_on1, st_off1, st_on2, st_off2, st_on3, st_off3); 
	signal state, next_state : my_state; 
begin 

	seq_p : process(clk, reset)
	begin
		if (clk'event and clk = '1') then 
			if reset = '1' then 
				state <= idle; 
			else 
				state <= next_state; 
			end if;
		end if; 
	end process seq_p; 

	comb_p : process(clk, b) 
	begin 
		next_state <= idle; 
		case state is 
			when idle    =>
				
				if (b='1') then 
					next_state <= st_on1; 
				end if; 
				f <= '0'; 
			when st_on1  =>
				next_state <= st_off1; 
				f <= '1'; 
			when st_off1 =>
				next_state <= st_on2; 
				f <= '0'; 
			when st_on2  =>
				next_state <= st_off2; 
				f <= '1'; 
			when st_off2 =>
				next_state <= st_on3; 
				f <= '0'; 
			when st_on3  =>
				next_state <= st_off3;
				f <= '1';				
			when st_off3 =>
				if (b = '1') then 
					next_state <= st_on1; 
				else 
					next_state <= idle; 
				end if; 
				f <= '0'; 
			end case;
	end process comb_p; 
end behavioural; 