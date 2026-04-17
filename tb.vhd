----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2026 03:24:11 PM
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
end tb;

architecture Behavioral of tb is
	


    signal clk : std_logic := '0'; 
	constant clk_period : time := 10 ns;
begin

	--clock generation 
	clk <= not clk after clk_period/2;

	--unit under test 
	

	--stimulus process 
	stim_p : process
	begin
		

		wait;
	end process stim_p;

end Behavioral;