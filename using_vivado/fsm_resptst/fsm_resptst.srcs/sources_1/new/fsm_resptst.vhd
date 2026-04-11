----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 04:57:10 PM
-- Design Name: 
-- Module Name: fsm_resptst - Behavioral
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


--Engineer : Mohammad Mahdi Mohammadi 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_resptst is
    port (
        clk, reset : in std_logic;
        b0, b1, b2 : in std_logic;
        led0, led1, led2, ledg, ledr : out std_logic
    );
end entity;

architecture bhv of fsm_resptst is
    type state_type is (L0, L1, L2, green, red);
    signal state, next_state : state_type;
begin

    --sequential process 
    seq_p : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= L0;
            else
                state <= next_state;
            end if;
        end if;
    end process seq_p;

    --combinational process 
    comb_p : process (state, b0, b1, b2)
    begin
        --default values; 
        led0 <= '0';
        led1 <= '0';
        led2 <= '0';
        ledg <= '0';
        ledr <= '0';
        next_state <= state;

        case state is
            when L0 =>
                led0 <= '1';
                led1 <= '0';
                led2 <= '0';
                ledg <= '0';
                ledr <= '0';
                if b0 = '1' then
                    next_state <= green;
                elsif b1 = '1' or b2 = '1' then
                    next_state <= red;
                else
                    next_state <= L1;
                end if;
            when L1 =>
                led0 <= '0';
                led1 <= '1';
                led2 <= '0';
                ledg <= '0';
                ledr <= '0';
                if b1 = '1' then
                    next_state <= green;
                elsif b0 = '1' or b2 = '1' then
                    next_state <= red;
                else
                    next_state <= L2;
                end if;
            when L2 =>
                led0 <= '0';
                led1 <= '0';
                led2 <= '1';
                ledg <= '0';
                ledr <= '0';
                if b2 = '1' then
                    next_state <= green;
                elsif b0 = '1' or b1 = '1' then
                    next_state <= red;
                else
                    next_state <= L0;
                end if;
            when green =>
                led0 <= '0';
                led1 <= '0';
                led2 <= '0';
                ledg <= '1';
                ledr <= '0';
                if b0 = '0' and b1 = '0' and b2 = '0' then
                    next_state <= L0;
                end if;
            when red =>
                led0 <= '0';
                led1 <= '0';
                led2 <= '0';
                ledg <= '0';
                ledr <= '1';
                if b0 = '0' and b1 = '0' and b2 = '0' then
                    next_state <= L0;
                end if;
            when others =>
                next_state <= L0;
        end case;
    end process comb_p;

end bhv;
