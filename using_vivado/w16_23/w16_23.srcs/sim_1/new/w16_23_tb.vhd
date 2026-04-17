----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2026 02:24:53 PM
-- Design Name: 
-- Module Name: w16_23_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: for increasing the frequency the number clock cycles 
--that the signal incre should on '1' is at least more than max_cout. 
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

entity w16_23_tb is
end w16_23_tb;

architecture bhv of w16_23_tb is
    component w16_23_tb is
        port (
            clk, reset, incr, start, stop : in std_logic;
            clk_out : out std_logic
        );
    end component w16_23_tb;
    signal clk, reset, incr, start, stop, clk_out : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

    --clock generation 
    clk_p : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    --unit under test 
    uut : entity work.w16_23
        port map(
            clk => clk,
            reset => reset,
            incr => incr,
            start => start,
            stop => stop,
            clk_out => clk_out
        );

    --stimulus process 
    stim_p : process 
    begin
        reset <= '1'; 
        start <= '0'; 
        stop <= '0';
        incr <= '0'; 
        wait for clk_period * 3; 
        reset <= '0'; 
        wait for clk_period * 2; 
        start <= '1'; 
        wait for clk_period * 10; 
        start <= '0'; 
        wait for clk_period * 400; 
        incr <= '1'; 
        wait for clk_period * 50; 
        incr <= '0'; 
        wait for clk_period * 400;
        stop <= '1'; 
        wait for clk_period * 50; 
        stop <= '0';
        wait for clk_period * 100;   


        wait; 
    end process;

end bhv; -- bhv