----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2026 03:24:11 PM
-- Design Name: 
-- Module Name: w14_st2_tb - Behavioral
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


entity w14_st2_tb is
end w14_st2_tb;

architecture Behavioral of w14_st2_tb is
    component w14_st2 is
      Port (
            clk, s : in std_logic; 
            x : out std_logic_vector(1 downto 0) );
    end component w14_st2;
    signal clk, s : std_logic := '0'; 
    signal x : std_logic_vector(1 downto 0) := "00";
    constant clk_period : time := 10 ns; 
begin

    --clock generation 
    clk <= NOT clk after clk_period/2; 
    
    --unit under test 
    uut : w14_st2
    port map(clk => clk, 
             s => s, 
             x => x); 
             
    --stimulus process 
    stim_p : process 
    begin 
        for k in 0 to 10 loop 
            s <= '0'; 
            wait for clk_period; 
            s <= '1'; 
            wait for clk_period; 
        end loop; 
        
    
        wait; 
    end process stim_p; 

end Behavioral;
