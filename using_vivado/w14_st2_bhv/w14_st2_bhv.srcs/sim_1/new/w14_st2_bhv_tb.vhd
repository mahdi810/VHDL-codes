----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2026 09:25:39 AM
-- Design Name: 
-- Module Name: w14_st2_bhv_tb - Behavioral
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

entity w14_st2_bhv_tb is
end w14_st2_bhv_tb;

architecture Behavioral of w14_st2_bhv_tb is
	component w14_st2_bhv is
		port (
			clk, s : in std_logic;
			count : out std_logic_vector(1 downto 0));
	end component w14_st2_bhv;
	signal clk, s : std_logic := '0';
	signal count : std_logic_vector(1 downto 0) := "00";
	constant clk_period : time := 10 ns;
begin

	--clock generation 
	clk <= not clk after clk_period/2;

	--unit under test 
	uut : w14_st2_bhv
	port map
	(
		clk => clk,
		s => s,
		count => count);

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