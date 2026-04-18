LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY w24_3 IS
    PORT (
        clk : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        d_in : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END w24_3;

ARCHITECTURE behavioral OF w24_3 IS
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL a, b, c, d, e, f, g, h, i, j, k, l : STD_LOGIC := '0';

BEGIN

    y(0) <= q(0);
    y(1) <= q(1);
    y(2) <= q(2);
    y(3) <= q(3);
    y(4) <= q(4);

    a <= q(0) AND (NOT sel);
    b <= d_in AND sel;
    c <= a OR b;

    d <= q(1) AND (NOT sel);
    e <= q(0) AND sel;
    f <= d OR e;

    g <= q(2) AND (NOT sel);
    h <= q(1) AND sel;
    i <= g OR h;

    j <= q(3) AND (NOT sel);
    k <= q(2) AND sel;
    l <= j OR k;

    --flipflops
    ffs : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= d_in;
            q(1) <= c;
            q(2) <= f;
            q(3) <= i;
            q(4) <= l;
        END IF;
    END PROCESS;
END behavioral; -- behavioral