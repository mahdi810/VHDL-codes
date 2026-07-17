----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2026 11:28:45 AM
-- Design Name: 
-- Module Name: s14_tb - Behavioral
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
ENTITY s14_tb IS
END s14_tb;

ARCHITECTURE Behavioral OF s14_tb IS
    COMPONENT s14 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            ss : IN STD_LOGIC;
            s1, s2, s3 : OUT STD_LOGIC
        );
    END COMPONENT s14;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, ss : STD_LOGIC;
    SIGNAL s1, s2, s3 : STD_LOGIC := '0';

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- uni under test 
    uut : s14
    PORT MAP(
        clk => clk,
        reset => reset,
        ss => ss,
        s1 => s1,
        s2 => s2,
        s3 => s3);

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '1';
        ss <= '0';
        WAIT FOR clk_period;
        reset <= '0';
        WAIT FOR clk_period * 4;
        ss <= '1';
        WAIT FOR clk_period * 8;
        ss <= '0';
        WAIT FOR clk_period * 5;
        ss <= '1';
        WAIT FOR clk_period;
        ss <= '0';
        WAIT FOR clk_period;
        ss <= '1';

        WAIT;
    END PROCESS stim_p;
END Behavioral;