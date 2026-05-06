----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2026 08:18:42 PM
-- Design Name: 
-- Module Name: dfilter - Behavioral
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
-- USE ieee.std_logic_arith.ALL;

ENTITY dfilter IS
    PORT (
        clk, reset, start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        P : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END dfilter;

ARCHITECTURE behavioral OF dfilter IS
    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;
    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SIGNAL Q32 : int32_t := 0;
    SIGNAL Q16 : int16_t := 0;
    SIGNAL Xin : int32_t := 0;
    SIGNAL Xin2 : int32_t := 0;

    TYPE state_type IS (idle, st0, st1, st2, st3);
    SIGNAL state : state_type;

    SIGNAL Din : int16_t := 0;
    SIGNAL Pin : int32_t := 0;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 64;
    CONSTANT iteration_max : counter_type := 40;
    SIGNAL cnt : counter_type := 0;
BEGIN

    Pin <= to_integer(signed(P));
    Din <= to_integer(signed(D));

    fsm : PROCESS (clk, reset, start)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                cnt <= 0;
            ELSE
                --default cases 
                done <= '0';
                CASE state IS
                    WHEN idle =>
                        done <= '1';
                        cnt <= 0;
                        IF start = '1' THEN
                            state <= st0;
                        END IF;
                    WHEN st0 =>
                        Q16 <= Q32 / 2 ** 15;
                        state <= st1;
                    WHEN st1 =>
                        Xin <= Q16 * Din;
                        state <= st2;
                    WHEN st2 =>
                        Xin2 <= Pin - Xin;
                        state <= st3;
                    WHEN st3 =>
                        Q32 <= Xin2 + Q32;
                        IF cnt >= iteration_max THEN
                            state <= idle;
                        ELSE
                            cnt <= cnt + 1;
                            state <= st0;
                        END IF;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    Q <= STD_LOGIC_VECTOR(to_signed(Q32, Q'length));

END behavioral; -- behavioral