LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY w23_3 IS
    PORT (
        clk, u : IN STD_LOGIC;
        x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END w23_3;

ARCHITECTURE structural OF w23_3 IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0'); 
    SIGNAL a, b, c, d, e, f, g, h, i, j, k, l, m, n : STD_LOGIC;
BEGIN

    --combinational 
    y(2) <= q(2);
    y(1) <= q(1);
    y(0) <= q(0);

    a <= u AND x(2);
    b <= (NOT u) AND g;
    c <= a OR b;

    d <= q(2) AND (NOT q(1)) AND (NOT q(0));
    e <= (NOT q(2)) AND q(0);
    f <= (NOT q(2)) AND q(1);
    g <= d OR e OR f;

    h <= u AND x(1);
    i <= (NOT u) AND k;
    j <= h OR i;

    k <= q(1) XOR q(0);

    l <= u AND x(0);
    m <= (NOT u) AND q(0);
    n <= l OR m;

    --flipflops 
    ffs : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(2) <= c;
            q(1) <= j;
            q(0) <= n;
        END IF;
    END PROCESS;
END structural; -- structural