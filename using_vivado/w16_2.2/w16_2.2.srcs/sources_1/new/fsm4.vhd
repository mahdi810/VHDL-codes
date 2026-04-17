----------------------------------------------------------------------------------
-- Company: HS Bremerhaven 
-- Engineer: Mohammad Mahdi Mohammadi 
-- 
-- Create Date: 04/13/2026 03:05:38 PM
-- Design Name: 
-- Module Name: fsm4 - Behavioral
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

entity fsm4 is 
    port(
        clk : in std_logic; 
        d : in std_logic; 
        pha, phb : out std_logic
    ); 
end fsm4;

architecture structural of fsm4 is 
    signal q : std_logic_vector(1 downto 0) := (others => '0');  
    signal a, b, c, e, f : std_logic := '0'; 
begin 
    
    a <= (NOT d) AND (NOT q(1)) AND q(0); 
    b <= (NOT d) AND (q(1) AND (NOT q(0))); 
    c <= d AND ((NOT q(1)) AND (NOT q(0))); 
    e <= d AND q(1) AND q(0); 
    f <= a OR b OR c OR e; 

    --flipflops 
    ff : process (clk)
    begin
        if rising_edge(clk) then 
            q(1) <= f; 
            q(0) <= NOT q(0);  
        end if; 
    end process;

    --output 
    pha <= NOT q(1); 
    phb <= q(1) XOR q(0); 
end structural; 