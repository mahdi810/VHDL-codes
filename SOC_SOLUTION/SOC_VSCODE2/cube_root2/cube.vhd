----------------------------------------------------------------------------------
-- Engineer: Mohammad Mahdi Mohammadi 
-- Create Date: 06/15/2026 11:07:11 AM
-- Module Name: cube - Behavioral
-- Description: accelerated cube root calcuation 
-- Revision: 2
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY cube IS
    PORT (
        clk, resetn, start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        u : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END cube;

ARCHITECTURE Behavioral OF cube IS

    --signal and data formate declaration for y^3 fsm 
    TYPE r3_state_type IS (idle, st1, st2, st3, st4);
    SIGNAL r3_state : r3_state_type;

    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;

    SIGNAL r3_in : int16_t := 16384;
    SIGNAL r3_out : int16_t := 0;
    SIGNAL r3_temp : int32_t;
    SIGNAL r3_done : STD_LOGIC := '0';
    SIGNAL r3_start : STD_LOGIC := '1';

    --signal and datatype declaration for the main fsm 
    TYPE main_state_type IS (sidle, sst1, sst2, sst3, sst4, sst5, sst6);
    SIGNAL main_state : main_state_type;
    SIGNAL main_in, main_out : int16_t;
    SIGNAL main_temp : int32_t;

    SUBTYPE counter_type IS INTEGER RANGE 0 TO 25;
    CONSTANT iteration : INTEGER := 25;
    CONSTANT k01 : INTEGER := 1639; --k01 = 0.05 in int16.15
BEGIN

    --fsm y^3 
    fsm_r3_p : PROCESS (clk, resetn)
    BEGIN
        IF rising_edge(clk) THEN
            IF resetn = '0' THEN
                r3_state <= idle;
                r3_out <= 0;
            ELSE
                --default cases
                r3_done <= '0';
                CASE r3_state IS
                    WHEN idle =>
                        r3_done <= '1';
                        r3_temp <= 0;
                        IF r3_start = '1' THEN
                            r3_state <= st1;
                        END IF;
                    WHEN st1 =>
                        r3_temp <= r3_in * r3_in;
                        r3_state <= st2;
                    WHEN st2 =>
                        r3_temp <= (r3_temp)/2 ** 13;
                        r3_state <= st3;
                    WHEN st3 =>
                        r3_temp <= r3_temp * r3_in;
                        r3_state <= st4;
                    WHEN st4 =>
                        r3_out <= r3_temp / (2 ** 15);
                        r3_state <= idle;
                END CASE;
            END IF;
        END IF;
    END PROCESS fsm_r3_p;
    --fsm root cube calcuation 
    fsm_root_cube : PROCESS (clk, resetn)
        VARIABLE cnt : counter_type := 0;
    BEGIN
        IF rising_edge(clk) THEN
            IF resetn = '0' THEN
                main_state <= sidle;
                main_temp <= 0;
                main_out <= 0;
                cnt := 0;
            ELSE
                --default cases 
                done <= '0';
                CASE main_state IS
                    WHEN sidle =>
                        done <= '1';
                        cnt := 0;
                        main_temp <= 0;
                        main_in <= to_integer(signed(u));
                        main_out <= 8192; --initializing the y(k) to 1.0 in int16.13  
                        IF start = '1' THEN
                            main_state <= sst1;
                        END IF;
                    WHEN sst1 =>
                        IF cnt = iteration THEN
                            main_state <= sst6;
                        ELSE
                            --calculating the y^3 
                            r3_in <= main_out;
                            r3_start <= '1';
                            main_state <= sst2;
                        END IF;
                    WHEN sst2 =>
                        r3_start <= '0';
                        IF r3_done = '1' THEN
                            main_temp <= (main_in - r3_out); --int16.11 
                            main_state <= sst3;
                        END IF;
                    WHEN sst3 =>
                        main_temp <= k01 * main_temp;
                        main_state <= sst4;
                    WHEN sst4 =>
                        main_temp <= main_temp / (2 ** 13);
                        main_state <= sst5;
                    WHEN sst5 =>
                        main_out <= main_out + main_temp;
                        cnt := cnt + 1;
                        main_state <= sst1;
                    WHEN sst6 =>
                        y <= STD_LOGIC_VECTOR(to_signed(main_out, y'length));
                        main_state <= sidle;
                END CASE;
            END IF;
        END IF;
    END PROCESS fsm_root_cube;
END Behavioral;