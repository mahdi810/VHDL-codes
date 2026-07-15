-- this circuit is a pattern detector, and detects how many times the pattern "010" appears in the input stream.
-- this is the structural implementation of the circuit.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY s25_3st IS
	PORT (
		clk : IN STD_LOGIC;
		d_in : IN STD_LOGIC;
		y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE structural OF s25_3st IS
	SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	SIGNAL a, b, c, d, e, f, g, h : STD_LOGIC;
BEGIN

	-- sequential circuits 
	ff : PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			q(4) <= d_in;
			q(3) <= q(4);
			q(2) <= q(3);
			q(1) <= e;
			q(0) <= h;
		END IF;
	END PROCESS ff;

	-- combinational circuits
	a <= (NOT q(4)) AND q(3) AND (NOT q(2));
	b <= (NOT a) AND q(1);
	c <= q(1) AND (NOT q(0));
	d <= a AND (NOT q(1)) AND q(0);
	e <= b OR c OR d;

	f <= (NOT a) AND q(0);
	g <= a AND (NOT q(0));
	h <= f OR g;

	-- outputs 
	y <= q(1 DOWNTO 0);
END ARCHITECTURE structural;