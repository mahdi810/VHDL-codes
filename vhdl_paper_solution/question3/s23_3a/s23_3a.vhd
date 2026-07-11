
-- s23_3 structural implementation 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_3a IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s23_3a IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL a, b, c : STD_LOGIC;

BEGIN

    --flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(2) <= a;
            q(1) <= b;
            q(0) <= c;
        END IF;
    END PROCESS ff;

    --combinational logic 
    a <= (u AND x(2)) OR ((NOT u) AND ((q(2) AND (NOT q(1)) AND (NOT q(0))) OR ((NOT q(2) AND q(0))) OR ((NOT q(2)) AND q(1))));
    b <= (u AND x(1)) OR ((NOT u) AND (q(1) XOR q(0)));
    c <= (u AND x(0)) OR ((NOT u) AND q(0));

    --output combination logic 
    y <= q;

END ARCHITECTURE behavioral;