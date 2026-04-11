----------------------------------------------------------------------------------
-- Company: HS Bremerhaven 
-- Engineer: M.Mahdi Mohammadi 
-- 
-- Create Date: 04/09/2026 07:36:16 PM
-- Design Name: 
-- Module Name: w16_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: question No. 2, winter semester 2016
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity w16_1 is
  Port ( clk, reset : in std_logic;
         L : in std_logic_vector(8 downto 0); 
         a : out std_logic_vector(2 downto 0); 
         k : out std_logic_vector(2 downto 0));
end w16_1;

architecture Behavioral of w16_1 is
    type state_type is (state0, state1, state2, state3, state4, state5, state6, state7, state8); 
    signal state, next_state : state_type ; 
    
begin
    
    --sequential process 
    seq_p : process(clk, reset)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <= state0; 
            else 
                state <= next_state; 
            end if; 
        end if; 
    end process seq_p; 

    --combinational process 
    comb_p : process(state, L) 
    begin 
        --default cases 
        next_state <= state; 
        a <= "000"; 
        k <= "000"; 
        case state is 
            when state0 =>  
                if L(0) = '1' then 
                    a <= "001"; 
                    k <= "110";
                    next_state <= state1;  
                end if; 
            when state1 =>  
                if L(1) = '1' then 
                    a <= "001"; 
                    k <= "101"; 
                    next_state <= state2; 
                end if; 
            when state2 =>  
                if L(2) = '1' then 
                    a <= "001"; 
                    k <= "011"; 
                    next_state <= state2; 
                end if;
            when state3 =>  
                if L(3) = '1' then 
                    a <= "010"; 
                    k <= "110";
                    next_state <= state1;  
                end if; 
            when state4 =>  
                if L(4) = '1' then 
                    a <= "010"; 
                    k <= "101"; 
                    next_state <= state2; 
                end if; 
            when state5 =>  
                if L(5) = '1' then 
                    a <= "010"; 
                    k <= "011"; 
                    next_state <= state2; 
                end if;
            when state6 =>  
                if L(6) = '1' then 
                    a <= "101"; 
                    k <= "110";
                    next_state <= state1;  
                end if; 
            when state7 =>  
                if L(7) = '1' then 
                    a <= "101"; 
                    k <= "101"; 
                    next_state <= state2; 
                end if; 
            when state8 =>  
                if L(7) = '1' then 
                    a <= "101"; 
                    k <= "011"; 
                    next_state <= state2; 
                end if;
        end case; 
    end process comb_p; 
end Behavioral;











