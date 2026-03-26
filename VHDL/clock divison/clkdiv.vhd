----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2026 08:56:59 AM
-- Design Name: 
-- Module Name: clkdiv - Behavioral
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
use ieee.numeric_std.all;

entity clkdiv is
    port (
        clk : in std_logic;
        reset : in std_logic;
        clk_out : out std_logic);
end clkdiv;

architecture Behavioral of clkdiv is
    signal clk_outi : std_logic := '0';
    constant max_count : integer := 4;

begin
    clk_div : process (clk, reset)
        variable cnt : integer range 0 to max_count;
    begin
        if rising_edge(clk) then
            if reset = '1' then
                cnt := 0;
                clk_outi <= '0';
            else
                if cnt = 0 then
                    clk_outi <= not clk_outi;
                    cnt := max_count;
                else
                    cnt := cnt - 1;
                end if;
            end if;
        end if;
    end process clk_div;
    clk_out <= clk_outi;

end Behavioral;