LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s22_3a IS
    PORT (
        clk : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s22_3a IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"6";
    SIGNAL a, b, c, d, e : STD_LOGIC;
BEGIN

    --flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= a;
            q(1) <= b;
            q(2) <= c;
            q(3) <= d;
        END IF;
    END PROCESS ff;

    --combinational process
    a <= (NOT q(3)) AND e;
    b <= q(0) AND e;
    c <= q(1) AND e;
    d <= q(2) AND e;
    e <= NOT (q(3) AND q(3)) AND q(2) AND q(1) AND (NOT q(0));

    --the output 
    y <= q;

END ARCHITECTURE behavioral;