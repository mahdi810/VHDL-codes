----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2026 11:30:21 PM
-- Design Name: 
-- Module Name: clk_div_tb - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

entity clk_div_tb is
end clk_div_tb;

architecture Behavioral of clk_div_tb is
    component clk_div is 
        Port ( clk : in std_logic; 
             reset : in std_logic; 
             clk_out : out std_logic
            );
    end component clk_div; 
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
    
    uut : clk_div 
    port map(
        clk => clk, 
        clk_out => clk_out,  
        reset => reset ); 
        
        
    stim_p : process 
    begin 
        reset <= '1'; 
        wait for clk_period; 
        reset <= '0'; 
        wait for clk_period*20; 
    
    
    
    wait; 
    end process stim_p; 


end Behavioral;
