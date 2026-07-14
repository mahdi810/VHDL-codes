-- K. Mueller, 19-APR-2020
-- AND gate in VHDL

library ieee;
use ieee.std_logic_1164.all;

entity vand is
	port ( a : in std_logic;
		   b : in std_logic;
		   x : out std_logic);
end vand;

architecture structural of vand is
BEGIN
	x <= a AND b;
END structural;
