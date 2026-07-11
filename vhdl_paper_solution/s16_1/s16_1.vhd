--s16_1b

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1 IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        xy : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_1 IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"4";

BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF s = '1' THEN
                q <= q(2 DOWNTO 0) & q(3);
            ELSE
                q <= q(0) & q(3 DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;

    -- output logic implementation 
    xy <= q(1 DOWNTO 0);
END ARCHITECTURE behavioral;