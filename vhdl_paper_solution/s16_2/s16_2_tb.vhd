LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY s16_2_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s16_2_tb IS
	COMPONENT s16_2 IS
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			L : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			y : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
		);
	END COMPONENT s16_2;
	SIGNAL clk : STD_LOGIC := '0';
	SIGNAL reset : STD_LOGIC;
	SIGNAL L : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL y : STD_LOGIC_VECTOR(5 DOWNTO 0);

	CONSTANT clk_period : TIME := 10 ns;

BEGIN

	--clock generation 
	clk <= NOT clk AFTER clk_period/2;

	--unit under test 
	uut : s16_2
	PORT MAP(
		clk => clk,
		reset => reset,
		L => L,
		y => y);

	--stimulus process 
	stim_p : PROCESS
	BEGIN
		reset <= '0';
		L <= "000100000";
		WAIT FOR clk_period * 20;

		WAIT;
	END PROCESS stim_p;
END behavioral;