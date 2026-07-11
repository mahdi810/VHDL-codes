LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23 IS
    PORT (
        clk : IN STD_LOGIC;
        u1 : IN STD_LOGIC;
        u0 : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s23 IS
    SIGNAL x1, x0 : STD_LOGIC := '0';
    SIGNAL x1_n, x0_n : STD_LOGIC := '0';
    SIGNAL y_in : STD_LOGIC := '0';
BEGIN

    -- sequential process
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            x1 <= x1_n;
            x0 <= x0_n;
        END IF;
    END PROCESS;

    x1_n <= x1 XOR x0;
    x0_n <= NOT x0;

    -- output logic
    y_in <= (u1 AND NOT x1) OR ((u0 AND NOT x0) AND (NOT x1 OR u1));

    y <= y_in;

END ARCHITECTURE behavioral;