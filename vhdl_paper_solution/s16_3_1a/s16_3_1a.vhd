--s16_2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_3_1a IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_3_1a IS
    SIGNAL q : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL a, b, c, d, e, f, g : STD_LOGIC;
BEGIN

    --combinational logic 
    a <= u OR q(1);
    b <= q(1) OR q(0);
    c <= (NOT u) OR (NOT q(1)) OR (NOT q(0));
    d <= a AND b AND c;

    e <= (NOT u) AND q(0);
    f <= u AND (NOT q(0));
    g <= e OR f;

    -- outputs 
    x <= q;

    --flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= g;
            q(1) <= d;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;