-- K. Mueller, 19-APR-2020
-- Test bench for vand

library ieee;
use ieee.std_logic_1164.all;

entity vand_tb is
end vand_tb;

architecture structural of vand_tb is
component vand is
	port ( a : in std_logic;
		   b : in std_logic;
		   x : out std_logic);
end component vand;

signal a : std_logic := '0';
signal b : std_logic := '0';
signal x : std_logic := '0';

constant tdelay : time := 10 ns;

BEGIN

	uut : vand
	PORT MAP ( a => a,
		   	   b => b,
		       x => x );

	stim_p : PROCESS
	BEGIN
		wait for tdelay;
		a <= '1';
		wait for tdelay;
		a <= '0';
		b <= '1';
		wait for tdelay;
		a <= '1';
		wait for tdelay;
		report "Test Bench of vand done.";
		wait;		
	END PROCESS stim_p;
END structural;
