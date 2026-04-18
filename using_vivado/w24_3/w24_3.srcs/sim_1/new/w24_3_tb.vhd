----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2026 09:02:16 PM
-- Design Name: 
-- Module Name: w24_3_tb - Behavioral
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

ENTITY w24_3_tb IS
END w24_3_tb;

ARCHITECTURE behavioral OF w24_3_tb IS
    COMPONENT w24_3 IS
        PORT (
            clk : IN STD_LOGIC;
            sel : IN STD_LOGIC;
            d_in : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
        );
    END COMPONENT w24_3;
    SIGNAL clk, sel, d_in : STD_LOGIC := '0';
    SIGNAL y : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
    CONSTANT clk_period : TIME := 10 ns;
    signal d_in2 : std_logic_vector(7 downto 0) := x"f7"; 
BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : w24_3
    PORT MAP(
        clk => clk,
        sel => sel,
        d_in => d_in,
        y => y
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        sel <= '0'; 
        for k in 0 to 7 loop 
            d_in <= d_in2(k); 
            wait for clk_period; 
        end loop; 

        sel <= '1'; 
        for k in 0 to 7 loop 
            d_in <= d_in2(k); 
            wait for clk_period; 
        end loop;

    END PROCESS stim_p;
END behavioral; -- behavioral
