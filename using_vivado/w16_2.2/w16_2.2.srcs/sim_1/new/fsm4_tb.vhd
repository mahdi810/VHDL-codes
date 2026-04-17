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

entity fsm4_tb is 
end fsm4_tb;

architecture behavioral of fsm4_tb is 
    signal clk : std_logic := '0'; 
    signal d : std_logic := '0'; 
    signal pha, phb : std_logic; 
    constant clk_period : time := 10 ns;

    component fsm4 is 
        port(
            clk : in std_logic; 
            d : in std_logic; 
            pha, phb : out std_logic
        ); 
    end component;
begin 

    --unit under test 
    uut: fsm4 port map (
        clk => clk, 
        d => d, 
        pha => pha, 
        phb => phb
    );

    --clock generation 
    clk <= NOT clk after clk_period/2;

    --stimulus process
    stimulus: process
    begin
        d <= '0';
        wait for clk_period * 10;
        d <= '1'; 
        wait for clk_period * 10; 

        wait; 
    end process stimulus; 

end behavioral;