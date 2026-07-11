LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25 IS
    PORT (
        clk : IN STD_LOGIC;
        mod_d : IN STD_LOGIC;
        start : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s25 IS
    SIGNAL x1, x0 : STD_LOGIC := '0';
    SIGNAL x1_n, x0_n : STD_LOGIC := '0';
    SIGNAL y_in : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
BEGIN

    -- sequential process
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            x1 <= x1_n;
            x0 <= x0_n;
        END IF;
    END PROCESS;

    x1_n <= ((start AND mod_d) AND (x1 XNOR x0)) OR ((start AND (NOT mod_d)) AND (x1 XOR x0));
    -- x1_n <= start AND (x0 XOR x1);
    x0_n <= start AND (NOT x0);

    -- output logic
    y_in(0) <= x1 OR x0;
    y_in(1) <= x1;
    y_in(2) <= x0 AND x1;

    y <= y_in;

END ARCHITECTURE behavioral;