----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2026 08:18:58 PM
-- Design Name: 
-- Module Name: dfilter_tb - Behavioral
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

ENTITY dfilter_tb IS
END dfilter_tb;
ARCHITECTURE behavioral OF dfilter_tb IS
    COMPONENT dfilter IS
        PORT (
            clk, reset, start : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            P : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT dfilter;
    SIGNAL clk, reset, start, done : STD_LOGIC := '0';
    SIGNAL P, Q : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL D : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : ENTITY work.dfilter
        PORT MAP(
            clk => clk,
            reset => reset,
            start => start,
            done => done,
            P => P,
            D => D,
            Q => Q
        );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        WAIT FOR clk_period * 10;

        start <= '1';
        P <= x"08000000";
        D <= x"2666";
        WAIT FOR clk_period * 5;
        start <= '0';

        WAIT;
    END PROCESS;

END behavioral; -- behavioral