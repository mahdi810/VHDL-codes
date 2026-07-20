----------------------------------------------------------------------------------
-- Engineer: Mohammad Mahdi Mohammadi 
-- Create Date: 06/21/2026 12:12:13 PM
-- Module Name: fib - Behavioral
-- Description: fibunacci numbers accelerated sequence generator 
-- Dependencies: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fib_tb IS
END fib_tb;

ARCHITECTURE behavioral OF fib_tb IS
    COMPONENT fib IS
        PORT (
            clk, resetn, start : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            y_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT fib;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL resetn, start : STD_LOGIC;
    SIGNAL done : STD_LOGIC;
    SIGNAL y_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    --clock generation 
    clk_p : PROCESS
    BEGIN
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
        clk <= '0';
    END PROCESS;

    --unit instantiation 
    fib_inst : ENTITY work.fib
        PORT MAP(
            clk => clk,
            resetn => resetn,
            start => start,
            done => done,
            y_out => y_out
        );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        WAIT FOR clk_period;
        resetn <= '0';
        WAIT FOR clk_period;
        resetn <= '1';

        FOR k IN 0 TO 10 LOOP
            WAIT FOR clk_period;
            start <= '1';
            WAIT FOR clk_period;
            start <= '0';
            WAIT FOR clk_period * 5;
        END LOOP; -- <name>
        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;