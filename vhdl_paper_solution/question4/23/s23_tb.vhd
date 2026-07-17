----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2026 12:02:00 AM
-- Design Name: 
-- Module Name: s23_tb - Behavioral
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

ENTITY s23_tb IS
END s23_tb;

ARCHITECTURE Behavioral OF s23_tb IS
    COMPONENT s23 IS
        PORT (
            clk : IN STD_LOGIC;
            start : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            y_out : OUT STD_LOGIC
        );
    END COMPONENT s23;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL start, reset, y_out : STD_LOGIC;
    SIGNAL data_in : STD_LOGIC_VECTOR(7 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clk generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s23
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        data_in => data_in,
        y_out => y_out
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        start <= '0';
        data_in <= x"df";
        WAIT FOR clk_period;
        start <= '1';
        WAIT FOR clk_period;
        start <= '0';
        WAIT FOR clk_period * 10;

        WAIT;
    END PROCESS stim_p;
END Behavioral;