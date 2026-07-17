----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2026 11:28:10 AM
-- Design Name: 
-- Module Name: s14 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
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


entity s14 is
    port(
        clk : in std_logic; 
        reset : in std_logic; 
        ss : in std_logic; 
        s1, s2, s3 : out std_logic
    ); 
end s14;

architecture Behavioral of s14 is
    type state_type is (idle, st0, st1, st2, st3, st4, st5, off0, off1, off2, off3, off4, off5); 
    signal state, next_state : state_type; 
    
begin

    -- sequential process
    -- for calculation of the next state.  
    seq_p : process(clk, reset)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <= idle; 
            else 
                state <= next_state;
            end if; 
        end if; 
    end process seq_p; 
    
    -- combinational circuit 
    comb_p : process(state, ss)
    begin 
        -- default cases 
        next_state <= state; 
        
        case state is 
            when idle =>
                if ss = '1' then 
                    next_state <= st0; 
                end if; 
            when st0  =>
                s1 <= '1'; 
                s2 <= '0'; 
                s3 <= '0'; 
                if ss = '1' then 
                    next_state <= st1; 
                else 
                    next_state <= off0; 
                end if; 
            when st1  =>
                s1 <= '1'; 
                s2 <= '1'; 
                s3 <= '0'; 
                if ss = '1' then 
                    next_state <= st2; 
                else 
                    next_state <= off1; 
                end if;
            when st2  =>
                s1 <= '0'; 
                s2 <= '1'; 
                s3 <= '0'; 
                if ss = '1' then 
                    next_state <= st3; 
                else 
                    next_state <= off2; 
                end if;
            when st3  =>
                s1 <= '0'; 
                s2 <= '1'; 
                s3 <= '1'; 
                if ss = '1' then 
                    next_state <= st4; 
                else 
                    next_state <= off3; 
                end if;
            when st4  =>
                s1 <= '0'; 
                s2 <= '0'; 
                s3 <= '1'; 
                if ss = '1' then 
                    next_state <= st5; 
                else 
                    next_state <= off4; 
                end if;
            when st5  =>
                s1 <= '1'; 
                s2 <= '0'; 
                s3 <= '1'; 
                if ss = '1' then 
                    next_state <= st0; 
                else 
                    next_state <= off5; 
                end if;
            when off0 =>
                if ss = '1' then 
                    next_state <= st1; 
                end if; 
            when off1 =>
                if ss = '1' then 
                    next_state <= st2; 
                end if;
            when off2 =>
                if ss = '1' then 
                    next_state <= st3; 
                end if;
            when off3 =>
                if ss = '1' then 
                    next_state <= st4; 
                end if;
            when off4 =>
                if ss = '1' then 
                    next_state <= st5; 
                end if;
            when off5 =>
                if ss = '1' then 
                    next_state <= st0; 
                end if;
        end case; 
    end process comb_p; 
    
end Behavioral;















