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
ENTITY cube_tb IS
END cube_tb;

ARCHITECTURE Behavioral OF cube_tb IS
    COMPONENT cube IS
        PORT (
            clk, resetn, start : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            u : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT cube;
    SIGNAL clk, start, done : STD_LOGIC := '0';
    SIGNAL resetn : STD_LOGIC := '1';
    SIGNAL u : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL y : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : cube
    PORT MAP(
        clk => clk,
        resetn => resetn,
        start => start,
        done => done,
        u => u,
        y => y);

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        start <= '1';
        resetn <= '1';
        u <= STD_LOGIC_VECTOR(to_signed(16384, 16));
        WAIT FOR clk_period * 40;

        WAIT;
    END PROCESS stim_p;

END Behavioral;