LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s22 IS
    PORT (
        clk : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s22 IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL a : STD_LOGIC := '0';
BEGIN
    --process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF a = '0' THEN
                q <= (OTHERS => '0');
            ELSE
                q(0) <= a AND (NOT q(3));
                q(1) <= q(0) AND a;
                q(2) <= q(1) AND a;
                q(3) <= q(2) AND a;
            END IF;
        END IF;
    END PROCESS;

    a <= (NOT q(0)) AND q(1) AND q(2) AND q(3);
END ARCHITECTURE behavioral;