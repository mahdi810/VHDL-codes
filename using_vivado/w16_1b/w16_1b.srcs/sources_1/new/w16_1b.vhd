----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2026 10:50:55 PM
-- Design Name: 
-- Module Name: w16_1b - Behavioral
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


entity w16_1b is
  Port ( clk : in std_logic; 
         u : in std_logic; 
         x : out std_logic_vector(1 downto 0) );
end w16_1b;

architecture Behavioral of w16_1b is
    signal q : std_logic_vector(1 downto 0) := "00"; 
    signal a, b, c, d, e, f, g : std_logic := '0';
begin
    
    a <= u OR q(1); 
    b <= q(1) OR q(0); 
    c <= (NOT q(1)) OR (NOT u) OR (NOT q(0)); 
    d <= a AND b AND c; 
    e <= (NOT u) AND q(0); 
    f <= u AND (NOT q(0)); 
    g <= e OR f; 
    x(0) <= q(0); 
    x(1) <= q(1); 
    
    --flipflops 
    ff : process(clk)
    begin 
        if rising_edge(clk) then 
            q(1) <= d; 
            q(0) <= g; 
        end if; 
    end process ff; 

end Behavioral;










