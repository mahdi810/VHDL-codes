----------------------------------------------------------------------------------
-- Company: HS Bremerhaven
-- Engineer: Mohammad Mahdi Mohammadi
-- 
-- Create Date: 09/03/2025 07:17:18 PM
-- Design Name: Finite State Machine of exponential algorithm
-- Module Name: fsmexp - Behavioral
-- Description: calculation of approximate exponential value using iteration
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity fsmexp is
    PORT( u_in  : in std_logic_vector(15 downto 0); 
          u_out : out std_logic_vector(15 downto 0); 
          clk   : in std_logic; 
          start : in std_logic; 
          reset : in std_logic; 
          done  : out std_logic ); 
end fsmexp;

architecture Behavioral of fsmexp is
    type my_state is (idle, init, iter, final); 
    signal state, next_state : my_state; 
    subtype int16_t is integer range -32768 to 32767; 
    subtype int32_t is integer range -2147483648 to 2147483647; 
    constant fract : integer := 9; 

    signal uu_in, uu_out, y0, x0, z0 : int16_t; 
    signal k : integer range 0 to 7; 
    
begin
    u_out <= std_logic_vector(to_signed(uu_out, u_out'length)); 

    seq_p : PROCESS(clk)
    BEGIN 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <= idle; 
                y0 <= 0; 
                x0 <= 0; 
                z0 <= 0; 
                k  <= 0;
            else 
                state <= next_state;
                case state is 
                		when idle => 
                			y0 <= 0; 
                			x0 <= 0; 
                			z0 <= 0; 
                			k  <= 0;
                		when init  => 
                			y0 <= 1 + uu_in/2; 
                    		x0 <= 1 - uu_in/2; 
                    		z0 <= 0; 
                    		k  <= 0; 
                		when iter  => 
                			if y0 < 0 then 
							y0 <= y0 + 2**(-k) * x0;
							z0 <=  z0 - 2**(-k); 
						else 
							y0 <= y0 - 2**(-k) * x0;
							z0 <=  z0 + 2**(-k);  
						end if;
						k <= k + 1; 
                		when final => 
                			uu_out <= z0;	
                	end case; 
            end if; 
        end if; 
    END PROCESS seq_p; 

    comb_p : PROCESS(start, state, k)
    BEGIN 
        done <= '0'; 
        case state is 
            when idle   => 
                uu_in <= to_integer(signed(u_in)); 
                if start = '1' then 
                    next_state <= init; 
                else 
                		next_state <= idle; 
                end if; 
            when init   =>
                next_state <= iter; 
            when iter   => 
				if k = 7 then 
					next_state <= final; 
				else 
					next_state <= iter; 
				end if; 
            when final  =>
                done <= '1'; 
                uu_out <= z0; 
                if start = '1' then 
                    next_state <= idle; 
                else 
                		next_state <= final; 
                end if;
        end case; 
    END PROCESS comb_p; 
end Behavioral;
