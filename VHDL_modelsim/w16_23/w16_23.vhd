----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2026 02:24:39 PM
-- Design Name: 
-- Module Name: w16_23 - Behavioral
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


library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity w16_23 is 
    port(
        clk, reset, incr, start, stop : in std_logic; 
        clk_out : out std_logic
    ); 
end w16_23; 

architecture bhv of w16_23 is 
    type state_type is (idle, state1Mhz0, state1Mhz1, state10Mhz0, state10Mhz1);
    signal state, next_state : state_type;
    constant max_count : integer := 50; 
    subtype counter_type is integer range 0 to max_count;
    signal timer : counter_type := 0;    
begin 

    --sequential process 
    seq_p : process(clk, reset)
    variable cnt : counter_type := 0; 
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <= idle; 
            else 
                if cnt = timer then 
                    state <= next_state; 
                    cnt := 0; 
                else 
                    cnt := cnt + 1; 
                end if; 
            end if; 
        end if; 
    end process seq_p; 

    --combinational process 
    comb_p : process(state, start, incr, stop, timer)
    begin 
        --defautl values 
        next_state <= state; 
        clk_out <= '0'; 

        case state is 
            when idle        => 
                clk_out <= '0'; 
                if start = '1' then 
                    next_state <= state1Mhz0; 
                end if; 
            when state1Mhz0  => 
                clk_out <= '0'; 
                timer <= 49; 
                if incr = '1' then 
                    next_state <= state10Mhz0;  
                elsif stop = '1' then 
                    next_state <= idle; 
                else 
                    next_state <= state1Mhz1; 
                end if; 
            when state1Mhz1  => 
                clk_out <= '1'; 
                timer <= 49; 
                next_state <= state1Mhz0; 
            when state10Mhz0 =>  
                clk_out <= '0'; 
                timer <= 4; 
                if stop = '1' then 
                    next_state <= idle; 
                else 
                    next_state <= state10Mhz1; 
                end if; 
            when state10Mhz1 =>
                next_state <= state10Mhz0; 
                clk_out <= '1'; 
                timer <= 4; 
            end case; 
    end process comb_p; 
end bhv; 
