----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2026 11:30:21 PM
-- Design Name: 
-- Module Name: clkdiv_tb - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity clkdiv_tb is
end clkdiv_tb;

architecture Behavioral of clkdiv_tb is
    component clkdiv is
        port (
            clk : in std_logic;
            reset : in std_logic;
            clk_out : out std_logic
        );
    end component clkdiv;
    signal clk, clk_out, reset : std_logic := '0';
    signal clk_period : time := 10 ns;
begin

    --clock generation 
    clk_p : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process clk_p;

    uut : clkdiv
    port map(
        clk => clk,
        clk_out => clk_out,
        reset => reset);

    stim_p : process
    begin
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period * 20;

        wait;
    end process stim_p;

end Behavioral;