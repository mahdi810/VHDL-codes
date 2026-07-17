----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2026 11:28:45 AM
-- Design Name: 
-- Module Name: s14_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity s14_tb is
end s14_tb;

architecture Behavioral of s14_tb is
    component s14 is 
        port(
            clk : in std_logic; 
            reset : in std_logic; 
            ss : in std_logic; 
            s1, s2, s3 : out std_logic
        ); 
    end component s14; 
    signal clk : std_logic := '0'; 
    signal reset, ss : std_logic; 
    signal s1, s2, s3 : std_logic := '0';  
    
    constant clk_period : time := 10 ns; 

begin

    -- clock generation 
    clk <= NOT clk after clk_period/2; 
    
    -- uni under test 
    uut : s14 
    port map(clk => clk, 
             reset => reset, 
             ss => ss, 
             s1 => s1, 
             s2 => s2, 
             s3 => s3); 
             
    -- stimulus process 
    stim_p : process
    begin 
        reset <= '1'; 
        ss <= '0'; 
        wait for clk_period; 
        reset <= '0'; 
        wait for clk_period * 4; 
        ss <= '1'; 
        wait for clk_period * 8;
        ss <= '0'; 
        wait for clk_period * 5; 
        ss <= '1';  
        wait for clk_period; 
        ss <= '0'; 
        wait for clk_period; 
        ss <= '1'; 
        
    
    
        wait; 
    end process stim_p; 


end Behavioral;
