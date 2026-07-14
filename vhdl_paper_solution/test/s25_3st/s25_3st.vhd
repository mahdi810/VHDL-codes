-- description : the counter is going to normally count from 0 to 3 and back, but if the sequence "010" occures, then it is going to stop the count. 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY s25_3st IS
	PORT (
		d_in : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE behavioral OF s25_3st IS
	SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	SIGNAL a, b, c, d, e, f, g, h : STD_LOGIC;
BEGIN

	-- ff 
	ff : PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			q(0) <= g;
			q(1) <= d;
			q(2) <= q(3);
			q(3) <= q(4);
			q(4) <= d_in;
		END IF;
	END PROCESS ff;

	--combinational logic 
	a <= (NOT h) AND q(1);
	b <= q(1) AND (NOT q(0));
	c <= h AND (NOT q(1)) AND q(0);
	d <= a OR c OR c;

	e <= (NOT h) AND q(0);
	f <= h AND (NOT q(0));
	g <= e OR f;

	h <= (NOT q(4)) AND q(3) AND (NOT q(2));

	y <= q(1 DOWNTO 0);

END behavioral;