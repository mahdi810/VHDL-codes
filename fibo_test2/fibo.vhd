
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fibo is 
    port( clk : in std_logic; 
          reset : in std_logic; 
          n : in integer ; 
          u_out : out unsigned(31 downto 0); 
          done : out std_logic; 
          start : in std_logic ); 
end fibo; 

architecture rtl of fibo is 
    type my_state is (idle, init, fibo1,fibo2, final); 
    signal state : my_state; 
    signal u_out2 : unsigned(31 downto 0) := (others => '0'); 
    signal u_out1 : unsigned(31 downto 0) := (others => '0'); 
    signal n_i : integer := 0; 
begin 

	--Whole FSM 
	fsm : process(clk, reset, start, n_i, u_out1, u_out2)
	begin 
		if rising_edge(clk) then 
			if reset = '1'  then 
				state <= idle; 
			else 
				case state is 
					when  idle => 
						done <= '1'; 
						if start = '1' then 
							state <= init; 
						else 
							state <= idle; 
						end if; 
					when init => 
						done <= '0'; 
						n_i <= 0; 
						u_out1 <= (others => '0'); 
						u_out2 <= x"00000001"; 
						state <= fibo1; 
					when fibo1 => 
						done <= '0'; 
						n_i <= n_i + 1;  
						u_out <= u_out1 + u_out2; 
						state <= fibo2;
					when fibo2 => 
						done <= '0'; 
						n_i <= n_i + 1; 
						u_out2 <= u_out2; 
						u_out1 <= u_out1;
						u_out <= u_out1 + u_out2;  
						if n_i = n then 
							state <= idle; 
						else 
							state <= fibo1; 
						end if; 
					when final => 
						state <= idle; 
				end case; 
			end if; 
		end if; 
	u_out <= u_out2; 
	end process fsm; 
end rtl; 