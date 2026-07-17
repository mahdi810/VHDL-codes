----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2026 12:02:00 AM
-- Design Name: 
-- Module Name: s23_tb - Behavioral
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

entity s23_tb is
end s23_tb;

architecture Behavioral of s23_tb is
    component s23 is 
        Port (
            clk : in std_logic; 
            start : in std_logic; 
            reset : in std_logic; 
            data_in : in std_logic_vector(7 downto 0); 
            y_out : out std_logic
         );
    end component s23; 
    signal clk : std_logic := '0'; 
    signal start, reset, y_out : std_logic; 
    signal data_in : std_logic_vector(7 downto 0); 
    
    constant clk_period : time := 10 ns;  
begin

    -- clk generation 
    clk <= NOT clk after clk_period/2; 
    
    -- unit under test 
    uut : s23 
    port map(
        clk => clk, 
        reset => reset, 
        start => start, 
        data_in => data_in, 
        y_out => y_out
    ); 
    
    -- stimulus process 
    stim_p : process
    begin 
        reset <= '0'; 
        start <= '0';
        data_in <= x"df";  
        wait for clk_period; 
        start <= '1';
        wait for clk_period; 
        start <= '0';  
        wait for clk_period * 10; 
        
        
        
        wait; 
    end process stim_p; 


end Behavioral;
