LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_3 IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_out : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE behavioral OF s23_3 IS
    SIGNAL x : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
BEGIN

    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            x(0) <= NOT x(0);
            x(1) <= x(0) XOR x(1);
        END IF;
    END PROCESS ff;

    s_out <= (u(1) AND (NOT x(1))) OR (u(1) AND u(0) AND (NOT x(0))) OR (u(0) AND x(0) AND (NOT x(1)));

END ARCHITECTURE behavioral;