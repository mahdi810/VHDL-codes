----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2026 03:24:11 PM
-- Design Name: 
-- Module Name: w14_st2_tb - Behavioral
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

entity w14_st2_tb is
end w14_st2_tb;

architecture Behavioral of w14_st2_tb is
	component w14_st2 is
		port (
			clk, s : in std_logic;
			x : out std_logic_vector(1 downto 0));
	end component w14_st2;
	signal clk, s : std_logic := '0';
	signal x : std_logic_vector(1 downto 0) := "00";
	constant clk_period : time := 10 ns;
begin

	--clock generation 
	clk <= not clk after clk_period/2;

	--unit under test 
	uut : w14_st2
	port map
	(
		clk => clk,
		s => s,
		x => x);

	--stimulus process 
	stim_p : process
	begin
		for k in 0 to 10 loop
			s <= '0';
			wait for clk_period;
			s <= '1';
			wait for clk_period;
		end loop;

		wait for clk_period * 5; 
		s <= '1'; 
		wait for clk_period * 10; 
		s <= '0'; 
		wait for clk_period * 10;

		wait;
	end process stim_p;

end Behavioral;