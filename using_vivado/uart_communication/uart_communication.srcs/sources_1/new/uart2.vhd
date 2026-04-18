----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2026 05:08:46 PM
-- Design Name: 
-- Module Name: uart2 - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY uart2 IS
    PORT (
        clk, start, reset : IN STD_LOGIC;
        s_out : OUT STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END uart2;

ARCHITECTURE behavioral OF uart2 IS

    TYPE state_type IS (idle, st_start, st0, st1, st_parity, st_stop);
    SIGNAL state, next_state : state_type;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 8;
    SIGNAL count, count_next : counter_type := 0;
BEGIN

    --sequential process 
    seq_p : PROCESS (clk, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                count <= 0;
            ELSE
                state <= next_state;
                count <= count_next;
            END IF;
        END IF;
    END PROCESS seq_p;
    --combination process 
    comb_p : PROCESS(state, count, start)
    BEGIN
        --default case values 
        next_state <= state;
        count_next <= count;
        s_out <= '1';

        CASE state IS
            WHEN idle =>
                count_next <= 0;
                IF start = '1' THEN
                    next_state <= st_start;
                END IF;
            WHEN st_start =>
                s_out <= '0';
                next_state <= st0;
            WHEN st0 =>
                s_out <= data_in(count);
                count_next <= count + 1;
                next_state <= st1;
            WHEN st1 =>
                s_out <= data_in(count);
                count_next <= count + 1;
                IF count = 7 THEN
                    next_state <= st_parity;
                ELSE
                    next_state <= st0;
                END IF;
            WHEN st_parity =>
                s_out <= data_in(0) XOR data_in(1) XOR data_in(2) XOR
                    data_in(3) XOR data_in(4) XOR data_in(5) XOR data_in(6)XOR data_in(7) XOR '1';
                next_state <= st_stop; 
            WHEN st_stop =>
                s_out <= '0'; 
                next_state <= idle; 
        END CASE;
    END PROCESS;
END behavioral; -- behavioral