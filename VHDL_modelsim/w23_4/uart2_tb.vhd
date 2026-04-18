----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2026 05:09:00 PM
-- Design Name: 
-- Module Name: uart2_tb - Behavioral
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

ENTITY uart2_tb IS
END uart2_tb;

ARCHITECTURE behavioral OF uart2_tb IS

    COMPONENT uart2 IS
        PORT (
            clk, start, reset : IN STD_LOGIC;
            s_out : OUT STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT uart2;
    SIGNAL clk, start, reset, s_out : STD_LOGIC := '0';
    CONSTANT clk_period : TIME := 10 ns;
    SIGNAL data_in : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : uart2
    PORT MAP(
        clk => clk,
        start => start,
        reset => reset,
        s_out => s_out,
        data_in => data_in
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        start <= '0';
        data_in <= x"f4";
        wait for clk_period; 
        start <= '1'; 
        wait for clk_period; 
        start <= '0';
        WAIT FOR clk_period * 10;
        WAIT;
    END PROCESS;
END behavioral; -- behavioral