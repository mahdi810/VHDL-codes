----------------------------------------------------------------------------------
-- Company: HS Bremerhaven 
-- Engineer: M.Mahdi Mohammadi 
-- 
-- Create Date: 04/09/2026 07:36:16 PM
-- Design Name: 
-- Module Name: w16_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: question No. 2, winter semester 2016
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


entity w16_1_tb is
end w16_1_tb;

architecture Behavioral of w16_1_tb is
    component w16_1 is
      Port ( clk, reset : in std_logic;
             L : in std_logic_vector(8 downto 0); 
             a : out std_logic_vector(2 downto 0); 
             k : out std_logic_vector(2 downto 0));
    end component w16_1;
    signal clk, reset : std_logic := '0'; 
    signal a, k : std_logic_vector(2 downto 0) := (others => '0'); 
    signal L : std_logic_vector(8 downto 0) := (others => '0'); 
    constant clk_period : time := 10 ns; 
    
begin

    --clock generation 
    clk <= NOT clk after clk_period/2; 
    
    --unit under test 
    uut : entity work.w16_1
        port map( clk => clk, 
                  L => L, 
                  reset => reset, 
                  a => a, 
                  k => k);
                  
                  
    --stimulus process 
    stim_p : process 
    begin 
        reset <= '1'; 
        L <= x"00" & '0'; 
        wait for clk_period * 3; 
        L <= x"00" & '1'; 
        wait for clk_period; 
        L <= x"10" & '0';  
        wait for clk_period; 
        L <= x"60" & '0'; 
        wait for clk_period; 
                  
    
        wait; 
    end process stim_p; 



    
end Behavioral;
