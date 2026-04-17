----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2026 03:23:57 PM
-- Design Name: 
-- Module Name: w14_st2_bhv - Behavioral
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

entity w14_st2_bhv is
    port (
        clk, s : in std_logic;
        count : out std_logic_vector(1 downto 0));
end w14_st2_bhv;

architecture Behavioral of w14_st2_bhv is
    signal count_out : integer range 0 to 3 := 0;
    signal s0, s1 : std_logic := '0';
    signal s_rise : std_logic;
begin

    process0 : process (clk, s0, s1, count_out)
    begin
        if rising_edge(clk) then
            s0 <= s;
            s1 <= s0;
            -- correct rising edge detection
            if (s0 = '1' and s1 = '0') then
                if count_out = 3 then
                    count_out <= 0;
                else
                    count_out <= count_out + 1;
                end if;
            end if;

        end if;
    end process process0;

    count <= std_logic_vector(to_unsigned(count_out, count'length));

end Behavioral;