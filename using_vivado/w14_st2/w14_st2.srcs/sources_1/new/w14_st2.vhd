----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2026 03:23:57 PM
-- Design Name: 
-- Module Name: w14_st2 - Behavioral
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

entity w14_st2 is
  Port (
        clk, s : in std_logic; 
        x : out std_logic_vector(1 downto 0) );
end w14_st2;

architecture Behavioral of w14_st2 is
    signal q : std_logic_vector(3 downto 0) := "0000"; 
    signal a, b, c, d, e, f : std_logic := '0' ;
    signal count : std_logic_vector(1 downto 0) := "00"; 
begin
    x(1) <= q(0); 
    x(0) <= q(1); 
    f <= q(3) AND (NOT q(2)); 
    e <= f XOR q(1); 
    
    a <= (NOT f) AND q(0); 
    b <= q(0) AND (NOT q(1)); 
    c <= f AND (NOT q(0)) AND q(1); 
    d <= a OR b OR c; 
    
    --flipflops 
    ffs : process(clk) 
    begin 
        if clk'event AND clk = '1' then 
            q(0) <= d; 
            q(1) <= e; 
            q(2) <= q(3); 
            q(3) <= s; 
        end if; 
    end process ffs; 

end Behavioral;











