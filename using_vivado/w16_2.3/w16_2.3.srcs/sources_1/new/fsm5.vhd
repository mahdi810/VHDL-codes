----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2026 11:38:26 PM
-- Design Name: 
-- Module Name: fsm5 - Behavioral
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

entity fsm5 is
  Port ( 
        clk, s : in std_logic; 
        xy : out std_logic_vector(1 downto 0) );
end fsm5;

architecture Behavioral of fsm5 is
    signal q : std_logic_vector( 3 downto 0) := "0000";
    signal a, b, c, d, e, f, g, h, i, j, k, l : std_logic := '0';  
begin
    xy(0) <= q(1); 
    xy(1) <= q(0);  
    a <= (NOT s) AND q(0); 
    b <= s AND q(2); 
    c <= a OR b; 
    d <= (NOT s) AND q(3); 
    e <= s AND q(1); 
    f <= d OR e; 
    g <= (NOT s) AND q(2); 
    h <= s AND q(0); 
    i <= g OR h; 
    j <= (NOT s) AND q(1); 
    k <= s AND q(3); 
    l <= j OR k; 
    
    --flipflop 
    ff : process(clk)
    begin 
        if rising_edge(clk) then 
            q(0) <= l; 
            q(1) <= i; 
            q(2) <= f; 
            q(3) <= c; 
        end if; 
    end process ff;   
    
    

end Behavioral;
