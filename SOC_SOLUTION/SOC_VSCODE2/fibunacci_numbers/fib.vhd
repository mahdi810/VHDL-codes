----------------------------------------------------------------------------------
-- Engineer: Mohammad Mahdi Mohammadi 
-- Create Date: 06/21/2026 12:12:13 PM
-- Module Name: fib - Behavioral
-- Description: fibunacci numbers accelerated sequence generator 
-- Dependencies: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fib IS
    PORT (
        clk, resetn, start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        y_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END fib;

ARCHITECTURE Behavioral OF fib IS
    TYPE state_type IS (idle, init, running, update);
    SIGNAL state : state_type;

    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;
    SUBTYPE int8_t IS INTEGER RANGE -128 TO 127;
    SIGNAL f0, f1 : INTEGER := 1;
    SIGNAL y_out_i : int32_t;

    TYPE memory IS ARRAY(0 TO 1) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL fib_mem : memory := (STD_LOGIC_VECTOR(to_unsigned(1, 32)), STD_LOGIC_VECTOR(to_unsigned(1, 32)));

BEGIN

    --fsm_p 
    fsm_p : PROCESS (clk)
    BEGIN
        IF RISING_EDGE(clk) THEN
            IF resetn = '0' THEN
                state <= idle;
                y_out_i <= 0;
            ELSE
                --default cases 
                done <= '0';
                CASE state IS
                    WHEN idle =>
                        done <= '1';
                        IF start = '1' THEN
                            state <= init;
                        END IF;
                    WHEN init =>
                        f0 <= to_integer(unsigned(fib_mem(0)));
                        f1 <= to_integer(unsigned(fib_mem(1)));
                        state <= running;
                    WHEN running =>
                        y_out_i <= f0 + f1;
                        state <= update;
                    WHEN update =>
                        fib_mem(0) <= STD_LOGIC_VECTOR(to_unsigned(f1, 32));
                        fib_mem(1) <= STD_LOGIC_VECTOR(to_unsigned(y_out_i, 32));
                        y_out <= std_logic_vector(to_unsigned(y_out_i, 32)); 
                        state <= idle;
                END CASE;
            END IF;
        END IF;
    END PROCESS fsm_p;

END Behavioral;