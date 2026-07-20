----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2026 12:28:28 AM
-- Design Name: 
-- Module Name: zerocross - Behavioral
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

ENTITY zerocross IS
    PORT (
        clk, resetn, start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        rightv, leftv : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        newx, newy : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END zerocross;

ARCHITECTURE behavioral OF zerocross IS

    --signal and datatype declaration for the function calculation. 
    TYPE fcalc_state_type IS (idle, st1, st2, st3);
    SIGNAL fcalc_state : fcalc_state_type;

    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;

    SIGNAL fcalc_xin : int16_t;
    SIGNAL fcalc_yout : int16_t;
    SIGNAL fcalc_temp : int32_t;

    SIGNAL fcalc_done : STD_LOGIC := '0';
    SIGNAL fcalc_start : STD_LOGIC := '0';

    --signal and datatype declaration for the calculation of the zerocross. 
    TYPE main_state_type IS (sidle, init, sst1, sst2, sst3, sst4, final);
    SIGNAL main_state : main_state_type;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 30;

    SIGNAL rightv_i, leftv_i : int16_t;
    SIGNAL newx_i, newy_i : int16_t;
    SIGNAL main_temp : int32_t;
    CONSTANT iteration : INTEGER := 15;
    SIGNAL count : counter_type := 0;
BEGIN

    --function calculation process 
    f_calc_process : PROCESS (clk, resetn)
    BEGIN
        IF rising_edge(clk) THEN
            IF resetn = '0' THEN
                fcalc_state <= idle;
                fcalc_temp <= 0;
                fcalc_yout <= 0;
            ELSE
                --default cases 
                fcalc_done <= '0';
                CASE fcalc_state IS
                    WHEN idle =>
                        
                        IF fcalc_start = '1' THEN
                            fcalc_state <= st1;
                        END IF;
                    WHEN st1 =>
                        fcalc_temp <= fcalc_xin * fcalc_xin;
                        fcalc_state <= st2;
                    WHEN st2 =>
                        fcalc_temp <= (8388608) - fcalc_temp;
                        fcalc_state <= st3;
                    WHEN st3 =>
                        fcalc_yout <= fcalc_temp/(2 ** 10);
						fcalc_done <= '1';
                        fcalc_state <= idle;
                END CASE;
            END IF;
        END IF;
    END PROCESS f_calc_process;

    --The second process for calculation of the zerocross
    zerocross_p : PROCESS (clk, resetn)
        VARIABLE cnt : counter_type := 0;
    BEGIN
        IF rising_edge(clk) THEN
            IF resetn = '0' THEN
                main_state <= sidle;
                main_temp <= 0;
                newy_i <= 0;
                newx_i <= 0;
                cnt := 0;
                count <= 0;
            ELSE
                --default cases
                done <= '0';
				fcalc_start <= '0'; 
                CASE main_state IS
                    WHEN sidle =>
                        done <= '1';
                        IF start = '1' THEN
                            cnt := 0;
                            main_state <= init;
                        END IF;
                    WHEN init =>
                        rightv_i <= to_integer(signed(rightv));
                        leftv_i <= to_integer(signed(leftv));
                        main_state <= sst1;
                    WHEN sst1 =>
                        IF cnt = iteration THEN
                            main_state <= final;
                        ELSE
                            newx_i <= (rightv_i + leftv_i)/2;
                            main_state <= sst2;
                        END IF;
                    WHEN sst2 =>
                        fcalc_xin <= newx_i;
                        fcalc_start <= '1';
                        main_state <= sst3;
                    WHEN sst3 =>
                        --fcalc_start <= '0';
                        IF fcalc_done = '1' THEN
                            newy_i <= fcalc_yout;
                            main_state <= sst4;
                        END IF;
                    WHEN sst4 => --updating the rightv or leftv 
                        IF newy_i < 0 THEN
                            rightv_i <= newx_i;
                        ELSE
                            leftv_i <= newx_i;
                        END IF;
                        cnt := cnt + 1;
                        count <= cnt;
                        main_state <= sst1;
                    WHEN final =>
                        newx <= STD_LOGIC_VECTOR(to_signed(newx_i, 16));
                        newy <= STD_LOGIC_VECTOR(to_signed(newy_i, 16));
                        main_state <= sidle;
                END CASE;
            END IF;
        END IF;
    END PROCESS zerocross_p;

END ARCHITECTURE behavioral; 
