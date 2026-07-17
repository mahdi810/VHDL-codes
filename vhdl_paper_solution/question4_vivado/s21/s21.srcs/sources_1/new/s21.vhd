----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2026 04:31:26 PM
-- Design Name: 
-- Module Name: s21 - Behavioral
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

ENTITY s21 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        x_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        xmin : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        xmax : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        done : OUT STD_LOGIC
    );
END ENTITY s21;

ARCHITECTURE Behavioral OF s21 IS
    TYPE state_type IS (idle, running);
    SIGNAL state : state_type := idle;
    SUBTYPE int12_t IS INTEGER RANGE -2048 TO 2047;
    SIGNAL xmin_i, xmax_i : int12_t;

BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                xmin_i <= 0;
                xmax_i <= 0;
            ELSE
                -- default cases 
                done <= '0';
                CASE state IS
                    WHEN idle =>
                        done <= '1';
                        IF start = '1' THEN
                            state <= running;
                            xmin_i <= to_integer(signed(x_in));
                            xmax_i <= to_integer(signed(x_in));
                        END IF;
                    WHEN running =>
                        IF to_integer(signed(x_in)) < xmin_i THEN
                            xmin_i <= to_integer(signed(x_in));
                        ELSE
                            xmin_i <= xmin_i;
                        END IF;

                        IF to_integer(signed(x_in)) > xmax_i THEN
                            xmax_i <= to_integer(signed(x_in));
                        ELSE
                            xmax_i <= xmax_i;
                        END IF;

                        IF start = '0' THEN
                            state <= idle;
                        END IF;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- outputs 
    xmin <= STD_LOGIC_VECTOR(to_signed(xmin_i, xmin'length));
    xmax <= STD_LOGIC_VECTOR(to_signed(xmax_i, xmax'length));

END ARCHITECTURE behavioral;