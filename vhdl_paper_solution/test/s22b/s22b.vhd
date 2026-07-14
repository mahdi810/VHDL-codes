LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s22b IS
    PORT (
        clk : STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END s22b;

ARCHITECTURE behavioral OF s22b IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";

BEGIN
    -- PROCESS
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF q = "1110" THEN
                q <= (OTHERS => '0');
            ELSE
                IF q(3) = '1' THEN
                    q <= q(2 DOWNTO 0) & '1';
                ELSE
                    q <= q(2 DOWNTO 0) & '1';
                END IF;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- seq_p : PROCESS (clk)
    -- BEGIN
    --     IF rising_edge(clk) THEN
    --         IF q(3) = '0' THEN
    --             q <= q(2 DOWNTO 0) & '1';
    --         ELSE
    --             q <= q(2 DOWNTO 0) & '0';
    --         END IF;
    --     END IF;
    -- END PROCESS seq_p;

    y <= q;

END ARCHITECTURE behavioral;