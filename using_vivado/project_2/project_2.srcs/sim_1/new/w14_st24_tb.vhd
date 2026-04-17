----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2026 04:55:43 PM
-- Design Name: 
-- Module Name: w14_st24_tb - Behavioral
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

entity w14_st24_tb is
end w14_st24_tb;

architecture bhv of w14_st24_tb is

    component w14_st24 is
        port (
            clk, reset, camshaft : in std_logic;
            inject, spark : out std_logic
        );
    end component w14_st24;
    signal clk, reset, camshaft, inject, spark : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit undert test 
    uut : entity work.w14_st24
        port map(
            clk => clk,
            reset => reset,
            camshaft => camshaft,
            inject => inject,
            spark => spark
        );

    --stimulus process 
    stim_p : process 
    begin
        reset <= '1'; 
        camshaft <= '0';
        wait for 1 ms;
        reset <= '0'; 
        wait for 1 ms; 
        for k in 0 to 3 loop 
            camshaft <= '1'; 
            wait for 10 ms; 
            camshaft <= '0'; 
            wait for 10 ms; 
        end loop; 


        wait; 
    end process;

end bhv; -- bhv