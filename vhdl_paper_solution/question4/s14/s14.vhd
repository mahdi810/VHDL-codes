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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY s14 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        ss : IN STD_LOGIC;
        s1, s2, s3 : OUT STD_LOGIC
    );
END s14;

ARCHITECTURE Behavioral OF s14 IS
    TYPE state_type IS (idle, st0, st1, st2, st3, st4, st5, off0, off1, off2, off3, off4, off5);
    SIGNAL state, next_state : state_type;

BEGIN

    -- sequential process
    -- for calculation of the next state.  
    seq_p : PROCESS (clk, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
            ELSE
                state <= next_state;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- combinational circuit 
    comb_p : PROCESS (state, ss)
    BEGIN
        -- default cases 
        next_state <= state;

        CASE state IS
            WHEN idle =>
                IF ss = '1' THEN
                    next_state <= st0;
                END IF;
            WHEN st0 =>
                s1 <= '1';
                s2 <= '0';
                s3 <= '0';
                IF ss = '1' THEN
                    next_state <= st1;
                ELSE
                    next_state <= off0;
                END IF;
            WHEN st1 =>
                s1 <= '1';
                s2 <= '1';
                s3 <= '0';
                IF ss = '1' THEN
                    next_state <= st2;
                ELSE
                    next_state <= off1;
                END IF;
            WHEN st2 =>
                s1 <= '0';
                s2 <= '1';
                s3 <= '0';
                IF ss = '1' THEN
                    next_state <= st3;
                ELSE
                    next_state <= off2;
                END IF;
            WHEN st3 =>
                s1 <= '0';
                s2 <= '1';
                s3 <= '1';
                IF ss = '1' THEN
                    next_state <= st4;
                ELSE
                    next_state <= off3;
                END IF;
            WHEN st4 =>
                s1 <= '0';
                s2 <= '0';
                s3 <= '1';
                IF ss = '1' THEN
                    next_state <= st5;
                ELSE
                    next_state <= off4;
                END IF;
            WHEN st5 =>
                s1 <= '1';
                s2 <= '0';
                s3 <= '1';
                IF ss = '1' THEN
                    next_state <= st0;
                ELSE
                    next_state <= off5;
                END IF;
            WHEN off0 =>
                IF ss = '1' THEN
                    next_state <= st1;
                END IF;
            WHEN off1 =>
                IF ss = '1' THEN
                    next_state <= st2;
                END IF;
            WHEN off2 =>
                IF ss = '1' THEN
                    next_state <= st3;
                END IF;
            WHEN off3 =>
                IF ss = '1' THEN
                    next_state <= st4;
                END IF;
            WHEN off4 =>
                IF ss = '1' THEN
                    next_state <= st5;
                END IF;
            WHEN off5 =>
                IF ss = '1' THEN
                    next_state <= st0;
                END IF;
        END CASE;
    END PROCESS comb_p;

END Behavioral;