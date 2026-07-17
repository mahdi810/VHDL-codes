----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2026 02:49:27 PM
-- Design Name: 
-- Module Name: s22_tb - Behavioral
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

ENTITY s22_tb IS
END s22_tb;

ARCHITECTURE Behavioral OF s22_tb IS
    COMPONENT s22 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            crc : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            done : OUT STD_LOGIC
        );
    END COMPONENT s22;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, start : STD_LOGIC := '0';
    SIGNAL din : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL crc : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL done : STD_LOGIC := '0';

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s22
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        din => din,
        crc => crc,
        done => done);

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        din <= x"a4";
        reset <= '0';
        start <= '0';
        WAIT FOR clk_period * 3;
        start <= '1';
        WAIT FOR clk_period;
        start <= '0';
        WAIT FOR clk_period * 15;
        WAIT;
    END PROCESS stim_p;

END Behavioral;