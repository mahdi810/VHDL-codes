----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2026 04:55:27 PM
-- Design Name: 
-- Module Name: w14_st24 - Behavioral
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

entity w14_st24 is 
    port(
        clk, reset , camshaft : in std_logic; 
        inject, spark : out std_logic
    ); 
end w14_st24; 

architecture bhv of w14_st24 is
    type state_type is (idle, st0, st1, st2, st3, st_in, st_sp);
    signal state, next_state : state_type;  
    constant max_count : integer := 2**31 -1; 
    subtype counter_type is integer range 0 to max_count; 
    signal timer : counter_type := 0; 
begin

    --sequential process 
    seq_p : process(clk)
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
    comb_p : process(state, camshaft, timer)
    begin
        --default values
        next_state <= state; 
        inject <= '0'; 
        spark <= '0'; 
        timer <= 0; 
        case state is 
            when idle  => 
                if camshaft = '1' then 
                    next_state <= st0; 
                end if; 
            when st0   => 
                if camshaft = '0' then 
                    next_state <= st1; 
                end if; 
            when st1   => 
                if camshaft = '1' then 
                    next_state <= st2; 
                end if; 
            when st2   => 
                if camshaft = '0' then 
                    next_state <= st3; 
                end if; 
            when st3   => 
                if camshaft = '1' then 
                    next_state <= st_in; 
                end if; 
            when st_in =>  
                timer <= 999999; 
                inject <= '1'; 
                next_state <= st_sp; 
            when st_sp => 
                timer <= 99999; 
                spark <= '1'; 
                next_state <= idle; 
        end case; 
    end process comb_p; 
end bhv ; -- bhv
