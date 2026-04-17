----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2026 05:36:33 PM
-- Design Name: 
-- Module Name: w22_2b_tb - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity w22_2b_tb is
end entity;

architecture bhv of w22_2b_tb is
    component w22_2b is
        port (
            clk : in std_logic;
            b : in std_logic_vector(1 downto 0);
            y : out std_logic
        );
    end component w22_2b;
    signal clk, y : std_logic := '0';
    signal b : std_logic_vector(1 downto 0) := (others => '0');
    constant clk_period : time := 10 ns;
begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : w22_2b
        port map(
            clk => clk,
            b => b,
            y => y
        );

    --stimulus process 
    stim_p : process 
    begin 
        b <= "11"; 
        wait for clk_period * 20; 
        b <= "10"; 
        wait for clk_period * 20; 


        wait; 
    end process stim_p; 
end bhv; -- bhv