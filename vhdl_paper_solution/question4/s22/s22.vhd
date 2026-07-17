----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2026 02:49:07 PM
-- Design Name: 
-- Module Name: s22 - Behavioral
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
ENTITY s22 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        crc : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        done : OUT STD_LOGIC
    );
END s22;

ARCHITECTURE Behavioral OF s22 IS
    TYPE state_type IS (idle, busy);
    SIGNAL state : state_type;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 8;
    SIGNAL cnt : counter_type := 0;

    -- for the flipflops 
    SIGNAL crc_i : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk, state, cnt)
        VARIABLE feedback : STD_LOGIC;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                crc_i <= x"0";
                cnt <= 0;
            ELSE
                -- default cases 
                done <= '0';

                CASE state IS
                    WHEN idle =>
                        done <= '1';
                        IF start = '1' THEN
                            cnt <= 7;
                            state <= busy;
                            crc_i <= x"0";
                        END IF;
                    WHEN busy =>
                        feedback := din(cnt) XOR crc_i(3);
                        crc_i(0) <= feedback;
                        crc_i(1) <= crc_i(0) XOR feedback;
                        crc_i(2) <= crc_i(1);
                        crc_i(3) <= crc_i(2);

                        IF cnt = 0 THEN
                            state <= idle;
                        ELSE
                            cnt <= cnt - 1;
                        END IF;
                END CASE;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- output 
    crc <= crc_i;

END Behavioral;