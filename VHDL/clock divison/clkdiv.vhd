----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2026 11:30:02 PM
-- Design Name: 
-- Module Name: clkdiv - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: using this module you are able to divide the input clock using the following formula: 
-- clk_out = clk / (2 * (max_count + 1))
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

entity clkdiv is
    port (
        clk : in std_logic;
        reset : in std_logic;
        clk_out : out std_logic
    );
end clkdiv;

architecture Behavioral of clkdiv is
    constant max_count : integer := 5;
    signal clk_outi : std_logic := '0';
begin

    clkdiv_p : process (clk, reset)
        variable cnt : integer := max_count;
    begin
        if rising_edge(clk) then
            if reset = '1' then
                clk_outi <= '0';
                cnt := max_count;
            else
                if cnt = 0 then
                    clk_outi <= not clk_outi;
                    cnt := max_count;
                else
                    cnt := cnt - 1;
                end if;
            end if;
        end if;
    end process clkdiv_p;

    clk_out <= clk_outi;

end Behavioral;