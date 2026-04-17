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
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity w14_st2 is
    port (
        clk, s : in std_logic;
        x : out std_logic_vector(1 downto 0));
end w14_st2;

architecture Behavioral of w14_st2 is
    signal q : std_logic_vector(3 downto 0) := "0000";
    signal a, b, c, d, e, f : std_logic := '0';
    signal count : std_logic_vector(1 downto 0) := "00";
begin
    x(1) <= q(1);
    x(0) <= q(0);
    f <= q(3) and (not q(2));
    e <= f xor q(0);

    a <= (not f) and q(1);
    b <= q(1) and (not q(0));
    c <= f and (not q(1)) and q(0);
    d <= a or b or c;

    --flipflops 
    ffs : process (clk)
    begin
        if clk'event and clk = '1' then
            q(1) <= d;
            q(0) <= e;
            q(2) <= q(3);
            q(3) <= s;
        end if;
    end process ffs;

end Behavioral;