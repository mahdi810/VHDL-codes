LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25_3 IS
    PORT (
        clk : IN STD_LOGIC;
        d_in : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s25_3 IS

    -- q(4), q(3), q(2) are the three upper flip-flops
    -- q(1), q(0) are the 2-bit counter outputs: y1, y0
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";

    SIGNAL a : STD_LOGIC;
    SIGNAL b : STD_LOGIC;
    SIGNAL c : STD_LOGIC;
    SIGNAL d : STD_LOGIC;
    SIGNAL e : STD_LOGIC;
    SIGNAL f : STD_LOGIC;
    SIGNAL g : STD_LOGIC;
    SIGNAL x : STD_LOGIC;

BEGIN

    x <= (NOT q(4)) AND q(3) AND (NOT q(2));

    --------------------------------------------------------------------
    -- Combinational Circuits 
    --------------------------------------------------------------------
    a <= (NOT x) AND q(1);
    b <= q(1) AND (NOT q(0));
    c <= x AND (NOT q(1)) AND q(0);

    e <= (NOT x) AND q(0);
    f <= x AND (NOT q(0));

    d <= a OR b OR c;
    g <= e OR f;
    --------------------------------------------------------------------
    -- Flip-flops
    --------------------------------------------------------------------
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            --upper part 
            q(2) <= q(3);
            q(3) <= q(4);
            q(4) <= d_in;

            -- 2-bit counter
            q(1) <= d;
            q(0) <= g;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- Outputs
    --------------------------------------------------------------------
    y <= q(1 DOWNTO 0);

END ARCHITECTURE behavioral;