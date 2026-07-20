LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY zerocross_tb IS
END zerocross_tb;

ARCHITECTURE behavioral OF zerocross_tb IS
	COMPONENT zerocross IS
		PORT (
			clk, resetn, start : IN STD_LOGIC;
			done : OUT STD_LOGIC;
			rightv, leftv : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			newx, newy : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT zerocross;
	SIGNAL clk, start : STD_LOGIC := '0';
	SIGNAL resetn : STD_LOGIC := '1';
	SIGNAL done : STD_LOGIC;
	SIGNAL rightv, leftv : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL newx, newy : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

	--signals for the clock generation 
	CONSTANT clk_period : TIME := 10 ns;

BEGIN
	--clock generation 
	clk <= NOT clk AFTER clk_period/2;

	--unit under test 
	uut : zerocross
	PORT MAP(
		clk => clk,
		resetn => resetn,
		start => start,
		done => done,
		rightv => rightv,
		leftv => leftv,
		newx => newx,
		newy => newy
	);

	--stimulus process 
	stim_p : PROCESS
	BEGIN
		rightv <= STD_LOGIC_VECTOR(to_signed(4096, 16));
		leftv <= STD_LOGIC_VECTOR(to_signed(-4096, 16));
		
		-- reset pulse
		resetn <= '0';
		WAIT FOR clk_period * 2;
		resetn <= '1';
		WAIT FOR clk_period;
		
		start <= '1'; 
		resetn <= '1'; 
		wait for clk_period; 
		start <= '0';
		WAIT FOR clk_period * 200;
		
		
		WAIT;
	END PROCESS stim_p;
END behavioral;