----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2026 05:32:04 PM
-- Design Name: 
-- Module Name: s21_tb - Behavioral
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

ENTITY s21_tb IS
END ENTITY s21_tb;

ARCHITECTURE behavioral OF s21_tb IS
    COMPONENT s21 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            x_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            xmin : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            xmax : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            done : OUT STD_LOGIC
        );
    END COMPONENT s21;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, start : STD_LOGIC;
    SIGNAL x_in : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
    SIGNAL xmin, xmax : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
    SIGNAL done : STD_LOGIC := '0';

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s21
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        x_in => x_in,
        xmin => xmin,
        xmax => xmax,
        done => done
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        start <= '0';
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(10, x_in'length));
        WAIT FOR clk_period;
        start <= '1';
        x_in <= STD_LOGIC_VECTOR(to_signed(23, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(2, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(6, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(8, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(9, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(12, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(14, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(45, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(67, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(87, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(45, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(23, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(-12, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(200, x_in'length));
        WAIT FOR clk_period;
        start <= '0';
        x_in <= STD_LOGIC_VECTOR(to_signed(24, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(98, x_in'length));
        WAIT FOR clk_period;
        x_in <= STD_LOGIC_VECTOR(to_signed(34, x_in'length));
        WAIT FOR clk_period;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;