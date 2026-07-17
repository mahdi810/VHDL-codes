----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2026 12:04:28 AM
-- Design Name: 
-- Module Name: s16_1_tb - Behavioral
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

ENTITY s16_1_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s16_1_tb IS
    COMPONENT s16_1 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            txdata : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
            TxD : OUT STD_LOGIC;
            done : OUT STD_LOGIC
        );
    END COMPONENT s16_1;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, start, done, TxD : STD_LOGIC;
    SIGNAL txdata : STD_LOGIC_VECTOR(6 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s16_1
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        txdata => txdata,
        TxD => TxD,
        done => done
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        start <= '1';
        txdata <= "0101011";
        WAIT FOR clk_period;
        start <= '0';
        WAIT FOR clk_period * 10;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;