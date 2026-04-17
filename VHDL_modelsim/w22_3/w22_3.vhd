LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY w22_3 IS
    PORT (
        clk : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END w22_3;

ARCHITECTURE bhv OF w22_3 IS

    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL a, b, c, d, e : STD_LOGIC := '0';

BEGIN

    a <= (NOT q(3)) AND q(2) AND q(1) AND q(0);
    b <= (NOT q(0)) AND a;
    c <= q(3) AND a;
    d <= q(2) AND a;
    e <= q(1) AND a;
    y(0) <= q(3);
    y(1) <= q(2);
    y(2) <= q(1);
    y(3) <= q(0);
    --flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= e;
            q(1) <= d;
            q(2) <= c;
            q(3) <= b;
        END IF;
    END PROCESS;

END bhv; -- bhv