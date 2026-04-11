----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2026 10:51:18 PM
-- Design Name: 
-- Module Name: w16_1b_tb - Behavioral
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


entity w16_1b_tb is
--  Port ( );
end w16_1b_tb;

architecture Behavioral of w16_1b_tb is
    component w16_1b is
    Port ( clk : in std_logic; 
         u : in std_logic; 
         x : out std_logic_vector(1 downto 0) );
    end component w16_1b;
    signal clk, u : std_logic := '0';
    signal x : std_logic_vector(1 downto 0) := (others => '0');  
    constant clk_period : time := 10 ns; 
    
begin
    
    -- clock generation 
    clk <= NOT clk after clk_period/2; 
    
    --unit under test 
    uut : entity work.w16_1b 
    port map(clk => clk, 
             u => u,
             x => x ); 
             
    --stimulus process 
    stim_p : process 
    begin 
        u <= '0'; 
        for k in 0 to 10 loop
        wait for clk_period; 
        end loop; 
        
        u <= '1'; 
        for k in 0 to 10 loop
        wait for clk_period; 
        end loop;  
        
         
        wait; 
    end process stim_p; 
    

end Behavioral;









